<script>
	import DemoForm from './../../Forms/DemoForm.svelte';
  import { onMount, createEventDispatcher } from 'svelte';
	import Autocomplete from './../../Widgets/Autocomplete.svelte';
	import UploadFile from './../../Widgets/UploadFile.svelte';
  import Calendar from './../../Widgets/Calendar.svelte';
  import Bar from './../../Modals/Bar.svelte';
  import { modal } from '../../Stores/modal.js';
  import { alertMessage as alertMessageStore} from '../../Stores/alertMessage.js';
  import DataTable from '../../Widgets/DataTable.svelte';
  import AlertMessage from '../../Widgets/AlertMessage.svelte';
  let alertMessage = null;
  let alertMessageProps = {};
  let departmentDataTable;
  let provinceDataTable;

  const dispatch = createEventDispatcher();

  onMount(() => {
    // console.log('index');
    alertMessageStore.subscribe(value => {
      if(value != null){
        alertMessage = value.component;
        alertMessageProps = value.props;
      }
    });
    departmentDataTable.list();
  });

  const showModal = () => {
    modal.set(Bar);
    dispatch('showModal', {
			param1: 'Hello!'
		});
  };

  const launchAlert = (event, type) => {
    alertMessage = null;
    alertMessage = AlertMessage;
    alertMessageProps = {
      message: 'hola mundo',
      type: type,
      timeOut: 3000
    }
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
        }
        />
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
    <div class="row" style="padding-top:20px;">
      <div class="col-md-4">
        <button class="btn btn-primary" on:click|preventDefault={(event) => launchAlert(event,'primary')}>Demo Alert Primary</button>
      </div>
      <div class="col-md-4">
        <button class="btn btn-secondary" on:click|preventDefault={(event) => launchAlert(event,'secondary')}>Demo Alert Secondary</button>
      </div>
      <div class="col-md-4">
        <button class="btn btn-danger" on:click|preventDefault={(event) => launchAlert(event,'danger')}>Demo Alert Danger</button>
      </div>
    </div>
    <AlertMessage message={'hola mundo'} type={'warning'} timeOut=5000 />
    <svelte:component this={alertMessage} {...alertMessageProps} />
    <div class="col-md-4">
      <DataTable bind:this={departmentDataTable} 
        urlServices={{ 
          list: `${BASE_URL}department/list`, 
          save: `${BASE_URL}department/save` 
        }}
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
              {
                type: 'delete',
              },
              {
                type: 'custom', 
                icon: 'fa fa-chevron-right', 
                style:'font-size:12px; margin-left:5px;',
                customFunction: (record) => {
                  var departmentId = record.id;
                  provinceDataTable.urlServices.list = `${BASE_URL}province/list/${departmentId}`;
                  provinceDataTable.list();
                },
              },
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
            caption: 'Nombre',
          },
          {
            caption: 'Operaciones',
            style:'text-align: center;',
          },]}
          messages={{
            notChanges: 'No ha ejecutado cambios en la tabla de departamentos',
            list404: 'Rercuso no encontrado para listar los elmentos de la tabla de departamentos',
            list500: 'Ocurrió un error en listar los elementos de la tabla de departamentos',
            save404: 'Rercuso no encontrado para guardar los cambios de la tabla de departamentos',
            save500: 'Ocurrió un error para guardar los cambios de la table de departamentos',
            save200: 'Se han actualizado los registros de la tabla de departamentos',
          }}
      />
    </div>
    <div class="col-md-4">
      <DataTable bind:this={provinceDataTable} 
        urlServices={{ 
          list: `${BASE_URL}province/list/3`, 
          save: `${BASE_URL}province/save` 
        }}
        buttonAddRow={true},
        buttonSave={true},
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
              {
                type: 'delete',
              },
              {
                type: 'custom', 
                icon: 'fa fa-chevron-right', 
                style:'font-size:12px; margin-left:5px;'
              },
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
            caption: 'Nombre',
          },
          {
            caption: 'Operaciones',
            style:'text-align: center;',
          },]}
          messages={{
            notChanges: 'No ha ejecutado cambios en la tabla de provincias',
            list404: 'Rercuso no encontrado para listar los elmentos de la tabla de provincias',
            list500: 'Ocurrió un error en listar los elementos de la tabla de provincias',
            save404: 'Rercuso no encontrado para guardar los cambios de la tabla de provincias',
            save500: 'Ocurrió un error para guardar los cambios de la table de provincias',
            save200: 'Se han actualizado los registros de la tabla de provincias',
          }}
      />
    </div>
  </div>
</div>

<style>
</style>