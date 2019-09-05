# Middleman Designmodo Template

The base Middleman application used at [cantierecreativo], performed to use [designmodo] template, ready to deploy
to [Netlify].

[cantierecreativo]: https://cantierecreativo.net/
[designmodo]: https://designmodo.com/startup/
[Netlify]: https://www.netlify.com/

## Requirements

This project requires [Node.js](https://nodejs.org/) (v10.16.1) with 
[yarn](https://yarnpkg.com/) and [Ruby](https://ruby-lang.org) (v2.6.2)

## Usage

1. Install or set Ruby (2.6.2) with RBENV:

```
$ rbenv install/set 2.6.2
```

2. Install or use Middleman gem:

```
$ gem install middleman
```

3. Install or set Node (v10.16.1) with NVM:

```
$ nvm install/use 10.16.1
```

4. Then run:

```
$ middleman init project -T=cantierecreativo/middleman-designmodo
```

## Configuration

The template init scripts asks you for the follwoing information:

- Languages string (it,en)
- DatoCMS read-only API token (from DatoCMS settings -> API Tokens)
- Base URL of site (https://sitedomain.ext)
- Remote git repository to store ORIGIN
- Remote git repository to store PRODUCTION and Netlify buildable files

After these questions, the init script installs all dependencies and creates
the complete directory site.

You should change the default data in `data/config.json` and create the proxy
routing for the new site.

The final directory structure is:

```
project/
+-- .gitignore
+-- Gemfile
+-- Gemfile.lock
+-- config.rb
+-- package.json
+-- webpack.config.js
+-- yarn.lock
+-- config
|   +-- i18n-tasks.yml
+-- data
|   +-- config.json
+-- locales
|   +-- it.yml
|   +-- en.yml
+-- source
    +-- partials/
    |   +-- _head.html.erb
    |   +-- _js_includes.html.erb
    +-- templates
    |   +-- browserconfig.xml.erb
    |   +-- redirects.txt.erb
    |   +-- site.webmanifest.erb
    |   +-- index.html.erb
    +-- 404.html.erb
    +-- layouts
    ¦   +-- layout.html.erb
```

* To see the list of helpers in the system read [HELPERS.md](HELPERS.md)
* To see examples of code (JS and CSS) that the template exposes read
[EXAMPLE.md](EXAMPLE.md)

## Features and Tools

This template comes with the following features and tools:

- [middleman-dato]: An extension for connect with DatoCMS.
- [middleman-minify-html]: Minifies whitespace around HTML when the site is
  built.
- [Scss]: CSS extension language.
- [Erb]: Templating engine.
- [lazyload]: Delay loading of images until user scrolls to them
- [AOS]: Animate On Scroll Library
- [fancybox]: JavaScript lightbox library for presenting various types of media

[middleman-dato]: https://github.com/datocms/middleman-dato
[middleman-minify-html]: https://github.com/middleman/middleman-minify-html
[middleman-search_engine_sitemap]: https://github.com/Aupajo/middleman-search_engine_sitemap
[Scss]: https://sass-lang.com/guide
[Erb]: https://apidock.com/ruby/ERB
[lazyload]: https://appelsiini.net/projects/lazyload
[AOS]: http://michalsnik.github.io/aos/
[fancybox]: https://www.fancyapps.com/fancybox/3/

## License

Copyright © 2019 CantiereCreativo. This is free software, and may
be redistributed under the terms specified in the [LICENSE] file.

[license]: LICENSE.md
