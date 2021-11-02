<script>
  import { onMount } from 'svelte';
  import axios from 'axios';
  export let headers;
  export let data = [];
  export let urlServices;
  export let rows;

  onMount(() => {
    console.log(urlServices);
    console.log(rows);
    list();
  });
  
  const list = () => {
    console.log(data)
    axios.get(urlServices.list, {
      params: {
        //[queryParam]: value
      }
    })
    .then(function (response) {
      data = [];
      response.data.forEach(record => {
        var tmp = {};
        for(var key in rows){
          tmp[key]= record[key];
        }
        data.push(tmp);
      });
    })
    .catch(function (error) {
      console.log(error);
    })
    .then(function () {});
  };
</script>
  
<table class="table table-striped"> 
  <thead>
    {#each headers as headerProps}
    <th style="{headerProps.style}">{headerProps.caption}</th>
    {/each}
  </thead>
  <tbody>
    {#each data as record}
    <tr>
      {#each Object.entries(rows) as [id, rowProps]}
      <td style="{rowProps.style}">{record[id]}</td>
      {/each}
    </tr>
    {/each}
  </tbody>
</table>

<style>
  
</style>