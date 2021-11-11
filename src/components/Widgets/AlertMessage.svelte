<script>
  // https://getbootstrap.com/docs/5.0/components/alerts/
  // primary, secondary, success, danger, warning, info, light, dark
  import { afterUpdate } from 'svelte';
  export let message = '';
  export let type;
  export let timeOut = false;

  afterUpdate(() => {
    if(message != ''){
      if(timeOut != false){
        setTimeout(clearMessage, 5000);
      }
    } 
  });

  const clearMessage = () => {
    message = '';
  };
</script>

{#if message != ''}
<div class="row">
  <div class="col-md-12">
    <div class="alert alert-{type}" role="alert">
      {message}
    </div>
  </div>
</div>
{/if}

<style>
  .row{
    padding-top:20px;
  }

  .alert{
    border-radius: 0;
    padding: 0.5rem 1rem;
  }
</style>