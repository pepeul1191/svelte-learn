<script>
  import axios from 'axios';
  export let label = 'Buscar por texto';
  export let placeholder = 'Ingrese texto';
  export let text;
  export let url;
  export let key = 'name';
  let validationMessageClass = '';

  const search = () => {
    axios.get(`${url}`, {
      params: {
        [key]: text
      }
    })
    .then(function (response) {
      console.log(response);
    })
    .catch(function (error) {
      console.log(error);
    })
    .then(function () {
      // always executed
    });  
  };
</script>

<label for="file" class="{validationMessageClass != 'text-success' ? validationMessageClass : ''}">{label}</label>
<input type="text" class="form-control" aria-describedby="txtDirectorHelp" placeholder="{placeholder}" bind:value={text} on:input="{search}">

<style>

</style>