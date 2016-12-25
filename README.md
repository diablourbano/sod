# SoD
### _Symphony of Death_


*tl;dr*
It's a timeline to visualize the progression of terrorism attacks since 1970.

## what is it?
It's a timeline, dot chart and map visualizations. The variables involved are

- Date (splitted in years, months and days) represented by the timeline visualization.
- Number of incidents and casualties on that point in time. The progression 
  is represented by the dot chart visualization.
- Countries involved in attacks on that point in time. The map visualization
  represents this data and the number of incidents and casualties in that country 
  at that specic moment.

## Where data comes from?
For this project there's a [backend server](https://bitbucket.org/diablourbano/sod_backend) 
(you'll need it if you want to run this localy) which has loaded part of the data from
[Global Database Terrorism](https://www.start.umd.edu/gtd/)

- _Please review the GDT's cookbook if you need to understand what's in there_
- _The data is from 1970 to 2015_

## Why?
Two reasons

- I wanted to use 3djs in a project specific for it. My focus was on d3js.
- As humans we need to stop to believe we think about others, the reality is that we're
  selfish and we want to amend that, so this is an attempt to take us in that direction.
  I did this because we need to understand a lot of us are suffering and not only those
  in the _media_'s eye.

## How to ...

### run localy

#### Requirements

- [SoD back-end](https://bitbucket.org/diablourbano/sod_backend)
- [Sass](http://sass-lang.com/)
- [node & npm](https://nodejs.org/en/)
- Apache or nginx or your favorite HTTP server

#### Installation

```
$ npm install
$ bower install
```

#### Configuration

Configure your HTTP server hosts file (I'm using apache) to serve static files at the ```./build/``` path.

Configure your hosts file to serve your local deploy to a custom local DNS, e.g. sod.mylocalhost.local

Open ```./js/dev_env.vars.js``` and change cors_origin value to your local deploy of *sod_backend*. Don't
forget the port you'll be using for the back-end (default: 9292)

```$ gulp```

Open your browser with the specified host, e.g. http://sod.mylocalhost.local

Enjoy it!

## What's missing?
I'd like at some point ...

- to improve the UI
- to include a graph to visualize country by time
