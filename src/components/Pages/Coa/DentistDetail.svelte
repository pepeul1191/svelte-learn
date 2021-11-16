<script>
  import { onMount } from 'svelte';
  import { alertMessage as alertMessageStore} from '../../Stores/alertMessage.js';
  export let id;
  let alertMessage = null;
  let alertMessageProps = {};

  onMount(() => {
    alert(id)
  });
</script>

<svelte:head>
	<title>Editar Dentista</title>
</svelte:head>

<div class="container">
	<div class="row">
		<svelte:component this={alertMessage} {...alertMessageProps} />
		<div class="col-lg-12 page-header">
			<h2>Editar Dentista</h2>
		</div>
  </div>
</div>

<style>

</style>