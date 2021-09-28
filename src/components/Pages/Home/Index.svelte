<script>
	import Autocomplete from './../../Widgets/Autocomplete.svelte';
	import UploadFile from './../../Widgets/UploadFile.svelte';
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
    <div class="col-md-3">
      <div class="form-group">
        <Autocomplete 
          label={'Buscar Distritos'} 
          placeholder={'Ingrese distrito'} 
          url={`${BASE_URL}district/search`} 
          key={'name'} />
      </div>
    </div>
    <div class="col-md-3">
      <div class="form-group">
        <Autocomplete />
      </div>
    </div>
  </div>
</div>

<style>
</style>