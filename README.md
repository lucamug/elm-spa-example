# elm-spa-example

Example of a website bootstrapped with `elm-spa` and `elm-starter`.

* [`README-elm-spa.md`](README-elm-spa.md)
* [`README-elm-starter.md`](https://github.com/lucamug/elm-starter)

[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/lucamug/elm-spa-example)

Compared to a regular `elm-starter` application, the commands have different name, to avoid conflicts with `elm-spa`:

```
$ npm run elm-starter:start
$ npm run elm-starter:build
$ npm run elm-starter:serverBuild
```

Moreover you need to run an extra command during the build so in Netlify, for example, the settings are:

* Build command `npm run build:elm-spa && npm run elm-starter:build`
* Publish directory `elm-stuff/elm-starter-files/build`

Also remember to build your application around a `div` that has `elm` as id.

This because we need to remove that node before re-creating.

Look for these two lines of code for more explanation:

```
var node = document.getElementById('elm');
if (node) { node.remove(); }
```