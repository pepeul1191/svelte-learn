<script>
  import axios from 'axios';
  import { onMount } from 'svelte';
  export let label = 'Buscar por texto';
  export let placeholder = 'Ingrese texto';
  export let value;
  export let valueId;
  export let url;
  export let queryParam = 'name';
  export let recordKey = 'id'; // from server
  export let recordValue = 'name'; // from server
  export let hintKey = 'id'; // from client
  export let hintValue = 'name'; // from client
  export let validationMessage = '';
  let validationMessageClass = '';
  let hints = [];
  let displayHints = false;
  let childHintActive = -1;
  let root;
  let ul;

  onMount(() => {
    ul = root.querySelector('ul');
  });

  const search = (event) => {
    validationMessage = '';
    validationMessageClass = '';
    if(value != ''){
      axios.get(`${url}`, {
        params: {
          [queryParam]: value
        }
      })
      .then(function (response) {
        displayHints = true;
        ul.setAttribute('style', `width: ${event.target.offsetWidth}px`);
        hints = [];
        if(response.data.length == 0){
          validationMessage = 'No se encontraron coincidencias';
          validationMessageClass = 'text-warning';
        }else{
          response.data.forEach(record => {
            hints.push({
              [hintKey]: record[recordKey],
              [hintValue]: record[recordValue],
            });
          });
          displayHints = true;
        }
      })
      .catch(function (error) {
        console.log(error);
        validationMessage = 'Ha ocurrido un erro en el servidor';
        validationMessageClass = 'text-danger';
      })
      .then(function () {
        // always executed
      });
    }else{
      ul.classList.add('d-none');
      hints = [];
      displayHints = false;
    }
  };

  const hintClick = (hintKeyP, hintValueP) => {
    // console.log(hintKeyP)
    valueId = hintKeyP;
    value = hintValueP;
    hints = [];
    displayHints = false;
  };

  const focusout = (event) => {
    
  };

  const hintHover = (event) => {
    var target = event.target;
    for(var i = 0; i < ul.childNodes.length; i++){
      if(ul.children[i] == target){
        childHintActive = i;
        ul.children[i].classList.add('active');
      }else{
        ul.children[i].classList.remove('active');
      }
    }
  }

  const keyDown = (event) => {
    switch (event.key) {
      case 'Escape':
        hints = [];
        displayHints = false;
        break;
      case 'ArrowUp':
        // console.log('arriba')
        if(childHintActive >= 1){
          if(childHintActive != -1){
            ul.children[childHintActive].classList.remove('active')
          }
          childHintActive = childHintActive - 1;
          ul.children[childHintActive].classList.add('active');
        }else{
          ul.firstChild.classList.remove('active');
          childHintActive = ul.childNodes.length - 1;
          ul.children[childHintActive].classList.add('active');
        }
        break;
      case 'ArrowDown':
        // console.log('abajo')
        if(childHintActive + 1 < ul.childNodes.length){
          if(childHintActive != -1){
            ul.children[childHintActive].classList.remove('active');
          }
          childHintActive = childHintActive + 1;
          ul.children[childHintActive].classList.add('active');
        }else{
          ul.lastChild.classList.remove('active');
          childHintActive = 0;
          ul.children[childHintActive].classList.add('active');
        }
        break;
      case 'Enter':
        var li = ul.childNodes[childHintActive];
        value = li.innerHTML;
        valueId = li.getAttribute('hint-id');
        hints = [];
        displayHints = false;
        break;
      default:
        break;
    }
  }
</script>
<div bind:this={root}>
  <label for="file" class="{(validationMessageClass != 'text-warning') ? validationMessageClass : ''}">{label}</label>
  <input type="text" class="form-control" placeholder="{placeholder}" bind:value={value} on:keydown={keyDown} on:input="{search}" on:blur="{focusout}">
  <ul class="hint-container {displayHints ? '' : 'd-none'}">
    {#each hints as hint}
      <li hint-id="{hint[hintKey]}" on:click={hintClick(hint[hintKey], hint[hintValue])} on:mousemove={hintHover}>{hint.name}</li>
    {/each}
  </ul>
  <div class="col-sm-12 validation-message">
    <small id="validationHelp" class="{validationMessageClass}">
      {validationMessage}
    </small>
  </div>
</div>

<style>
  .hint-container{ 
    position: absolute;
    position: absolute;
    z-index: 10;
    background: white;
    list-style-type: none;
    padding-left: 12px;
    border-bottom: 1px solid #ccc;
    border-left: 1px solid #ccc;
    border-right: 1px solid #ccc;
    border-top: 0px solid #ccc;
    width: 100%;
    padding-left: 0px;
    padding-right: 0px;
  }

  .hint-container > li {
    padding-left: 10px;
    padding-right: 10px;
    font-weight: 300;
  }

  :global(ul li.active) {
    background: #ccc ;
  }

  li:hover {
    cursor: pointer;
  }
</style>