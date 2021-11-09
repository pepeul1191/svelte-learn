<script>
	import DemoForm from './../../Forms/DemoForm.svelte';
  import { onMount, createEventDispatcher } from 'svelte';
	import Autocomplete from './../../Widgets/Autocomplete.svelte';
	import UploadFile from './../../Widgets/UploadFile.svelte';
  import Calendar from './../../Widgets/Calendar.svelte';
  import Bar from './../../Modals/Bar.svelte';
  import { modal } from '../../Stores/modal.js';
  import DataTable from '../../Widgets/DataTable.svelte';
  
  const dispatch = createEventDispatcher();

  onMount(() => {
    console.log('index');
  });

  const showModal = () => {
    modal.set(Bar);
    dispatch('showModal', {
			param1: 'Hello!'
		});
  };
</script>

<div class="container">
  <div class="row">
    <div class="col-md-4">
      <div class="form-group">
      <UploadFile 
        label={'Selecionar Archivo'}
        fileName={'file'} 
        url={`${BASE_URL}upload`} 
        baseUrlFile={`${BASE_URL}`}  
        chooserButton={
          {label: 'Search', icon: 'fa-grav', class: 'btn-danger'}
        }
        uploadButton={
          {label: 'Upload', icon: 'fa-shower', class: 'btn-danger'}
        }
        viewButton={
          {label: 'param3', icon: 'fa-vcard', class: 'btn-danger', display: false}
        } 
        validationSize={
          {size: 2.6, message: 'Máximo 2 MB'}
        }
        validationExtension={
          {allowed: ['application/pdf'], message: 'Sólo PDFs'}
        } />
      </div>
    </div>
    <div class="col-md-4">
      <div class="form-group">
        <UploadFile />
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-3">
      <div class="form-group">
        <Autocomplete 
          label={'Buscar Distritos'} 
          placeholder={'Ingrese distrito'} 
          url={`${BASE_URL}district/search`} 
        />
      </div>
    </div>
    <div class="col-md-3">
      <div class="form-group">
        <Autocomplete 
          url={`${BASE_URL}district/search`} 
        />
      </div>
    </div>
    <div class="col-md-3">
      <div class="form-group">
        <button class="btn btn-info" on:click="{showModal}">Modal BAR</button>
      </div>
    </div>
    <div class="col-md-3">
      <Calendar />
    </div>
    <DemoForm />
    <div class="col-md-4">
      <DataTable 
        urlServices={{ 
          list: `${BASE_URL}department/list`, 
          save: `${BASE_URL}department/save` }}
        buttonAddRow={true},
        buttonSave={true},
        buttonAddRecord={'/department/add'}
        rows={{
          id: {
            style: 'color: red;',
            type: 'id',
          },
          name:{
            type: 'input[text]',
          },
          actions:{
            type: 'actions',
            buttons: [
              {type: 'delete', icon: 'fa fa-times'}
            ],
            style: 'text-align:center;'
          },
        }}
        headers={[
          {
            caption: 'codigo',
            style: 'display:noe',
          },
          {
            caption: 'Nombre de Departamento',
          },
          {
            caption: 'Operaciones',
            style:'text-align: center;',
          },]}
      />
    </div>
  </div>
</div>

<style>
</style>