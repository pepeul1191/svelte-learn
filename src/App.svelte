<script>
	import 'bootstrap/dist/css/bootstrap.min.css'
	import 'font-awesome/css/font-awesome.min.css'
	export let name;
</script>

<main>
	<h1>Hello {name}!</h1>
	<button class="btn btn-primary">
		Dirección
		<i class="fa fa-address-book-o" aria-hidden="true"></i>
	</button>
	<p>Visit the <a href="https://svelte.dev/tutorial">Svelte tutorial</a> to learn how to build Svelte apps.</p>
</main>

<style>
	main {
		text-align: center;
		padding: 1em;
		max-width: 240px;
		margin: 0 auto;
	}

	h1 {
		color: #ff3e00;
		text-transform: uppercase;
		font-size: 4em;
		font-weight: 100;
	}

	@media (min-width: 640px) {
		main {
			max-width: none;
		}
	}
</style>