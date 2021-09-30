<script>
	import 'bootstrap/dist/css/bootstrap.min.css';
	import 'font-awesome/css/font-awesome.min.css';
	import '../../stylesheets/styles.css';
  import { Modal } from 'bootstrap';
	import { onMount } from 'svelte';
	import { Router, Route } from 'svelte-routing';
  import Index from '../Pages/Home/Index.svelte';
	import Redirect404 from '../Pages/Error/Redirect404.svelte';
  import { modal, modalDOM } from '../Stores/modal.js';
  import Foo from '../Modals/Foo.svelte';
  export let url = '';
  export let basepath = '/';
  let modalComponent;
  let modalDOMStore;

  onMount(() => {
    console.log('home');
    modal.subscribe(value => {
      modalComponent = value;
    });
    modalDOM.subscribe(value => {
      modalDOMStore = new Modal(document.getElementById('modal'));
    });
  });

  const modalOpen = () => {
    //myModal.toggle()
    modalComponent = Foo;
    modalDOMStore.show();
  };

</script>

<!-- Modal -->
<div class="modal fade" id="modal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <svelte:component this={modalComponent} />
    </div>
  </div>
</div>

<button class="btn btn-info" on:click="{modalOpen}">Modal FOO</button>

<Router url="{url}" basepath="{basepath}">
  <div>
    <Route path="/" component="{Index}" />
    <Route path="/*" component="{Redirect404}" />
  </div>
</Router>

<style>
</style>