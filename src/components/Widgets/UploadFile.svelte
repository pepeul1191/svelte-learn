<script>
  import axios from 'axios';
  export let url = 'upload';
  export let urlFile = 'E';
  export let fileName = 'file';
  export let baseUrlFile = '/';
  export let label = 'Seleccionar Archivo';
  export let validationMessage = '';
  export let chooserButton= {
    label: 'Seleccionar', 
    icon: 'fa-search', 
    class: 'btn-primary'
  };
  export let uploadButton= {
    label: 'Subir', 
    icon: 'fa-upload', 
    class: 'btn-success'
  };
  export let viewButton= {
    label: 'Ver', 
    icon: 'fa-picture-o', 
    class: 'btn-secondary'
  };
  let validationMessageClass = '';

  const clearMessage = () => {
    validationMessage = '';
    validationMessageClass = '';
    console.log(chooserButton)
  };

  const selectFile = () => {
    const el = document.querySelector('input[name="file"]');
    el.click();
  };

  const uploadFile = () => {
    var inputFile = document.querySelector('input[name="file"]').files[0];
    var formData = new FormData();
    formData.append(`${fileName}`, inputFile);
    axios.post(`${url}`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    }).then(function (response) {
      // handle success
      console.log(response);
      urlFile = response.data;
      validationMessage = 'Se cargó el archivo con éxito';
      validationMessageClass = 'text-success';
      setTimeout(clearMessage, 7500);
    })
    .catch(function (error) {
      // handle error
      console.error(error);
      validationMessage = 'Ocurrió un error en subir el archivo';
      validationMessageClass = 'text-danger';
      setTimeout(clearMessage, 7500);
    })
  };

  const viewFile = () => {
    var win = window.open(`${baseUrlFile}${urlFile}`, '_blank');
    if (win) {
      win.focus();
    } else {
      alert('Please allow popups for this website');
    }
  };

</script>


<label for="file" class="{validationMessageClass != 'text-success' ? validationMessageClass : ''}">{label}</label>
<div>
  <button class="btn {chooserButton.class}" on:click="{selectFile}">
    <i class="fa {chooserButton.icon}" aria-hidden="true"></i>{chooserButton.label}
  </button>
  <button class="btn {uploadButton.class}" on:click="{uploadFile}">
    <i class="fa {uploadButton.icon}" aria-hidden="true"></i>{uploadButton.label} 
  </button>
  <button class="btn {viewButton.class}" on:click="{viewFile}">
    <i class="fa {viewButton.icon}" aria-hidden="true"></i>{viewButton.label} 
  </button>
</div>
<input type="file" class="" id="btnFile" name="file">
<div class="col-sm-12 validation-message">
  <small id="validationHelp" class="{validationMessageClass}">
    {validationMessage}
  </small>
</div>

<style>
  input[type="file"] {
		display: none;
	}

  div .btn:not(:first-child) {
    margin-left: 10px;
  }

  .validation-message {
    padding-left:0px;
  }
</style>