# SoD
### _Symphony of Death_

## Requirements

- [SoD back-end](https://bitbucket.org/diablourbano/sod_backend)
- [Sass](http://sass-lang.com/)
- [node & npm](https://nodejs.org/en/)
- Apache or nginx or your favorite HTTP server

## Installation

```
$ npm install
$ bower install
```

## Configuration

Configure your HTTP server hosts file (I'm using apache) to serve static files at the ```./build/``` path.

Configure your hosts file to serve your local deploy to a custom local DNS, e.g. sod.mylocalhost.local

Open ```./js/dev_env.vars.js``` and change cors_origin value to your local deploy of *sod_backend*. Don't
forget the port you'll be using for the back-end (default: 9292)

```$ gulp```

Open your browser with the specified host, e.g. http://sod.mylocalhost.local

Enjoy it!
