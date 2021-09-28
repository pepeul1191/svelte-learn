<script>
  import axios from 'axios';
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
  let validationMessageClass = '';
  let hints = [];
  let displayHints = false;

  const search = (event) => {
    if(value != ''){
      axios.get(`${url}`, {
        params: {
          [queryParam]: value
        }
      })
      .then(function (response) {
        displayHints = true;
        document.querySelector('ul').setAttribute('style', `width: ${event.target.offsetWidth}px`);
        hints = [];
        response.data.forEach(record => {
          hints.push({
            [hintKey]: record[recordKey],
            [hintValue]: record[recordValue],
          });
        });
      })
      .catch(function (error) {
        console.log(error);
      })
      .then(function () {
        // always executed
      });
    }else{
      document.querySelector('ul').classList.add('d-none');
      hints = [];
      displayHints = false;
    }
  };

  const hintClick = (hintKeyP, hintValueP) => {
    console.log(hintKeyP)
    valueId = hintKeyP;
    value = hintValueP;
    hints = [];
    displayHints = false;
  };

  const focusout = (event) => {
    // hints = [];
    // TODO
  };

  const keyDown = (event) => {
    switch (event.key) {
      case 'Escape':
        hints = [];
        break;
      case 'ArrowUp':
        console.log('arriba')
        break;
      case 'ArrowDown':
        console.log('abajo')
        break;
      case 'Enter':
        console.log('enter')
        break;
      default:
        break;
    }
  }
</script>

<label for="file" class="{validationMessageClass != 'text-success' ? validationMessageClass : ''}">{label}</label>
<input type="text" class="form-control" placeholder="{placeholder}" bind:value={value} on:keydown={keyDown} on:input="{search}" on:blur="{focusout}">
<ul class="hint-container {displayHints ? '' : 'd-none'}">
  {#each hints as hint}
    <li on:click={hintClick(hint[hintKey], hint[hintValue])}>{hint.name}</li>
  {/each}
</ul>

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

  li:hover {
    cursor: pointer;
    background: #ccc;
    width: 98%;
  }
</style>