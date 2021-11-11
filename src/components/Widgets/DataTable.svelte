<script>
  import { onMount } from 'svelte';
  import axios from 'axios';
  import { navigate } from 'svelte-routing';
  import AlertMessage from './AlertMessage.svelte';
  import random from '../Helpers/random.js';
  import { alertMessage as alertMessageStore} from '../Stores/alertMessage.js';
  export let headers;
  export let data = [];
  export let urlServices;
  export let rows;
  export let buttonAddRow = false;
  export let buttonAddRecord = false;
  export let buttonSave = false;
  export let observer = { new: [], edit: [], delete: []};
  export let messages = {
    notChanges: 'No ha ejecutado cambios en la tabla',
    list404: 'Rercuso no encontrado para listar los elmentos de la tabla',
    list500: 'Ocurrió un error en listar los elementos de la tabla',
    save404: 'Rercuso no encontrado para guardar los cambios',
    save500: 'Ocurrió un error para guardar los cambios',
    save200: 'Se han actualizado los registros de la tabla',
  };

  onMount(() => {
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
      console.error(error);
      if (error.response) {
        if(error.response.status == 404){
          launchAlert({
            message: messages.list404,
            type: 'danger',
            timeOut: 5000
          });
        }else{
          launchAlert({
            message: messages.list500,
            type: 'danger',
            timeOut: 5000
          });
        }
        console.log(error.response.data);
        console.log(error.response.status);
        // console.log(error.response.headers);
      }
    })
    .then(function () {
      // TODO?
    });
  };

  const launchAlert = (props) => {
    alertMessageStore.set({
      component: AlertMessage,
      props: props
    })
  };

  const observerSearch = (key, idSearched, observerArray) => {
    for (var i=0; i < observerArray.length; i++) {
      if (observerArray[i][key] == idSearched) {
        return observerArray[i];
      }
    }
    return false;
  }

  const dataSearch = (key, idSearched) => {
    for (var i=0; i < data.length; i++) {
      if (data[i][key] == idSearched) {
        return data[i];
      }
    }
  }

  const inputTextKeyDown = (event) => {
    var idKey = event.target.parentElement.parentElement.firstChild.firstChild.getAttribute('key');
    var rowKey = event.target.parentElement.parentElement.firstChild.firstChild.innerHTML;
    if(String(rowKey).includes('tmp')){
      if(observerSearch(idKey, rowKey, observer.new) == false){
        observer.new.push({[idKey]: rowKey})
      }
    }else{
      if(observerSearch(idKey, rowKey, observer.edit) == false){
        observer.edit.push({[idKey]: rowKey})
      }
    }
  };

  const addRow = () => {
    var tmp = {};
    for(var key of Object.keys(rows)){
      switch (rows[key].type) {
        case 'id':
          tmp[key] = `tmp_${random(10)}`;
          break;
        case 'input[text]':
          tmp[key] = '';
          break;
        case 'actions':
          tmp[key] = undefined;
          break;
        default:
          break;
      }
    }
    data.push(tmp)
    data = data // for bind update
  }

  const deleteRow = (event) => {
    // observers
    var idKey = event.target.parentElement.parentElement.firstChild.firstChild.getAttribute('key');
    var rowKey = event.target.parentElement.parentElement.firstChild.firstChild.innerHTML;
    if(observerSearch(idKey, rowKey, observer.new) != false){
      var tmp = {[idKey]: rowKey};
      observer.new = observer.new.filter(item => JSON.stringify(item) !== JSON.stringify(tmp));
    }
    if(observerSearch(idKey, rowKey, observer.edit) != false){
      var tmp = {[idKey]: rowKey};
      observer.edit = observer.edit.filter(item => JSON.stringify(item) !== JSON.stringify(tmp));
      if(observerSearch(idKey, rowKey, observer.delete) == false){
        observer.delete.push({[idKey]: rowKey});
      }
    }
    if(observerSearch(idKey, rowKey, observer.delete) == false){
      observer.delete.push({[idKey]: rowKey});
    }
    // delete from data
    var tmp = [];
    data.forEach(record => {
      if(record[idKey] != rowKey){
        tmp.push(record);
      }
    });
    data = tmp;
  }

  const save = () => {
    var dataToSend = {new:[], edit:[], delete:[]};
    var recordId = null;
    observer.new.forEach(newed => {
      var key = Object.keys(newed)[0];
      recordId = key;
      var value = newed[key];
      var record = dataSearch(key, value);
      delete record['actions'];
      dataToSend.new.push(record);
    });
    observer.edit.forEach(edited => {
      var key = Object.keys(edited)[0];
      recordId = key;
      var value = edited[key];
      var record = dataSearch(key, value);
      delete record['actions'];
      dataToSend.edit.push(record);
    });
    observer.delete.forEach(deleted => {
      var key = Object.keys(deleted)[0];
      recordId = key;
      var value = deleted[key];
      dataToSend.delete.push({[key]: value});
    });
    if(dataToSend.new.length == 0 && dataToSend.edit.length == 0 && dataToSend.delete.length == 0){
      launchAlert({
        message: messages.notChanges,
        type: 'warning',
        timeOut: 5000
      });
    }else{
      axios.post(urlServices.save, JSON.stringify({
          news: dataToSend.new,
          edits: dataToSend.edit,
          deletes: dataToSend.delete
        }), {headers: {
          'Content-Type': 'application/json',
        }})
        .then(function (response) {
          response.data[1].forEach(created => {
            dataSearch(recordId, created.tmp)[recordId] = created[recordId];
          });
          data = data;
          observer = { new: [], edit: [], delete: []};
          launchAlert({
            message: messages.save200,
            type: 'success',
            timeOut: 5000
          });
        })
        .catch(function (error) {
          console.error(error);
          if (error.response) {
            if(error.response.status == 404){
              launchAlert({
                message: messages.save404,
                type: 'danger',
                timeOut: 5000
              });
            }else{
              launchAlert({
                message: messages.save500,
                type: 'danger',
                timeOut: 5000
              });
            }
            console.log(error.response.data);
            console.log(error.response.status);
            // console.log(error.response.headers);
          }
        }
      );
    }
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
          {#if rowProps.type == 'id'}
            <span key="{id}">{record[id]}</span>
          {:else if rowProps.type == 'input[text]'}
            <input type="text" key="{id}" on:keydown={inputTextKeyDown} bind:value={record[id]}>
          {/if}
        {:else}
          {#each rowProps.buttons as action}
            {#if action.type == 'delete'}
              <i class="fa fa-times" aria-hidden="true" on:click={deleteRow}></i>
            {/if}
          {/each}
        {/if}
        </td>
      {/each}
    </tr>
    {/each}
  </tbody>
  <tfoot>
    <tr>
      <td colspan="1000" style="text-align:right">
        {#if buttonAddRow != false}
        <button class="btn btn-primary" on:click={addRow}> <i class="fa fa-plus" style="margin-right:5px"></i>Agregar Registro</button>
        {/if}
        {#if buttonAddRecord != false}
        <a class="btn btn-primary" on:click|preventDefault={() => {navigate(buttonAddRecord)}} href="{buttonAddRecord}"> <i class="fa fa-plus" style="margin-right:5px"></i>Agregar Registro</a>
        {/if}
        {#if buttonSave != false}
        <button class="btn btn-success save-table" on:click={save}> <i class="fa fa-check" style="margin-right:5px"></i>Guardar Cambios</button>
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

thead th {
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
  margin-left: 10px;
}

.btn > i {
  color: white;
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