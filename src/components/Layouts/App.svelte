<script>
	import 'bootstrap/dist/css/bootstrap.min.css';
	import 'font-awesome/css/font-awesome.min.css';
	import '../../stylesheets/styles.css';
	import { onMount } from 'svelte';
	import { Router, Route } from 'svelte-routing';
  import Index from '../Pages/Home/Index.svelte';
	import Redirect404 from '../Pages/Error/Redirect404.svelte';
  export let url = '';
  export let basepath = '/';

  onMount(() => {
		console.log('home');
	});
</script>

<Router url="{url}" basepath="{basepath}">
  <div>
    <Route path="/" component="{Index}" />
    <Route path="/*" component="{Redirect404}" />
  </div>
</Router>

<style>
</style>