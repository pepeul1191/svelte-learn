<script>
  import 'bootstrap/dist/css/bootstrap.min.css';
  import '../../stylesheets/styles.css';
  import '../../stylesheets/login.css';
  import { onMount } from 'svelte';
	import { Router, Route } from 'svelte-routing';
  import Index from '../Pages/Login/Index.svelte';
  import SignIn from '../Pages/Login/SignIn.svelte';
  import ResetPassword from '../Pages/Login/ResetPassword.svelte';
  export let url = '';
  export let basepath = '/login';

  onMount(() => {
		console.log('login');
	});
</script>

<Router url="{url}" basepath="{basepath}">
  <div>
    <Route path="/" component="{Index}" />
    <Route path="/sign-in" component="{SignIn}" />
    <Route path="/reset-password" component="{ResetPassword}" />
  </div>
</Router>

<style>

</style>