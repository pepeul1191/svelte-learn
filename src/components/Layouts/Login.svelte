<script>
	import { Router, Link, Route } from 'svelte-routing';
  import Index from '../Pages/Login/Index.svelte';
  import SignIn from '../Pages/Login/SignIn.svelte';
  import ResetPassword from '../Pages/Login/ResetPassword.svelte';
  export let url = '';
  export let basepath = '/login';
</script>

<Router url="{url}" basepath="{basepath}">
  <nav>
    <Link to="/login">Iniciar Sesión</Link>
    <Link to="/login/sign-in">Crear Cuenta</Link>
    <Link to="/login/reset-password">Olvidó Su Contraseña</Link>
  </nav>
  <div>
    <Route path="/" component="{Index}" />
    <Route path="/sign-in" component="{SignIn}" />
    <Route path="/reset-password" component="{ResetPassword}" />
  </div>
</Router>

<style>

</style>