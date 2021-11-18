<script>
  import { onMount } from 'svelte';
  import InputText from '../../Widgets/InputText.svelte';
  import UploadFile from '../../Widgets/UploadFile.svelte';
  import DataTable from '../../Widgets/DataTable.svelte';
  import { alertMessage as alertMessageStore} from '../../Stores/alertMessage.js';
  export let id;
  let title = '';
  let alertMessage = null;
  let alertMessageProps = {};
  let dentistSpecialismDataTable;
  let dentistBranchDataTable;
  let name = '';
  let cop = '';
  let rne = '';

  onMount(() => {
    alertMessageStore.subscribe(value => {
      if(value != null){
        alertMessage = value.component;
        alertMessageProps = value.props;
      }
    });
    if(id === undefined){
      title = 'Crear Dentista';
      id = 'E';
    }else{
      title = 'Editar Dentista';
    }
    // dentist specialism table
    dentistSpecialismDataTable.urlServices.list = `dentist/specialism/list?dentist_id=${id}`;
    dentistSpecialismDataTable.list();
    dentistSpecialismDataTable.extraData.dentist_id = id;
    // dentist branch table
    dentistBranchDataTable.urlServices.list = `dentist/branch/list?dentist_id=${id}`;
    dentistBranchDataTable.list();
  });

  const saveDetail = () => {

  };
</script>

<svelte:head>
	<title>{title}</title>
</svelte:head>

<div class="container">
	<div class="row">
		<svelte:component this={alertMessage} {...alertMessageProps} />
		<div class="col-lg-12 page-header">
			<h2>{title}</h2>
		</div>
  </div>
  <div class="row">
    <div class="col-md-4">
      <InputText 
        label={'Nombre Completo'}
        bind:value={name}
        placeholder={'Ingrese nombre'} 
      />
    </div>
    <div class="col-md-3">
      <div class="form-group">
      <UploadFile 
        label={'Selecionar Archivo'}
        fileName={'file'} 
        url={`${BASE_URL}upload`} 
        baseUrlFile={`${BASE_URL}`}  
        chooserButton={
          {label: 'Buscar', icon: 'fa-grav', class: 'btn-info'}
        }
        uploadButton={
          {label: 'Subir', icon: 'fa-shower', class: 'btn-secondary'}
        }
        viewButton={
          {label: 'Ver', icon: 'fa-vcard', class: 'btn-primary', display: true}
        } 
        validationSize={
          {size: 2.6, message: 'Máximo 2 MB'}
        }
        validationExtension={
          {allowed: ['image/png', 'image/jpg', 'image/jpeg'], message: 'Sólo Imágenes'}
        }
        />
      </div>
    </div>
    <div class="col-md-1">
      <InputText 
        label={'COP'}
        bind:value={cop}
        placeholder={'COP'} 
      />
    </div>
    <div class="col-md-1">
      <InputText 
        label={'RNE'}
        bind:value={rne}
        placeholder={'RNE'} 
      />
    </div>
    <div class="col-md-2" style="padding-top:27px;">
      <button class="btn btn-success" on:click="{saveDetail}"><i class="fa fa-search" aria-hidden="true"></i>
        Guardar</button>
    </div>
  </div>
  <div class="row">
    <div class="col-md-6">
      <br>
      <h6>Especialidades del Dentista</h6>
      <DataTable bind:this={dentistSpecialismDataTable} 
				urlServices={{ 
					list: `${BASE_URL}dentist/specialism/list`, 
					save: `${BASE_URL}dentist/specialism/save` 
				}}
				buttonSave={true},
				rows={{
					id: {
						style: 'color: red; display:none;',
						type: 'id',
					},
					name:{
						type: 'input[text]',
					},
          exist:{
						type: 'input[check]',
            style: 'text-align: center',
					},
				}}
				headers={[
					{
						caption: 'codigo',
						style: 'display:none;',
					},
					{
						caption: 'Nombre',
					},
          {
						caption: 'Especialidad',
            style: 'text-align: center',
					},
				]}
				messages={{
					notChanges: 'No ha ejecutado cambios en la tabla de especialidades del dentista',
					list404: 'Rercuso no encontrado para listar los elmentos de la tabla de especialidades del dentista',
					list500: 'Ocurrió un error en listar los elementos de la tabla de especialidades del dentista',
					save404: 'Rercuso no encontrado para guardar los cambios de la tabla de especialidades del dentista',
					save500: 'Ocurrió un error para guardar los cambios de la table de especialidades del dentista',
					save200: 'Se han actualizado los registros de la tabla de especialidades del dentista',
				}}
			/>
    </div>
    <div class="col-md-6">
      <br>
      <h6>Sedes Donde Labora</h6>
      <DataTable bind:this={dentistBranchDataTable} 
				urlServices={{ 
					list: `${BASE_URL}dentist/branch/list`, 
					save: `${BASE_URL}dentist/branch/save` 
				}}
				buttonSave={true},
        buttonAddRow={true},
				rows={{
					id: {
						style: 'color: red; display:none;',
						type: 'id',
					},
					'branch_name::branch_id':{
						type: 'autocomplete',
            url: 'branch/search',
            recordValue: 'branch_name',
            recordId: 'branch_id',
					},
					actions:{
						type: 'actions',
						buttons: [
							{
								type: 'delete',
							},
						],
						style: 'text-align:center;'
					},
				}}
				headers={[
					{
						caption: 'codigo',
						style: 'display:none;',
					},
					{
						caption: 'Nombre',
					},
				]}
				messages={{
					notChanges: 'No ha ejecutado cambios en la tabla de sedes del dentista',
					list404: 'Rercuso no encontrado para listar los elmentos de la tabla de sedes del dentista',
					list500: 'Ocurrió un error en listar los elementos de la tabla de sedes del dentista',
					save404: 'Rercuso no encontrado para guardar los cambios de la tabla de sedes del dentista',
					save500: 'Ocurrió un error para guardar los cambios de la table de sedes del dentista',
					save200: 'Se han actualizado los registros de la tabla de sedes del dentista',
				}}
			/>
    </div>
  </div>
</div>

<style>

</style>