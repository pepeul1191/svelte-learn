*Psst — looking for a more complete solution? Check out [SvelteKit](https://kit.svelte.dev), the official framework for building web applications of all sizes, with a beautiful development experience and flexible filesystem-based routing.*

*Looking for a shareable component template instead? Go here --> [sveltejs/component-template](https://github.com/sveltejs/component-template)*

---

# svelte app

This is a project template for [Svelte](https://svelte.dev) apps. It lives at https://github.com/sveltejs/template.

To create a new project based on this template using [degit](https://github.com/Rich-Harris/degit):

```bash
npx degit sveltejs/template svelte-app
cd svelte-app
```

*Note that you will need to have [Node.js](https://nodejs.org) installed.*


## Get started

Install the dependencies...

```bash
cd svelte-app
npm install
```

...then start [Rollup](https://rollupjs.org):

```bash
npm run dev
```

Navigate to [localhost:5000](http://localhost:5000). You should see your app running. Edit a component file in `src`, save it, and reload the page to see your changes.

By default, the server will only respond to requests from localhost. To allow connections from other computers, edit the `sirv` commands in package.json to include the option `--host 0.0.0.0`.

If you're using [Visual Studio Code](https://code.visualstudio.com/) we recommend installing the official extension [Svelte for VS Code](https://marketplace.visualstudio.com/items?itemName=svelte.svelte-vscode). If you are using other editors you may need to install a plugin in order to get syntax highlighting and intellisense.

## Building and running in production mode

To create an optimised version of the app:

```bash
npm run build
```

You can run the newly built app with `npm run start`. This uses [sirv](https://github.com/lukeed/sirv), which is included in your package.json's `dependencies` so that the app will work when you deploy to platforms like [Heroku](https://heroku.com).


## Single-page app mode

By default, sirv will only respond to requests that match files in `public`. This is to maximise compatibility with static fileservers, allowing you to deploy your app anywhere.

If you're building a single-page app (SPA) with multiple routes, sirv needs to be able to respond to requests for *any* path. You can make it so by editing the `"start"` command in package.json:

```js
"start": "sirv public --single"
```

## Using TypeScript

This template comes with a script to set up a TypeScript development environment, you can run it immediately after cloning the template with:

```bash
node scripts/setupTypeScript.js
```

Or remove the script via:

```bash
rm scripts/setupTypeScript.js
```

If you want to use `baseUrl` or `path` aliases within your `tsconfig`, you need to set up `@rollup/plugin-alias` to tell Rollup to resolve the aliases. For more info, see [this StackOverflow question](https://stackoverflow.com/questions/63427935/setup-tsconfig-path-in-svelte).

## Deploying to the web

### With [Vercel](https://vercel.com)

Install `vercel` if you haven't already:

```bash
npm install -g vercel
```

Then, from within your project folder:

```bash
cd public
vercel deploy --name my-project
```

### With [surge](https://surge.sh/)

Install `surge` if you haven't already:

```bash
npm install -g surge
```

Then, from within your project folder:

```bash
npm run build
surge public my-project.surge.sh
```

Ejecutar la aplicación desde <b>config.ru</b>:

    $ rackup

Tareas de <b>Rakefile</b>

    $ rake {task name}

Ejecutar con rerun:

    $ rake dev:start

TODO en DataTable:

+ Select en celda
+ Hipervinculo en fila carga modal
+ Upload en fila
+ Modal on close refresca datos

---

Fuentes Sinatra:

+ https://www.slideshare.net/benschwarz/sinatra-rack-and-middleware-1509268
+ https://www.oreilly.com/library/view/sinatra-up-and/9781449306847/ch04.html
+ https://stackoverflow.com/questions/20081457/how-do-i-get-a-custom-rake-task-to-run-in-sinatra
+ https://medium.com/@mcdowpm/how-to-build-a-sinatra-app-2ac89fd058a0
+ https://learn.co/lessons/config-ru-tutorial
+ https://github.com/jarmo/require_all
+ https://github.com/alexch/rerun
+ https://stackoverflow.com/questions/8893422/how-do-i-set-a-global-variable-in-sinatra-depending-on-the-production-or-develop
+ https://stackoverflow.com/questions/41915269/new-sinatra-object-for-every-requests-but-initialize-only-called-once
+ https://github.com/pepeul1191/ruby-sinatra-boilerplate-v3
+ https://www.sitepoint.com/build-a-sinatra-mvc-framework/
+ https://www.toptal.com/ruby/api-with-sinatra-and-sequel-ruby-tutorial
+ https://stackoverflow.com/questions/14486551/before-filter-in-sinatra-subapplication
+ https://stackoverflow.com/questions/6317980/you-have-already-activated-x-but-your-gemfile-requires-y

Fuentes Svelte:

+ https://stackoverflow.com/questions/48836575/can-i-have-multiple-entry-points-using-rollup-with-gulp
+ https://stackoverflow.com/questions/59842528/how-to-add-bootstrap-module-in-a-svelte-js-app
+ https://github.com/EmilTholin/svelte-routing
+ https://lokalise.com/blog/svelte-i18n/
+ https://svelte.dev/repl/803c5f09233349d18365ed5583faaf0e?version=3.9.2
+ https://github.com/EmilTholin/svelte-routing/blob/master/CHANGELOG.md#140
+ https://stackoverflow.com/questions/61598941/how-to-scope-queryselector-to-component-in-svelte
+ https://github.com/sveltejs/svelte/issues/3461
+ https://svelte.dev/tutorial/component-events
+ https://svelte.dev/tutorial/writable-stores
+ https://www.youtube.com/watch?v=j5BSmW9SkM8&t=30s
+ https://svelte.dev/repl/05ed848f455848a2a69db90dc0a1d1c1?version=3.29.7
+ https://github.com/pepeul1191/swp-backbone-js-plugins/blob/master/views/calendar.js
+ https://codesandbox.io/s/blue-hill-jrutq?from-embed
+ https://newbedev.com/how-to-pass-parameters-to-on-click-in-svelte
+ https://svelte.dev/repl/74593f36569a4c268d8a6ab277db34b5?version=3.12.1
+ https://svelte.dev/tutorial/update
+ https://blog.openreplay.com/the-ultimate-guide-to-getting-started-with-the-rollup-js-javascript-bundler
+ https://github.com/sveltejs/svelte/issues/892
+ https://svelte.dev/repl/43bfe9802c88462aac11b87025b9534d?version=3.29.4 Components: Event Dispatcher: from child to parent
+ https://svelte.dev/repl/b17c13d4f1bb40799ccf09e0841ddd90?version=3.44.1 input file