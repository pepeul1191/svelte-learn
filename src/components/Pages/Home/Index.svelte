<script>
  import axios from 'axios';
  export let inputFile;
  export let urlFile = 'E';

  const selectFile = () => {
    const el = document.querySelector('#btnFile');
    el.click();
  };

  const uploadFile = () => {
    inputFile = document.querySelector('#btnFile').files[0];
    var formData = new FormData();
    formData.append('file', inputFile);
    axios.post('upload', formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    }).then(function (response) {
      // handle success
      console.log(response);
      urlFile = response.data;
    })
    .catch(function (error) {
      // handle error
      console.log(error);
    })
  };

  const viewFile = () => {
    var win = window.open(`/${urlFile}`, '_blank');
    if (win) {
      win.focus();
    } else {
      alert('Please allow popups for this website');
    }
  };
</script>

<button class="btn btn-primary" on:click="{selectFile}"><i class="fa fa-search" aria-hidden="true"></i>Seleccionar Archivo</button>
<button class="btn btn-success" on:click="{uploadFile}"><i class="fa fa-upload" aria-hidden="true"></i>Subir Archivo</button>
<button class="btn btn-secondary" on:click="{viewFile}"><i class="fa fa-picture-o" aria-hidden="true"></i>Ver Archivo</button>
<input type="file" class="" id="btnFile">

<style>
  #btnFile{
		display: none;
	}
</style>