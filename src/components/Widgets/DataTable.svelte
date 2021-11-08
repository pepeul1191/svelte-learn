<script>
  import { onMount } from 'svelte';
  import axios from 'axios';
  export let headers;
  export let data = [];
  export let urlServices;
  export let rows;
  export let buttonAddRow = false;
  let observer = { new: [], edit: [{id: 2, name:'XD 2'}, {id: 1, name:'XD 1'}], delete: []};

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

  function search(key, idSearched, observerArray){
    for (var i=0; i < observerArray.length; i++) {
      console.log(observerArray[i][key])
      console.log(idSearched)
      if (observerArray[i][key] == idSearched) {
        return observerArray[i];
      }
    }
    return false;
  }

  const inputTextKeyDown = (event) => {
    var idKey = event.target.parentElement.parentElement.firstChild.firstChild.getAttribute('key');
    var rowKey = event.target.parentElement.parentElement.firstChild.firstChild.innerHTML;
    var edited = search(idKey, rowKey, observer.edit)
    if(edited == false){
      observer.edit.push({[idKey]: rowKey})
    }
  };

  const addRow = () => {
    data.push({id: 123, nombre: '-'})
    console.log(data)
  }
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
      <td style="{rowProps.style}">
      {#if rowProps.type != 'actions'}
        {#if rowProps.type == 'td'}
          <span key="{id}">{record[id]}</span>
        {:else if rowProps.type == 'input[text]'}
          <input type="text" key="{id}" on:keydown={inputTextKeyDown} bind:value={record[id]}>
        {/if}
      {:else}
        <button>:)</button>
      {/if}
      </td>
      {/each}
    </tr>
    {/each}
  </tbody>
  <tfoot>
    <tr>
      <td colspan="1000" style="text-align:right">
        {#if buttonAddRow}
        <button class="btn btn-primary" on:click={addRow}> <i class="fa fa-plus" style="margin-right:5px"></i>Agregar Registro</button>
        {/if}
      </td>
    </tr>
  </tfoot>
</table>

<style>
  .table-striped  tbody  tr:hover td{
  background-color: #ececec;   
}

td{
  padding-top: 5px; padding-bottom: 5px;
}

b a i{
  color: #484848
}

tfoot tr td{
  padding-top: 5px;
}

thead tr th {
  padding: 2.5px !important;
}

table.list td {
  text-align: left; padding-left: 10px;
}

table.list th {
  text-align: left; padding-left: 10px;
}

td input[type="text"]{
  width: 100%;
  border: 0px;
  background-color: transparent;
  border: 0px;
  -webkit-box-shadow: inset 0 0px 0px rgba(0, 0, 0, 0.075);
  -moz-box-shadow: inset 0 0px 0px rgba(0, 0, 0, 0.075);
  box-shadow: inset 0 0px 0px rgba(0, 0, 0, 0.075);
  margin-bottom: 0px;
  color: #484848;
}

.table tbody tr td, .table tbody tr th, .table tfoot tr td, .table tfoot tr th, .table thead tr td, .table thead tr th{
  line-height: 1.42857143; 
  vertical-align: top; 
  border-top: 1px solid #ddd; 
  padding: 5px;
}

td > input[type="text"]{
  padding-left: 5px; 
  padding-right: 5px;
}

td > input[type="text"]:hover, td > select:hover{
  cursor: pointer;
}

td > select{
  background-color: transparent; 
  border: 0px solid #cccccc; 
  margin-bottom: 0px; 
  top:10px; 
  height: 17px; 
  padding: 0px 0px; 
  color: #484848;
}

td > a > i {
  color: #212529; 
  padding-left: 5px;
}

table tbody tr td i:hover, td > a > i:hover{
  cursor: pointer; 
}

.table-striped>tbody>tr:nth-of-type(odd) {
  background-color: transparent; 
}

tfoot tr td button, tfoot tr td a{
  margin-left: 10px
}

table > tfoot > tr > td {
  padding-top: 10px !important; 
}

.pagination-btn:hover{
  cursor: pointer;
}

.pagination-btn{
  padding-left: 2.5px; 
  padding-right: 2.5px; 
  text-align: left;
  font-size: 20px;
  font-weight: 400;
}

.pagination-number{
  margin-left: 2.5px;
  margin-right: 2.5px;
  top: -2px;
  position: relative;
  font-weight: 600;
}
</style>