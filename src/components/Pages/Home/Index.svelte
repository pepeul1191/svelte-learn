<script>
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
          {label: 'param1', icon: 'fa-grav', class: 'btn-danger'}
        }
        uploadButton={
          {label: 'param2', icon: 'fa-shower', class: 'btn-danger'}
        }
        viewButton={
          {label: 'param3', icon: 'fa-vcard', class: 'btn-danger'}
        } />
      </div>
    </div>
    <div class="col-md-4">
      <div class="form-group">
        <UploadFile />
      </div>
    </div>
  </div>
</div>

<style>
</style>