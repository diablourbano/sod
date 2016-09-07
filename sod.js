"use strict";var Utils;Utils=function(){function t(){}return t.prototype.height=window.innerHeight,t.prototype.width=window.innerWidth,t.prototype.timelineHeight=350,t.prototype.windowRatio=function(){return window.innerWidth/window.innerHeight},t.prototype.sizeStyles=function(t,e){return null==t&&(t=this.width),null==e&&(e=this.height),"auto"!==t&&(t+="px"),"auto"!==e&&(e+="px"),["width:"+t,"height:"+e].join(";")},t.prototype.getFormattedDate=function(t,e){var n;return"years"===e&&(n="Y"),"months"===e&&(n="MMMM"),"days"===e&&(n="Do"),moment(t).format(n)},t.prototype.printLog=function(t){},t}();var UrlManager;UrlManager=function(){function t(){}var e,n,r,i,o,a;return a=new Utils,i={years:null,months:null,days:null},r=function(t){switch(parseInt(t[1])){case 1:case 3:case 5:case 7:case 8:case 10:case 12:return 31;case 2:return _.endsWith(t[0],"00")&&parseInt(t[0])%400===0||parseInt(t[0])%4===0?28:29;default:return 30}},e=function(t){var e;return e=moment().year(parseInt(t[0])),t[1]&&""!==t[1]&&e.month(parseInt(t[1])-1),t[2]&&""!==t[2]&&e.date(parseInt(t[2])),e.format("Y MMMM Do").split(" ")},n=function(t){var e,n,i,o,a;return n=t.split("/"),e=[],null!==n[0].match(/^\d{4}/)&&1970<=(i=parseInt(n[0]))&&i<=2014?(e[0]=n[0],void 0!==n[1]&&null!==n[1].match(/^\d{1,2}$/)&&1<=(o=parseInt(n[1]))&&o<=12&&(1===n[1].length&&(n[1]="0"+n[1]),e[1]=n[1],void 0!==n[2]&&null!==n[2].match(/^\d{1,2}$/)&&1<=(a=parseInt(n[2]))&&a<=r(n)&&(1===n[2].length&&(n[2]="0"+n[2]),e[2]=n[2])),e):null},o=function(){return window.location.href="#/"+_.filter(i,function(t){return null!==t&&""!==t}).join("/")},t.prototype.loadTimelineOnDate=function(){var t,r,a,s;return r=location.hash.replace("#/",""),0===r.length?null:(t=n(r),i=_.zipObject(_.keys(i),t),o(),s=e(t),a=i,a.years=s[0],a.months&&""!==a.months&&(a.months=s[1]),a.days&&""!==a.days&&(a.days=s[2]),a)},t.prototype.goToDate=function(t,e){return e&&("months"===t&&(e=(moment().month(e.toLowerCase()).month()+1).toString()),1===e.length&&(e="0"+e)),i[t]=e,o()},t}();var EventsManager;EventsManager=function(){function t(t){y=t}var e,n,r,i,o,a,s,l,u,c,h,p,d,f,g,x,m,y,v;return u=[],i="years",o=["years","months","days"],m={},p={years:null,months:"January",days:"01"},a=[],y=null,v=new Utils,c=d3.time.format("%Y-%m-%d").parse,x=function(t,e){var n;return n=e.shift(),void 0!==t[n]?0===e.length?t[n]:x(t[n],e):null},e=function(){var t,e;return e=_.values(p),e[2]=n(e[2]),t=e.slice(0,o.indexOf(i)+1),x(m,t)},g=function(t,e){return e&&1===e.length&&(e="0"+e),p[t]=e},d=function(t,e){var n;return t=t.trim(),n=$(".graph-slot p.selected-date span").text().trim(),""!==n&&(a=n.split(" ")),null!==t.match(/^\d{4}$/)?a[0]=e:null!==t.match(/^\D+$/)?a[1]=e:null!==t.match(/^\d{1,2}\D{2}$/)?a[2]=e:void 0},f=function(t){var e;if("days"!==i)return e=o.indexOf(t),i=o[e+1]},h=function(){return g("years",null),g("months","January"),g("days","01")},r=function(t){return null!==t.match(/(st|nd|rd|th)/)&&(t=t.replace(/(st|nd|rd|th)/,"")),t},n=function(t){var e;return e=parseInt(t),1===e&&11!==e?e+"st":2===e&&12!==e?e+"nd":3===e&&13!==e?e+"rd":e+"th"},s=function(t){var e,n;return e=[],t.length>0&&(t[0]&&e.push(a[0]),t[1]&&(n=t[1],n&&(n=(moment().month(n.toLowerCase()).month()+1).toString(),1===n.length&&(n="0"+n),e.push(n)))),e},l=function(t){return!_.isEmpty(m)&&(1===t.length?void 0!==m[t[0]].January:2!==t.length||void 0!==m[t[0]][t[1]]["1st"])},t.prototype.getDateTextFragments=function(){return a},t.prototype.addListener=function(t){if(u.indexOf(t)===-1)return u.push(t)},t.prototype.shouldHighlight=function(t){var n,o,a,s,l,c,h;for(n=_.map(t,function(t){return t.replace("time-","")}),a=r(n[0]),g(i,a),o=e(),h=[],s=0,l=u.length;s<l;s++)c=u[s],h.push(c.highlight(n,o));return h},t.prototype.shouldUnhighlight=function(t){var n,o,a,s,l,c,h;for(n=_.map(t,function(t){return t.replace("time-","")}),a=r(n[0]),g(i,a),o=e(),h=[],s=0,l=u.length;s<l;s++)c=u[s],h.push(c.unhighlight(n,o));return h},t.prototype.shouldFixDate=function(t,n,s,l){var c,x,m,v,w,D,$,S,C,H,L,A;if(null==s&&(s=null),null==l&&(l=!0),m=a.indexOf(t),m>-1){for(w=[],i=o[m],v=D=A=m;A<=2?D<=2:D>=2;v=A<=2?++D:--D)a[v]=null,0===v&&h(),v<2&&w.push(o[v+1]),y.goToDate(_.keys(p)[v],null);for($=0,C=u.length;$<C;$++)L=u[$],L.unfixHighlight(n),L.remove(w)}else{if(x=r(t),g(n,x),c=e(),!c)return;for(d(t,t),S=0,H=u.length;S<H;S++)L=u[S],L.unhighlight(t,c),L.fixHighlight(n,c);l===!0&&y.goToDate(n,x),f(n)}return this.shouldExploreDate(s)},t.prototype.shouldExploreDate=function(t){return this.getData(function(){var t,e,n,r;for(r=[],t=0,e=u.length;t<e;t++)n=u[t],r.push(n.exploreDate());return r},t)},t.prototype.shouldRender=function(){var t;return t=y.loadTimelineOnDate(),this.getData(function(){var t,e,n,r;for(r=[],t=0,e=u.length;t<e;t++)n=u[t],r.push(n.render());return r},t)},t.prototype.shouldRedraw=function(){var t,e,n,r;for(r=[],t=0,e=u.length;t<e;t++)n=u[t],r.push(n.redraw());return r},t.prototype.shouldUnhighlightBasedOnCountry=function(t){var e,n,r,s,l,c,h,p,d;for(n=t[1],l=a.slice(0,o.indexOf(i)),s=_.filter(a,function(t){return null!=t}),e=x(m,s),r=_.find(e.countries,function(t){return t.country===n}),d=[],c=0,h=u.length;c<h;c++)p=u[c],d.push(p.unhighlightByCountry(i,r));return d},t.prototype.shouldHighlightBasedOnCountry=function(t){var e,n,r,s,l,c,h,p,d,f,g,y;for(n=t[1],c=a.slice(0,o.indexOf(i)),l=_.filter(a,function(t){return null!=t}),e=x(m,l),s=_.find(e.countries,function(t){return t.country===n}),h=0,d=t.length;h<d;h++)r=t[h],c.unshift(r);for(y=[],p=0,f=u.length;p<f;p++)g=u[p],y.push(g.highlightByCountry(c,s));return y},t.prototype.getDataSet=function(){var t,e,n;return null===p.years?_.values(m):(e=_.values(p).slice(0,o.indexOf(i)),n=x(m,e),t=_.pickBy(n,function(t,e){var n;return n=["date","casualties","incidents","countries"],_.indexOf(n,e)===-1}),_.values(t))},t.prototype.getDateState=function(){return i},t.prototype.getData=function(t,e){var n;if(n=_.filter(a,function(t){return null!==t}),3===n.length){if(t(),e&&!a[2]&&e[i])return this.shouldFixDate(e[i],i,e,!1)}else{if(!l(n))return d3.json(cors_origin+"/"+s(n).join("/"),function(n){return function(r,o){return r?printError(r):(o.forEach(function(t){var e;if(t.date=c(t.date),e=v.getFormattedDate(t.date,i),"years"===i&&(m[e]=t),"months"===i&&(m[a[0]][e]=t),"days"===i)return m[a[0]][a[1]][e]=t}),t(),e&&!a[2]&&e[i]?n.shouldFixDate(e[i],i,e,!1):void 0)}}(this));if(t(),e&&!a[2]&&e[i])return this.shouldFixDate(e[i],i,e,!1)}},t}();var Transitions;Transitions=function(){function t(t){l=t,r(),p(l.getDateState())}var e,n,r,i,o,a,s,l,u,c,h,p,d,f;return f=new Utils,l=null,c=0,o=["years","months","days"],i=null,n=function(){var t,e,n;return n=parseInt($(".dates-container").css("height").replace("px","")),e=n-c,c=n,t=parseInt($(".graph-slot").css("bottom").replace("px","")),$(".graph-slot").css("bottom",t+e+"px")},e=function(){var t;if(t=parseInt($(".dates-container").css("height").replace("px","")),t>=10)return $(".graph-slot").css("bottom",t+"px")},h=function(){var t;return t=parseInt($(".dates-container").css("height").replace("px","")),$(".graph-slot").css("bottom",t+"px")},u=function(){var t;if("days"!==i)return t=o.indexOf(i),o[t+1]},r=function(){return $(".timeaxis").perfectScrollbar({theme:"sod",suppressScrollY:!0}),$(".timeline-container").perfectScrollbar({suppressScrollY:!0})},p=function(t){return i=t,$(".timeaxis."+i).on("ps-scroll-x",function(){return $(".timeline-container").scrollLeft($(this).scrollLeft())}),$(".timeline-container").on("ps-scroll-x",function(){return $(".timeaxis."+i).scrollLeft($(this).scrollLeft())})},d=function(){return $(".timeaxis."+i).off("ps-scroll-x"),$(".timeline-container").off("ps-scroll-x")},s=function(t,e){var n,r;return r=$(".xaxis .time-"+t[0]).parent().position().left,$(".statistics").css("left",r+"px"),n=parseInt($(".xaxis .time-"+t[0]).parents(".timeaxis").css("height").replace("px","")),$(".statistics").css("bottom",n+25+"px"),$(".statistics").addClass("visible"),$(".statistics ul li.incidents span.definition").text(e.incidents),$(".statistics ul li.casualties span.definition").text(e.casualties)},a=function(t,e){var n,r,i,o,a,s,l,u,c;if(e){for(_.includes(t,"dot")||t.push("dot","casualties"),u=parseInt($(".time-"+t.join(".")).attr("cx"))+15,n={firstClasses:_.join(t,"."),secondClasses:_.join(t,"."),firstStat:"casualties",secondStat:"incidents"},_.includes(t,"incidents")&&(n.firstStat="incidents",n.secondStat="casualties"),n.secondClasses=_.replace(n.firstClasses,n.firstStat,n.secondStat),a=["first","second"],s=[],r=0,i=a.length;r<i;r++)o=a[r],c=$(".time-"+n[o+"Classes"]).position().top-60,l=n[o+"Stat"],$(".stats-"+l).css("top",c+"px"),$(".stats-"+l).css("left",u+"px"),$(".stats-"+l).addClass("visible"),s.push($(".stats-"+l+" ul li."+l+" span.definition").text(e[l]));return s}},t.prototype.highlight=function(t,e){return e||(e={incidents:0,casualties:0}),$(".timeline-container").hasClass("collapsed")?a(t,e):s(t,e)},t.prototype.unhighlight=function(t){return $(".statistics").removeClass("visible"),$(".statistics ul li.incidents span.definition").text("Loading..."),$(".statistics ul li.casualties span.definition").text("Loading..."),$(".stats-incidents").removeClass("visible"),$(".stats-casualties").removeClass("visible")},t.prototype.unfixHighlight=function(t){return $(".graph-slot p.selected-date span").text(l.getDateTextFragments().join(" ")),""===$(".graph-slot p.selected-date span").text().trim()&&$(".graph-slot p.selected-date").removeClass("visible"),d(),p(l.getDateState())},t.prototype.fixHighlight=function(t){return $(".graph-slot p.selected-date span").text(l.getDateTextFragments().join(" ")),$(".graph-slot p.selected-date").addClass("visible"),d(),p(u())},t.prototype.exploreDate=function(){return this.render(),h()},t.prototype.render=function(){return $(".xaxis-container ."+l.getDateState()).addClass("visible")},t.prototype.remove=function(t){var e,n,r;for(n=0,r=t.length;n<r;n++)e=t[n],$(".xaxis-container ."+e).removeClass("visible");return h()},t.prototype.redraw=function(){return f.printLog('{"listener.redraw()": "transitions function not implemented"}')},$(".graph-slot .toggle-timeline").click(function(){return $(this).children("p").children("i").toggleClass("fa-chevron-down"),$(this).children("p").children("i").toggleClass("fa-chevron-up"),$(".dates-container .xaxis-container").hasClass("collapsed")?($(".dates-container .xaxis-container").removeClass("collapsed"),$(".dates-container .xaxis-container").slideDown({duration:"slow",progress:function(t,n,r){return e(),l.shouldRedraw()}})):($(".dates-container .xaxis-container").addClass("collapsed"),$(".dates-container .xaxis-container").slideUp({duration:"slow",progress:function(t,n,r){return e(),l.shouldRedraw()}}))}),$(".breadcrumb-back").click(function(){var t,e,n;return t=["years","months","days"],n=$(".graph-slot p.selected-date span").text().trim().split(" "),e=n.length-1,l.shouldFixDate(n[e],t[e])}),$(".graph-slot .slot").click(function(){return c=parseInt($(".dates-container").css("height").replace("px","")),$(".timeline-container").hasClass("collapsed")?($(".timeline-container").removeClass("collapsed"),$(".timeline-container").slideUp({duration:"slow",progress:function(t,e,r){return n()}})):($(".timeline-container").addClass("collapsed"),$(".timeline-container").slideDown({duration:"slow",progress:function(t,e,r){return n()}}))}),$(window).resize(function(){return l.shouldRedraw()}),t}();var Map;Map=function(){function t(t){r=t,s()}var e,n,r,i,o,a,s,l,u,c,h;return h=new Utils,r=null,u=null,n=["years","months","days"],c=function(){return $(".dates-container .xaxis-container").height()},s=function(){return u=d3.select("body .map-container.fixed").append("div").attr("class","world-map-container").append("svg").attr("class","world-map").attr("viewBox","0 0 1000 730").attr("width","100%").attr("height",h.height+"px").call(d3.behavior.zoom().on("zoom",function(){return u.attr("transform","translate("+d3.event.translate+")scale("+d3.event.scale+")")})).append("g").attr("style","max-height: "+(h.height-c())+"px;")},o=d3.geo.mercator().translate([500,500]),i=d3.geo.path().projection(o),l=function(t){var e,i,o,a;if(i=d3.event.target.classList,_.indexOf(i,"years")!==-1&&(e=_.last(i),o=r.getDateState(),a=n.indexOf(o)-1,e===n[a]||e===o&&"days"===o))return t(i)},a=function(t){return e(),u.selectAll(".country").data(t.features).enter().append("path").attr("class",function(t){return"country "+t.id}).attr("d",i)},e=function(){return d3.select(".world-map-container").attr("style","padding-bottom: "+h.height+"px;")},t.prototype.highlight=function(t,e){var n,r,i,o,a;if(e){for(o=e.countries,a=[],r=0,i=o.length;r<i;r++)n=o[r],a.push(d3.select(".country."+n.country).classed("highlight",!0));return a}},t.prototype.unhighlight=function(t,e){var n,r,i,o,a;if(e){for(o=e.countries,a=[],r=0,i=o.length;r<i;r++)n=o[r],a.push(d3.select(".country."+n.country).classed("highlight",!1));return a}},t.prototype.unfixHighlight=function(t){var e,r,i,o,a;for(e=n.indexOf(t),a=[],r=i=o=e;o<=2?i<=2:i>=2;r=o<=2?++i:--i)a.push(u.selectAll(".country."+n[r]).classed(n[r],!1));return a},t.prototype.fixHighlight=function(t,e){var n,r,i,o,a;for(o=e.countries,a=[],r=0,i=o.length;r<i;r++)n=o[r],a.push(u.select(".country."+n.country).classed(t,!0));return a},t.prototype.exploreDate=function(){return u.attr("style","max-height: "+(h.height-c())+"px;")},t.prototype.render=function(t){return h.printLog('{"listener.render()": "map function not implemented"}')},t.prototype.draw=function(t){return d3.json("map.json",function(e,n){var r;return e?h.printLog(e):(r=topojson.feature(n,n.objects.world_map),a(r),t())})},t.prototype.remove=function(t){return h.printLog('{"listener.remove()": "map function not implemented"}')},t.prototype.redraw=function(){return e(),u.attr("style","max-height: "+(h.height-c())+"px;")},t}();var Axis;Axis=function(){function t(){}var e,n;return n=new Utils,e=function(t,e){return t===e},t.prototype.setSvg=function(t){return d3.select("body .dates-container .xaxis-container ."+t.axisClass).append("svg").attr("class","xaxis").attr("width",t.width).attr("height",t.height).append("g")},t.prototype.setScale=function(t){return d3.time.scale().range([0,t.width-100])},t.prototype.setAxis=function(t){return d3.svg.axis().scale(t).tickSize(0).tickPadding(5).orient("bottom")},t.prototype.configureAxisAndScale=function(t,e,r,i){return t.domain(d3.extent(r,function(t){return t.date})),e.ticks(d3.time[i]),e.tickFormat(function(t){return n.getFormattedDate(t,i)})},t.prototype.renderAxis=function(t,r,i,o){var a,s,l,u,c;for(u=t.append("g").attr("class","x axis").attr("transform","translate("+i.x0+", 0)").on("click",function(){var t;return t=d3.event.target.classList[0].replace("time-",""),o.shouldFixDate(t,i.axisClass)}).on("mouseover",function(){var t;if(e(i.axisClass,o.getDateState()))return t=d3.event.target.classList,o.shouldHighlight(t)}).on("mouseout",function(){var t;if(e(i.axisClass,o.getDateState()))return t=d3.event.target.classList,o.shouldUnhighlight(t)}).call(r),s=d3.selectAll(".xaxis-container .timeaxis."+i.axisClass+" .x.axis .tick text")[0],a=0,l=s.length;a<l;a++)c=s[a],d3.select(c).attr("class",function(t){return"time-"+n.getFormattedDate(t,o.getDateState())});return u},t.prototype.toggleHighlight=function(t,e,n){return t.selectAll(".time-"+e).classed("highlight",n)},t.prototype.unfixHighlight=function(t,e){return t.selectAll(".tick text").classed("fix-unhighlight",!1),t.selectAll(".tick text").classed("fix-highlight",!1)},t.prototype.fixHighlight=function(t,e,n){var r;if(r=t.select(".tick text.fix-highlight.time-"+n),this.unfixHighlight(t,e),r.empty())return t.selectAll(".tick text").classed("fix-unhighlight",!0),t.select(".tick text.time-"+n).classed("fix-unhighlight",!1).classed("fix-highlight",!0)},t}();var Years;Years=function(){function t(t,r){n=r,i=t,s=e.setSvg(n)}var e,n,r,i,o,a,s,l,u;return e=new Axis,u=null,r=null,a=null,n=null,i=null,s=null,l=new Utils,o=function(){return i.getDateState()===n.axisClass},t.prototype.getScale=function(){return u},t.prototype.highlight=function(t){if(o())return e.toggleHighlight(s,t,!0)},t.prototype.unhighlight=function(t){if(o())return e.toggleHighlight(s,t,!1)},t.prototype.unfixHighlight=function(t){if(t===n.axisClass)return e.unfixHighlight(s,t)},t.prototype.fixHighlight=function(t){var r;if(t===n.axisClass)return r=i.getDateTextFragments()[0],e.fixHighlight(s,t,r)},t.prototype.exploreDate=function(){return l.printLog('{"listener.exploreDate()": "years function not implemented"}')},t.prototype.render=function(){if(o())return u=e.setScale(n),r=e.setAxis(u),e.configureAxisAndScale(u,r,i.getDataSet(),i.getDateState()),a=e.renderAxis(s,r,n,i)},t.prototype.remove=function(t){return l.printLog('{"listener.remove()": "years function not implemented"}')},t.prototype.redraw=function(){return l.printLog('{"listener.redraw()": "years function not implemented"}')},t}();var Months;Months=function(){function t(t,r){n=r,i=t,s=e.setSvg(n)}var e,n,r,i,o,a,s,l,u;return e=new Axis,u=null,r=null,a=null,n=null,i=null,s=null,l=new Utils,o=function(){return i.getDateState()===n.axisClass},t.prototype.getScale=function(){return u},t.prototype.highlight=function(t){if(o())return e.toggleHighlight(s,t,!0)},t.prototype.unhighlight=function(t){if(o())return e.toggleHighlight(s,t,!1)},t.prototype.unfixHighlight=function(t){if(t===n.axisClass)return e.unfixHighlight(s,t)},t.prototype.fixHighlight=function(t){var r;if(t===n.axisClass)return r=i.getDateTextFragments()[1],e.fixHighlight(s,t,r)},t.prototype.exploreDate=function(){if(!a)return this.render()},t.prototype.render=function(){if(o())return u=e.setScale(n),r=e.setAxis(u),e.configureAxisAndScale(u,r,i.getDataSet(),i.getDateState()),a=e.renderAxis(s,r,n,i)},t.prototype.remove=function(t){if(t.indexOf(n.axisClass)!==-1)return a?(a.remove(),a=null):void 0},t.prototype.redraw=function(){return l.printLog('{"listener.redraw()": "months function not implemented"}')},t}();var Days;Days=function(){function t(t,r){n=r,i=t,s=e.setSvg(n)}var e,n,r,i,o,a,s,l,u;return e=new Axis,u=null,r=null,a=null,n=null,i=null,s=null,l=new Utils,o=function(){return i.getDateState()===n.axisClass},t.prototype.getScale=function(){return u},t.prototype.highlight=function(t){if(o())return e.toggleHighlight(s,t,!0)},t.prototype.unhighlight=function(t){if(o())return e.toggleHighlight(s,t,!1)},t.prototype.unfixHighlight=function(t){if(t===n.axisClass)return e.unfixHighlight(s,t)},t.prototype.fixHighlight=function(t){var r;if(t===n.axisClass)return r=i.getDateTextFragments()[2],e.fixHighlight(s,t,r)},t.prototype.exploreDate=function(){if(!a)return this.render()},t.prototype.render=function(){if(o())return u=e.setScale(n),r=e.setAxis(u),e.configureAxisAndScale(u,r,i.getDataSet(),i.getDateState()),a=e.renderAxis(s,r,n,i)},t.prototype.remove=function(t){if(t.indexOf(n.axisClass)!==-1)return a?(a.remove(),a=null):void 0},t.prototype.redraw=function(){return l.printLog('{"listener.redraw()": "days function not implemented"}')},t}();var Dots;Dots=function(){function t(t,e,n){var r,i;a=e,u=n,p=t,i=a.height/2,r=a.height,f=d3.scale.linear().range([r-20,i+20]),g=d3.scale.linear().range([i-20,50])}var e,n,r,i,o,a,s,l,u,c,h,p,d,f,g;return d=new Utils,o=null,i=null,h=null,c=null,g=null,f=null,p=null,u=null,a={height:0,xHeight:0,x0:0},r=function(){return g.domain([0,d3.max(u.getDataSet(),function(t){return t.incidents})]),f.domain([0,d3.max(u.getDataSet(),function(t){return t.casualties})])},n=function(t){return d3.svg.axis().scale(t).orient("left").tickSize(2).ticks(5)},l=function(t,e,n){return p.getSvg().append("path").datum(u.getDataSet()).attr("class","line-chart "+e).attr("d",t).attr("transform","translate("+a.x0+", 0)"),p.getSvg().append("g").attr("class","yaxis").attr("transform","translate(40, 0)").call(n)},s=function(t,e,n,r,i){return t.append("circle").attr("class",function(t){var e;return e=d.getFormattedDate(t.date,u.getDateState()),"time-"+e+" dot "+n}).attr("r",r).attr("cx",function(t){return e(t.date)}).attr("cy",function(t){return i(t)}).attr("transform","translate("+a.x0+", 0)").on("click",function(t){var e;return e=d3.event.target.classList[0].replace("time-",""),u.shouldFixDate(e,u.getDateState())}).on("mouseover",function(t){var e;return e=d3.event.target.classList,u.shouldHighlight(e)}).on("mouseout",function(t){var e;return e=d3.event.target.classList,u.shouldUnhighlight(e)})},e=function(t,e,n){return d3.svg.line().x(function(e){return t(e.date)}).y(function(t){return e(t[n])})},t.prototype.remove=function(){return o&&o.remove(),i&&i.remove(),h&&h.remove(),c&&c.remove(),p.getSvg().selectAll("path").remove()},t.prototype.draw=function(t,a){var u,p,d;return r(),u=6,p=n(f),d=n(g),c=l(e(a,f,"casualties"),"casualties",p),i=s(t,a,"casualties",u,function(t){return f(t.casualties)}),h=l(e(a,g,"incidents"),"incidents",d),o=s(t,a,"incidents",u,function(t){return g(t.incidents)})},t}();var Timeline;Timeline=function(){function t(t,n,o){var a;i=o,u=n,s(),a={height:u.height,xHeight:p,x0:u.x0},r=new Dots(this,a,i),e=t}var e,n,r,i,o,a,s,l,u,c,h,p,d;return h=new Utils,r=null,e=null,i=null,d=null,o=null,l=null,u={height:0,width:0,x0:0},p=50,s=function(){return l=d3.select("body .dates-container .timeline-container").attr("style",h.sizeStyles(u.width,"auto")).append("svg").attr("class","timeline").attr("width",u.width).attr("height",u.height).append("g")},c=function(t,e){var n;if(t)return n=h.getFormattedDate(t.date,i.getDateState()),l.selectAll(".time-"+n).classed("highlight",e)},n=function(){return d.domain(d3.extent(i.getDataSet(),function(t){return t.date}))},a=function(){var t;return r.remove(),d=e.getScale(),n(),t=l.selectAll("dot").data(i.getDataSet()).enter(),r.draw(t,d)},t.prototype.getSvg=function(){return l},t.prototype.highlight=function(t,e){return c(e,!0)},t.prototype.unhighlight=function(t,e){return c(e,!1)},t.prototype.unfixHighlight=function(t){return h.printLog('{"listener.fixHighlight(dataSet)": "timeline function not implemented"}')},t.prototype.fixHighlight=function(t){return h.printLog('{"listener.fixHighlight(dataSet)": "timeline function not implemented"}')},t.prototype.exploreDate=function(t){return a()},t.prototype.render=function(){return a()},t.prototype.remove=function(){return h.printLog('{"listener.remove()": "timeline function not implemented"}')},t.prototype.redraw=function(){return h.printLog('{"listener.redraw()": "timeline function not implemented"}')},t}();var MainController,mainController;MainController=function(){function t(){r.addListener(i),r.addListener(p),r.addListener(o),r.addListener(e),r.addListener(u),r.addListener(s)}var e,n,r,i,o,a,s,l,u,c,h,p,d;return c=new UrlManager,r=new EventsManager(c),h=new Utils,u=new Transitions(r),i=new Map(r),d={width:3e3,height:50,x0:50,y0:0,axisClass:"years"},p=new Years(r,d),a={width:3e3,height:50,x0:50,y0:0,axisClass:"months"},o=new Months(r,a),n={width:3e3,height:50,x0:50,y0:0,axisClass:"days"},e=new Days(r,n),l={width:3e3,height:h.timelineHeight,x0:60},s=new Timeline(p,l,r),t.prototype.draw=function(){return i.draw(function(){return r.shouldRender()})},t}(),mainController=new MainController,mainController.draw();