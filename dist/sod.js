"use strict";var Utils;Utils=function(){function t(){}return t.prototype.height=window.innerHeight,t.prototype.width=window.innerWidth,t.prototype.timelineHeight=350,t.prototype.windowRatio=function(){return window.innerWidth/window.innerHeight},t.prototype.sizeStyles=function(t,e){return null==t&&(t=this.width),null==e&&(e=this.height),"auto"!==t&&(t+="px"),"auto"!==e&&(e+="px"),["width:"+t,"height:"+e].join(";")},t.prototype.getFormattedDate=function(t,e){var n;return"years"===e&&(n="Y"),"months"===e&&(n="MMMM"),"days"===e&&(n="Do"),moment(t).format(n)},t.prototype.printLog=function(t){},t}();var UrlManager;UrlManager=function(){function t(){}var e,n,r,i,o,a;return a=new Utils,i={years:null,months:null,days:null},r=function(t){switch(parseInt(t[1])){case 1:case 3:case 5:case 7:case 8:case 10:case 12:return 31;case 2:return _.endsWith(t[0],"00")&&parseInt(t[0])%400===0||parseInt(t[0])%4===0?28:29;default:return 30}},e=function(t){var e;return e=moment().year(parseInt(t[0])),t[1]&&""!==t[1]&&e.month(parseInt(t[1])-1),t[2]&&""!==t[2]&&e.date(parseInt(t[2])),e.format("Y MMMM Do").split(" ")},n=function(t){var e,n,i,o,a;return n=t.split("/"),e=[],null!==n[0].match(/^\d{4}/)&&1970<=(i=parseInt(n[0]))&&i<=2014?(e[0]=n[0],void 0!==n[1]&&null!==n[1].match(/^\d{1,2}$/)&&1<=(o=parseInt(n[1]))&&o<=12&&(1===n[1].length&&(n[1]="0"+n[1]),e[1]=n[1],void 0!==n[2]&&null!==n[2].match(/^\d{1,2}$/)&&1<=(a=parseInt(n[2]))&&a<=r(n)&&(1===n[2].length&&(n[2]="0"+n[2]),e[2]=n[2])),e):null},o=function(){return window.location.href="#/"+_.filter(i,function(t){return null!==t&&""!==t}).join("/")},t.prototype.loadTimelineOnDate=function(){var t,r,a,s;return r=location.hash.replace("#/",""),0===r.length?null:(t=n(r),i=_.zipObject(_.keys(i),t),o(),s=e(t),a=i,a.years=s[0],a.months&&""!==a.months&&(a.months=s[1]),a.days&&""!==a.days&&(a.days=s[2]),a)},t.prototype.goToDate=function(t,e){return e&&("months"===t&&(e=(moment().month(e.toLowerCase()).month()+1).toString()),1===e.length&&(e="0"+e)),i[t]=e,o()},t}();var EventsManager;EventsManager=function(){function t(t){m=t}var e,n,r,i,o,a,s,l,u,c,h,p,g,d,f,m;return s=[],i="years",o=["years","months","days"],f={},c={years:null,months:"January",days:"01"},a=[],m=null,l=d3.time.format("%Y-%m-%d").parse,d=function(t,e){var n;return n=e.shift(),void 0!==t[n]?0===e.length?t[n]:d(t[n],e):null},e=function(){var t,e;return e=_.values(c),e[2]=n(e[2]),t=e.slice(0,o.indexOf(i)+1),d(f,t)},g=function(t,e){return e&&1===e.length&&(e="0"+e),c[t]=e},h=function(t,e){var n;return t=t.trim(),n=$(".graph-slot p.selected-date span").text().trim(),""!==n&&(a=n.split(" ")),null!==t.match(/^\d{4}$/)?a[0]=e:null!==t.match(/^\D+$/)?a[1]=e:null!==t.match(/^\d{1,2}\D{2}$/)?a[2]=e:void 0},p=function(t){var e;if("days"!==i)return e=o.indexOf(t),i=o[e+1]},u=function(){return g("years",null),g("months","January"),g("days","01")},r=function(t){return null!==t.match(/(st|nd|rd|th)/)&&(t=t.replace(/(st|nd|rd|th)/,"")),t},n=function(t){var e;return e=parseInt(t),1===e&&11!==e?e+"st":2===e&&12!==e?e+"nd":3===e&&13!==e?e+"rd":e+"th"},t.prototype.getDateTextFragments=function(){return a},t.prototype.addListener=function(t){if(s.indexOf(t)===-1)return s.push(t)},t.prototype.shouldHighlight=function(t){var n,o,a,l,u,c;for(o=r(t),g(i,o),n=e(),c=[],a=0,l=s.length;a<l;a++)u=s[a],c.push(u.highlight(t,n));return c},t.prototype.shouldUnhighlight=function(t){var n,o,a,l,u,c;for(o=r(t),g(i,o),n=e(),c=[],a=0,l=s.length;a<l;a++)u=s[a],c.push(u.unhighlight(t,n));return c},t.prototype.shouldFixDate=function(t,n,l,d){var f,x,y,v,w,D,S,$,H,M,C,L;if(null==l&&(l=null),null==d&&(d=!0),y=a.indexOf(t),y>-1){for(w=[],i=o[y],v=D=L=y;L<=2?D<=2:D>=2;v=L<=2?++D:--D)a[v]=null,0===v&&u(),v<2&&w.push(o[v+1]),m.goToDate(_.keys(c)[v],null);for(S=0,H=s.length;S<H;S++)C=s[S],C.unfixHighlight(n),C.remove(w)}else{for(x=r(t),g(n,x),f=e(),h(t,t),$=0,M=s.length;$<M;$++)C=s[$],C.unhighlight(t,f),C.fixHighlight(n,f);d===!0&&m.goToDate(n,x),p(n)}return this.shouldExploreDate(l)},t.prototype.shouldExploreDate=function(t){return this.getData(function(){var t,e,n,r;for(r=[],t=0,e=s.length;t<e;t++)n=s[t],r.push(n.exploreDate());return r},t)},t.prototype.shouldRender=function(){var t;return t=m.loadTimelineOnDate(),this.getData(function(){var t,e,n,r;for(r=[],t=0,e=s.length;t<e;t++)n=s[t],r.push(n.render());return r},t)},t.prototype.shouldRedraw=function(){var t,e,n,r;for(r=[],t=0,e=s.length;t<e;t++)n=s[t],r.push(n.redraw());return r},t.prototype.shouldUnhighlightBasedOnCountry=function(t){var e,n,r,l,u,c,h,p;for(l=a.slice(0,o.indexOf(i)),r=_.filter(a,function(t){return null!=t}),e=d(f,r),n=_.find(e.countries,function(e){return e.country===t}),p=[],u=0,c=s.length;u<c;u++)h=s[u],p.push(h.unhighlight(i,n));return p},t.prototype.shouldHighlightBasedOnCountry=function(t){var e,n,r,l,u,c,h,p;for(l=a.slice(0,o.indexOf(i)),r=_.filter(a,function(t){return null!=t}),e=d(f,r),n=_.find(e.countries,function(e){return e.country===t}),p=[],u=0,c=s.length;u<c;u++)h=s[u],p.push(h.highlight(i,n));return p},t.prototype.getDataSet=function(){var t,e,n;return null===c.years?_.values(f):(e=_.values(c).slice(0,o.indexOf(i)),n=d(f,e),t=_.pickBy(n,function(t,e){var n;return n=["date","casualties","incidents","countries"],_.indexOf(n,e)===-1}),_.values(t))},t.prototype.getDateState=function(){return i},t.prototype.getData=function(t,e){return d3.json("data_sample_"+i+".json",function(n){return function(r,o){return r?printError(r):(o.forEach(function(t){var e;if(t.date=l(t.date),e=utils.getFormattedDate(t.date,i),"years"===i&&(f[e]=t),"months"===i&&(f[a[0]][e]=t),"days"===i)return f[a[0]][a[1]][e]=t}),t(),null!==e&&void 0===a[2]&&null!==e[i]&&void 0!==e[i]&&""!==e[i]?n.shouldFixDate(e[i],i,e,!1):void 0)}}(this))},t}();var Transitions;Transitions=function(){function t(t){a=t,r(),c(a.getDateState())}var e,n,r,i,o,a,s,l,u,c,h,p;return p=new Utils,a=null,l=0,o=["years","months","days"],i=null,n=function(){var t,e,n;return n=parseInt($(".dates-container").css("height").replace("px","")),e=n-l,l=n,t=parseInt($(".graph-slot").css("bottom").replace("px","")),$(".graph-slot").css("bottom",t+e+"px")},e=function(){var t;if(t=parseInt($(".dates-container").css("height").replace("px","")),t>=10)return $(".graph-slot").css("bottom",t+"px")},u=function(){var t;return t=parseInt($(".dates-container").css("height").replace("px","")),$(".graph-slot").css("bottom",t+"px")},s=function(){var t;if("days"!==i)return t=o.indexOf(i),o[t+1]},r=function(){return $(".timeaxis").perfectScrollbar({theme:"sod",suppressScrollY:!0}),$(".timeline-container").perfectScrollbar({suppressScrollY:!0})},c=function(t){return i=t,$(".timeaxis."+i).on("ps-scroll-x",function(){return $(".timeline-container").scrollLeft($(this).scrollLeft())}),$(".timeline-container").on("ps-scroll-x",function(){return $(".timeaxis."+i).scrollLeft($(this).scrollLeft())})},h=function(){return $(".timeaxis."+i).off("ps-scroll-x"),$(".timeline-container").off("ps-scroll-x")},t.prototype.highlight=function(t,e){return $(".statistics").addClass("visible"),$(".statistics ul li.incidents span.definition").text(e.incidents),$(".statistics ul li.casualties span.definition").text(e.casualties)},t.prototype.unhighlight=function(t){return $(".statistics").removeClass("visible"),$(".statistics ul li.incidents span.definition").text("Loading..."),$(".statistics ul li.casualties span.definition").text("Loading...")},t.prototype.unfixHighlight=function(t){return $(".graph-slot p.selected-date span").text(a.getDateTextFragments().join(" ")),""===$(".graph-slot p.selected-date span").text().trim()&&$(".graph-slot p.selected-date").removeClass("visible"),h(),c(a.getDateState())},t.prototype.fixHighlight=function(t){return $(".graph-slot p.selected-date span").text(a.getDateTextFragments().join(" ")),$(".graph-slot p.selected-date").addClass("visible"),h(),c(s())},t.prototype.exploreDate=function(){return this.render(),u()},t.prototype.render=function(){return $(".xaxis-container ."+a.getDateState()).addClass("visible")},t.prototype.remove=function(t){var e,n,r;for(n=0,r=t.length;n<r;n++)e=t[n],$(".xaxis-container ."+e).removeClass("visible");return u()},t.prototype.redraw=function(){return p.printLog('{"listener.redraw()": "transitions function not implemented"}')},$(".graph-slot .toggle-timeline").click(function(){return $(this).children("p").children("i").toggleClass("fa-chevron-down"),$(this).children("p").children("i").toggleClass("fa-chevron-up"),$(".dates-container").hasClass("collapsed")?($(".dates-container").removeClass("collapsed"),$(".dates-container").slideDown({duration:"slow",progress:function(t,n,r){return e()}})):($(".dates-container").addClass("collapsed"),$(".dates-container").slideUp({duration:"slow",progress:function(t,n,r){return e()}}))}),$(".breadcrumb-back").click(function(){var t,e,n;return t=["years","months","days"],n=$(".graph-slot p.selected-date span").text().trim().split(" "),e=n.length-1,a.shouldFixDate(n[e],t[e])}),$(".graph-slot .slot").click(function(){return l=parseInt($(".dates-container").css("height").replace("px","")),$(".timeline-container").hasClass("collapsed")?($(".timeline-container").removeClass("collapsed"),$(".timeline-container").slideUp({duration:"slow",progress:function(t,e,r){return n()}})):($(".timeline-container").addClass("collapsed"),$(".timeline-container").slideDown({duration:"slow",progress:function(t,e,r){return n()}}))}),$(window).resize(function(){return a.shouldRedraw()}),t}();var Map;Map=function(){function t(t){r=t,u()}var e,n,r,i,o,a,s,l,u,c,h,p;return p=new Utils,r=null,c=null,n=["years","months","days"],o=!1,h=function(){return 100*(n.indexOf(r.getDateState())+1)},u=function(){return c=d3.select("body .map-container.fixed").append("div").attr("class","world-map-container").append("svg").attr("class","world-map").attr("viewBox","0 0 1000 700").attr("style","max-height: "+(p.height-h())+"px;")},s=d3.geo.mercator().translate([500,500]),a=d3.geo.path().projection(s),i=function(t){var e,i,o,a;if(i=d3.event.target.classList,_.indexOf(i,"years")!==-1&&(e=_.last(i),o=r.getDateState(),a=n.indexOf(o)-1,e===n[a]||e===o&&"days"===o))return t(i[1])},l=function(t){return e(),c.selectAll(".country").data(t.features).enter().append("path").attr("class",function(t){return"country "+t.id}).on("mouseover",function(){return i(function(t){return o=!0,r.shouldHighlightBasedOnCountry(t)})}).on("mouseout",function(){return i(function(t){return r.shouldUnhighlightBasedOnCountry(t),o=!1})}).attr("d",a)},e=function(){var t,e;if(!(p.windowRatio()>=1))return t=parseInt(d3.select(".world-map-container").style("width").replace("px","")),e=t/2-p.height/2,e<0&&(e*=-1),d3.select(".world-map-container").attr("style","margin-top: "+e+"px;")},t.prototype.highlight=function(t,e){var n,r,i,a,s;if(!o){for(a=e.countries,s=[],r=0,i=a.length;r<i;r++)n=a[r],s.push(d3.select(".country."+n.country).classed("highlight",!0));return s}},t.prototype.unhighlight=function(t,e){var n,r,i,a,s;if(!o){for(a=e.countries,s=[],r=0,i=a.length;r<i;r++)n=a[r],s.push(d3.select(".country."+n.country).classed("highlight",!1));return s}},t.prototype.unfixHighlight=function(t){var e,r,i,o,a;for(e=n.indexOf(t),a=[],r=i=o=e;o<=2?i<=2:i>=2;r=o<=2?++i:--i)a.push(c.selectAll(".country."+n[r]).classed(n[r],!1));return a},t.prototype.fixHighlight=function(t,e){var n,r,i,o,a;for(o=e.countries,a=[],r=0,i=o.length;r<i;r++)n=o[r],a.push(c.select(".country."+n.country).classed(t,!0));return a},t.prototype.exploreDate=function(){return c.attr("style","max-height: "+(p.height-h())+"px;")},t.prototype.render=function(t){return p.printLog('{"listener.render()": "map function not implemented"}')},t.prototype.draw=function(t){return d3.json("map.json",function(e,n){var r;return e?console.error(e):(r=topojson.feature(n,n.objects.world_map),l(r),t())})},t.prototype.remove=function(t){return p.printLog('{"listener.remove()": "map function not implemented"}')},t.prototype.redraw=function(){return e()},t}();var Axis;Axis=function(){function t(){}var e,n;return n=new Utils,e=function(t){return t===eventsManager.getDateState()},t.prototype.setSvg=function(t){return d3.select("body .dates-container .xaxis-container ."+t.axisClass).append("svg").attr("class","xaxis").attr("width",t.width).attr("height",t.height).append("g")},t.prototype.setScale=function(t){return d3.time.scale().range([0,t.width-100])},t.prototype.setAxis=function(t){return d3.svg.axis().scale(t).tickSize(0).tickPadding(5).orient("bottom")},t.prototype.configureAxisAndScale=function(t,e,r,i){return t.domain(d3.extent(r,function(t){return t.date})),e.ticks(d3.time[i]),e.tickFormat(function(t){return n.getFormattedDate(t,i)})},t.prototype.renderAxis=function(t,r,i,o){var a,s,l,u,c;for(u=t.append("g").attr("class","x axis").attr("transform","translate("+i.x0+", 0)").on("click",function(){var t;return t=d3.event.target.classList[0].replace("time-",""),o.shouldFixDate(t,i.axisClass)}).on("mouseover",function(){var t;if(e(i.axisClass))return t=d3.event.target.classList[0].replace("time-",""),o.shouldHighlight(t)}).on("mouseout",function(){var t;if(e(i.axisClass))return t=d3.event.target.classList[0].replace("time-",""),o.shouldUnhighlight(t)}).call(r),s=d3.selectAll(".xaxis-container .timeaxis."+i.axisClass+" .x.axis .tick text")[0],a=0,l=s.length;a<l;a++)c=s[a],d3.select(c).attr("class",function(t){return"time-"+n.getFormattedDate(t,o.getDateState())});return u},t.prototype.toggleHighlight=function(t,e,n){return t.selectAll(".time-"+e).classed("highlight",n)},t.prototype.unfixHighlight=function(t,e){return t.selectAll(".tick text").classed("fix-unhighlight",!1),t.selectAll(".tick text").classed("fix-highlight",!1)},t.prototype.fixHighlight=function(t,e,n){var r;if(r=t.select(".tick text.fix-highlight.time-"+n),this.unfixHighlight(t,e),r.empty())return t.selectAll(".tick text").classed("fix-unhighlight",!0),t.select(".tick text.time-"+n).classed("fix-unhighlight",!1).classed("fix-highlight",!0)},t}();var Years;Years=function(){function t(t,r){n=r,i=t,s=e.setSvg(n)}var e,n,r,i,o,a,s,l;return e=new Axis,l=null,r=null,a=null,n=null,i=null,s=null,o=function(){return i.getDateState()===n.axisClass},t.prototype.getScale=function(){return l},t.prototype.highlight=function(t){if(o())return e.toggleHighlight(s,t,!0)},t.prototype.unhighlight=function(t){if(o())return e.toggleHighlight(s,t,!1)},t.prototype.unfixHighlight=function(t){if(t===n.axisClass)return e.unfixHighlight(s,t)},t.prototype.fixHighlight=function(t){var r;if(t===n.axisClass)return r=i.getDateTextFragments()[0],e.fixHighlight(s,t,r)},t.prototype.exploreDate=function(){return utils.printLog('{"listener.exploreDate()": "years function not implemented"}')},t.prototype.render=function(){if(o())return l=e.setScale(n),r=e.setAxis(l),e.configureAxisAndScale(l,r,i.getDataSet(),i.getDateState()),a=e.renderAxis(s,r,n,i)},t.prototype.remove=function(t){return utils.printLog('{"listener.remove()": "years function not implemented"}')},t.prototype.redraw=function(){return utils.printLog('{"listener.redraw()": "years function not implemented"}')},t}();var Months;Months=function(){function t(t,r){n=r,i=t,s=e.setSvg(n)}var e,n,r,i,o,a,s,l;return e=new Axis,l=null,r=null,a=null,n=null,i=null,s=null,o=function(){return i.getDateState()===n.axisClass},t.prototype.getScale=function(){return l},t.prototype.highlight=function(t){if(o())return e.toggleHighlight(s,t,!0)},t.prototype.unhighlight=function(t){if(o())return e.toggleHighlight(s,t,!1)},t.prototype.unfixHighlight=function(t){if(t===n.axisClass)return e.unfixHighlight(s,t)},t.prototype.fixHighlight=function(t){var r;if(t===n.axisClass)return r=i.getDateTextFragments()[1],e.fixHighlight(s,t,r)},t.prototype.exploreDate=function(){if(!a)return this.render()},t.prototype.render=function(){if(o())return l=e.setScale(n),r=e.setAxis(l),e.configureAxisAndScale(l,r,i.getDataSet(),i.getDateState()),a=e.renderAxis(s,r,n,i)},t.prototype.remove=function(t){if(t.indexOf(n.axisClass)!==-1)return a?(a.remove(),a=null):void 0},t.prototype.redraw=function(){return utils.printLog('{"listener.redraw()": "months function not implemented"}')},t}();var Days;Days=function(){function t(t,r){n=r,i=t,s=e.setSvg(n)}var e,n,r,i,o,a,s,l;return e=new Axis,l=null,r=null,a=null,n=null,i=null,s=null,o=function(){return i.getDateState()===n.axisClass},t.prototype.getScale=function(){return l},t.prototype.highlight=function(t){if(o())return e.toggleHighlight(s,t,!0)},t.prototype.unhighlight=function(t){if(o())return e.toggleHighlight(s,t,!1)},t.prototype.unfixHighlight=function(t){if(t===n.axisClass)return e.unfixHighlight(s,t)},t.prototype.fixHighlight=function(t){var r;if(t===n.axisClass)return r=i.getDateTextFragments()[2],e.fixHighlight(s,t,r)},t.prototype.exploreDate=function(){if(!a)return this.render()},t.prototype.render=function(){if(o())return l=e.setScale(n),r=e.setAxis(l),e.configureAxisAndScale(l,r,i.getDataSet(),i.getDateState()),a=e.renderAxis(s,r,n,i)},t.prototype.remove=function(t){if(t.indexOf(n.axisClass)!==-1)return a?(a.remove(),a=null):void 0},t.prototype.redraw=function(){return utils.printLog('{"listener.redraw()": "days function not implemented"}')},t}();var Dots;Dots=function(){function t(t,e,n){o=e,l=n,h=t,d=d3.scale.linear().range([o.height-10,o.height/2]),g=d3.scale.linear().range([o.height-10,10])}var e,n,r,i,o,a,s,l,u,c,h,p,g,d;return p=new Utils,i=null,r=null,c=null,u=null,d=null,g=null,h=null,l=null,o={height:0,xHeight:0,x0:0},n=function(){return d.domain([0,d3.max(l.getDataSet(),function(t){return t.incidents})]),g.domain([0,d3.max(l.getDataSet(),function(t){return t.casualties})])},s=function(t,e){return h.getSvg().append("path").datum(l.getDataSet()).attr("class","line-chart "+e).attr("d",t).attr("transform","translate("+o.x0+", 0)")},a=function(t,e,n,r,i){return t.append("circle").attr("class",function(t){var e;return e=p.getFormattedDate(t.date,l.getDateState()),"time-"+e+" dot "+n}).attr("r",r).attr("cx",function(t){return e(t.date)}).attr("cy",function(t){return i(t)}).attr("transform","translate("+o.x0+", 0)").on("click",function(t){var e;return e=d3.event.target.classList[0].replace("time-",""),l.shouldFixDate(e,l.getDateState())}).on("mouseover",function(t){var e;return e=d3.event.target.classList[0].replace("time-",""),l.shouldHighlight(e)}).on("mouseout",function(t){var e;return e=d3.event.target.classList[0].replace("time-",""),l.shouldUnhighlight(e)})},e=function(t,e,n){return d3.svg.line().x(function(e){return t(e.date)}).y(function(t){return e(t[n])})},t.prototype.remove=function(){if(i&&i.remove(),r&&r.remove(),c&&c.remove(),u)return u.remove()},t.prototype.draw=function(t,o){return n(),c=s(e(o,d,"incidents"),"incidents"),i=a(t,o,"incidents",5,function(t){return d(t.incidents)}),u=s(e(o,g,"casualties"),"casualties"),r=a(t,o,"casualties",6,function(t){return g(t.casualties)})},t}();var Timeline;Timeline=function(){function t(t,n,o){var a;i=o,u=n,s(),a={height:u.height,xHeight:p,x0:u.x0},r=new Dots(this,a,i),e=t}var e,n,r,i,o,a,s,l,u,c,h,p,g;return h=new Utils,r=null,e=null,i=null,g=null,o=null,l=null,u={height:0,width:0,x0:0},p=50,s=function(){return l=d3.select("body .dates-container .timeline-container").attr("style",h.sizeStyles(u.width,"auto")).append("svg").attr("class","timeline").attr("width",u.width).attr("height",u.height).append("g")},c=function(t,e){var n;return n=h.getFormattedDate(t.date,i.getDateState()),l.selectAll(".time-"+n).classed("highlight",e)},n=function(){return g.domain(d3.extent(i.getDataSet(),function(t){return t.date}))},a=function(){var t;return r.remove(),g=e.getScale(),n(),t=l.selectAll("dot").data(i.getDataSet()).enter(),r.draw(t,g)},t.prototype.getSvg=function(){return l},t.prototype.highlight=function(t,e){return c(e,!0)},t.prototype.unhighlight=function(t,e){return c(e,!1)},t.prototype.unfixHighlight=function(t){return h.printLog('{"listener.fixHighlight(dataSet)": "timeline function not implemented"}')},t.prototype.fixHighlight=function(t){return h.printLog('{"listener.fixHighlight(dataSet)": "timeline function not implemented"}')},t.prototype.exploreDate=function(t){return a()},t.prototype.render=function(){return a()},t.prototype.remove=function(){return h.printLog('{"listener.remove()": "timeline function not implemented"}')},t.prototype.redraw=function(){return h.printLog('{"listener.redraw()": "timeline function not implemented"}')},t}();var days,daysProperties3,eventsManager,map,months,monthsProperties2,timeline,timelineProperties,transitions,urlManager,utils,years,yearsProperties;urlManager=new UrlManager,eventsManager=new EventsManager(urlManager),utils=new Utils,transitions=new Transitions(eventsManager),map=new Map(eventsManager),yearsProperties={width:3e3,height:50,x0:50,y0:0,axisClass:"years"},years=new Years(eventsManager,yearsProperties),monthsProperties2={width:3e3,height:50,x0:50,y0:0,axisClass:"months"},months=new Months(eventsManager,monthsProperties2),daysProperties3={width:3e3,height:50,x0:50,y0:0,axisClass:"days"},days=new Days(eventsManager,daysProperties3),timelineProperties={width:3e3,height:utils.timelineHeight,x0:60},timeline=new Timeline(years,timelineProperties,eventsManager),eventsManager.addListener(map),eventsManager.addListener(years),eventsManager.addListener(months),eventsManager.addListener(days),eventsManager.addListener(transitions),eventsManager.addListener(timeline),map.draw(function(){return eventsManager.shouldRender()});