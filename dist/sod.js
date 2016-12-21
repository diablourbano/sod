sod_locale.en={incidents:{label:"Incidentes"},casualties:{label:"Casualties"}},moment.locale("es",{months:"Enero_Febrero_Marzo_Abril_Mayo_Junio_Julio_Agosto_Septiembre_Octubre_Noviembre_Diciembre".split("_"),monthsShort:"ene_feb_mars_abr_may_jun_jul_ago_sept_oct_nov_dic".split("_"),weekdays:"domingo_lunes_martes_miércoles_jueves_viernes_sábado".split("_"),weekdaysShort:"dom_lun_mar_mier_jue._vie._sab.".split("_"),weekdaysMin:"Do_Lu_Ma_Mi_Ju_Vi_Sa".split("_"),longDateFormat:{LT:"HH:mm",LTS:"HH:mm:ss",L:"DD/MM/YYYY",LL:"D MMMM YYYY",LLL:"D MMMM YYYY LT",LLLL:"dddd D MMMM YYYY LT"},calendar:{sameDay:"[Hoy es] LT",nextDay:"[Manana] LT",nextWeek:"dddd [de] LT",lastDay:"[Ayer] LT",lastWeek:"dddd [pasado] LT",sameElse:"L"},relativeTime:{future:"dans %s",past:"il y a %s",s:"quelques secondes",m:"une minute",mm:"%d minutes",h:"une heure",hh:"%d heures",d:"un jour",dd:"%d jours",M:"un mois",MM:"%d mois",y:"une année",yy:"%d années"},ordinalParse:/\d{1,2}/,ordinal:function(t){return t},meridiemParse:/AM|PM/,isPM:function(t){return"P"===t.charAt(0)},meridiem:function(t,e,n){return t<12?"AM":"PM"},week:{dow:1,doy:4}}),sod_locale.es={incidents:{label:"Incidentes"},casualties:{label:"Víctimas"}},moment.locale("fr",{months:"Janvier_Février_Mars_Avril_Mai_Juin_Juillet_Août_Septembre_Octobre_Novembre_Décembre".split("_"),monthsShort:"janv._févr._mars_avr._mai_juin_juil._août_sept._oct._nov._déc.".split("_"),weekdays:"dimanche_lundi_mardi_mercredi_jeudi_vendredi_samedi".split("_"),weekdaysShort:"dim._lun._mar._mer._jeu._ven._sam.".split("_"),weekdaysMin:"Di_Lu_Ma_Me_Je_Ve_Sa".split("_"),longDateFormat:{LT:"HH:mm",LTS:"HH:mm:ss",L:"DD/MM/YYYY",LL:"D MMMM YYYY",LLL:"D MMMM YYYY LT",LLLL:"dddd D MMMM YYYY LT"},calendar:{sameDay:"[Aujourd'hui à] LT",nextDay:"[Demain à] LT",nextWeek:"dddd [à] LT",lastDay:"[Hier à] LT",lastWeek:"dddd [dernier à] LT",sameElse:"L"},relativeTime:{future:"dans %s",past:"il y a %s",s:"quelques secondes",m:"une minute",mm:"%d minutes",h:"une heure",hh:"%d heures",d:"un jour",dd:"%d jours",M:"un mois",MM:"%d mois",y:"une année",yy:"%d années"},ordinalParse:/\d{1,2}(er|ème)/,ordinal:function(t){var e;return e=1===t?"er":"ème",t+e},meridiemParse:/PD|MD/,isPM:function(t){return"M"===t.charAt(0)},meridiem:function(t,e,n){return t<12?"PD":"MD"},week:{dow:1,doy:4}}),sod_locale.fr={incidents:{label:"Incidentes"},casualties:{label:"Victimes"}};var LocaleUI;LocaleUI=function(){function t(t,r){e=r,n(t)}var e,n;return e=null,n=function(t){return moment.locale(t)},$(".lang").on("click",function(t){var r;return r=moment.locale(),n(t.target.text),$(".language .selected .lang-to-use").text(moment.locale()),$(this).text(r),$(".language .lang-options").toggleClass("visible"),e.shouldTranslate(r)}),$(".language .selected").on("click",function(){return $(".language .lang-options").toggleClass("visible")}),t}();var Utils;Utils=function(){function t(){}return t.prototype.height=window.innerHeight,t.prototype.width=window.innerWidth,t.prototype.timelineHeight=350,t.prototype.windowRatio=function(){return window.innerWidth/window.innerHeight},t.prototype.sizeStyles=function(t,e){return null==t&&(t=this.width),null==e&&(e=this.height),"auto"!==t&&(t+="px"),"auto"!==e&&(e+="px"),["width:"+t,"height:"+e].join(";")},t.prototype.monthIndex=function(t){return moment.months().indexOf(t)+1},t.prototype.getFormattedDate=function(t,e){var n;return"years"===e&&(n="Y"),"months"===e&&(n="MMMM"),"days"===e&&(n="Do"),moment(t).format(n)},t.prototype.printLog=function(t){},t}();var UrlManager;UrlManager=function(){function t(){}var e,n,r,i,a,o;return o=new Utils,i={years:null,months:null,days:null},r=function(t){switch(parseInt(t[1])){case 1:case 3:case 5:case 7:case 8:case 10:case 12:return 31;case 2:return _.endsWith(t[0],"00")&&parseInt(t[0])%400===0||parseInt(t[0])%4===0?28:29;default:return 30}},e=function(t){var e;return e=moment().year(parseInt(t[0])),t[1]&&""!==t[1]&&e.month(parseInt(t[1])-1),t[2]&&""!==t[2]&&e.date(parseInt(t[2])),e.format("Y MMMM Do").split(" ")},n=function(t){var e,n,i,a,o;return n=t.split("/"),e=[],null!==n[0].match(/^\d{4}/)&&1970<=(i=parseInt(n[0]))&&i<=2014?(e[0]=n[0],void 0!==n[1]&&null!==n[1].match(/^\d{1,2}$/)&&1<=(a=parseInt(n[1]))&&a<=12&&(1===n[1].length&&(n[1]="0"+n[1]),e[1]=n[1],void 0!==n[2]&&null!==n[2].match(/^\d{1,2}$/)&&1<=(o=parseInt(n[2]))&&o<=r(n)&&(1===n[2].length&&(n[2]="0"+n[2]),e[2]=n[2])),e):null},a=function(){return window.location.href="#/"+_.filter(i,function(t){return null!==t&&""!==t}).join("/")},t.prototype.loadTimelineOnDate=function(){var t,r,o,s;return r=location.hash.replace("#/",""),0===r.length?null:(t=n(r),i=_.zipObject(_.keys(i),t),a(),s=e(t),o=i,o.years=s[0],o.months&&""!==o.months&&(o.months=s[1]),o.days&&""!==o.days&&(o.days=s[2]),o)},t.prototype.goToDate=function(t,e){return e&&("months"===t&&(e=(moment().month(e.toLowerCase()).month()+1).toString()),1===e.length&&(e="0"+e)),i[t]=e,a()},t}();var EventsManager;EventsManager=function(){function t(t){v=t}var e,n,r,i,a,o,s,l,u,c,d,p,h,f,g,m,x,y,v,D;return l=/(st|nd|rd|th|er|ème)/,c=[],i="years",a=["years","months","days"],y={},h={years:null,months:"January",days:"01"},o=[],v=null,D=new Utils,d=d3.time.format("%Y-%m-%d").parse,x=function(t,e){var n,r,i;return n=e.shift(),i=D.monthIndex(n),i>0&&(n=i),n.length>0&&null!==(r=n.match(/^\d{1,2}\D{2,3}$/))&&(n=parseInt(n.replace(/\D{2,3}$/,""))),void 0!==t[n]?0===e.length?t[n]:x(t[n],e):null},e=function(){var t,e;return e=_.values(h),e[2]=n(e[2]),t=e.slice(0,a.indexOf(i)+1),x(y,t)},m=function(t,e){return e&&1===e.length&&(e="0"+e),h[t]=e},f=function(t){var e;return t=t.trim(),e=$(".graph-slot p.selected-date span").text().trim(),""!==e&&(o=e.split(" ")),null!==t.match(/^\d{4}$/)?o[0]=t:null!==t.match(/^\D+$/)?o[1]=t:null!==t.match(/^\d{1,2}\D{2,3}$/)?o[2]=t:void 0},g=function(t){var e;if("days"!==i)return e=a.indexOf(t),i=a[e+1]},p=function(){return m("years",null),m("months","January"),m("days","01")},r=function(t){return null!==t.match(l)&&"days"===i&&(t=t.replace(l,"")),t},n=function(t){var e;return e=parseInt(t),moment.localeData().ordinal(e)},s=function(t){var e,n;return e=[],t.length>0&&(t[0]&&e.push(o[0]),t[1]&&(n=t[1],n&&(n=D.monthIndex(n).toString(),1===n.length&&(n="0"+n),e.push(n)))),e},u=function(t){var e;return!_.isEmpty(y)&&(1===t.length?void 0!==y[t[0]][1]:2!==t.length||(e=D.monthIndex(t[1]),void 0!==y[t[0]][e]["1st"]))},t.prototype.getDateTextFragments=function(){return o},t.prototype.addListener=function(t){if(c.indexOf(t)===-1)return c.push(t)},t.prototype.shouldHighlight=function(t){var n,a,o,s,l,u,d;for(n=_.map(t,function(t){return t.replace("time-","")}),o=r(n[0]),m(i,o),a=e(),d=[],s=0,l=c.length;s<l;s++)u=c[s],d.push(u.highlight(n,a));return d},t.prototype.shouldUnhighlight=function(t){var n,a,o,s,l,u,d;for(n=_.map(t,function(t){return t.replace("time-","")}),o=r(n[0]),m(i,o),a=e(),d=[],s=0,l=c.length;s<l;s++)u=c[s],d.push(u.unhighlight(n,a));return d},t.prototype.shouldFixDate=function(t,n,s,l){var u,d,x,y,D,w,L,M,$,S,C,b;if(null==s&&(s=null),null==l&&(l=!0),x=o.indexOf(t),x>-1){for(D=[],i=a[x],y=w=b=x;b<=2?w<=2:w>=2;y=b<=2?++w:--w)o[y]=null,0===y&&p(),y<2&&D.push(a[y+1]),v.goToDate(_.keys(h)[y],null);for(L=0,$=c.length;L<$;L++)C=c[L],C.unfixHighlight(n),C.remove(D)}else{if(d=r(t),m(n,d),u=e(),!u)return;for(f(t),M=0,S=c.length;M<S;M++)C=c[M],C.unhighlight(t,u),C.fixHighlight(n,u);l===!0&&v.goToDate(n,d),g(n)}return this.shouldExploreDate(s)},t.prototype.shouldExploreDate=function(t){return this.getData(function(){var t,e,n,r;for(r=[],t=0,e=c.length;t<e;t++)n=c[t],r.push(n.exploreDate());return r},t)},t.prototype.shouldRender=function(){var t;return t=v.loadTimelineOnDate(),this.getData(function(){var t,e,n,r;for(r=[],t=0,e=c.length;t<e;t++)n=c[t],r.push(n.render());return r},t)},t.prototype.shouldRedraw=function(){var t,e,n,r;for(r=[],t=0,e=c.length;t<e;t++)n=c[t],r.push(n.redraw());return r},t.prototype.shouldTranslate=function(t){var e,n,r,i,a,o;for(a=moment(_.values(h).join("-"),"YYYY-MMMM-DD",t),i=moment.months()[a.month()],f(i),m("months",i),o=[],e=0,n=c.length;e<n;e++)r=c[e],o.push(r.translate());return o},t.prototype.shouldUnhighlightBasedOnCountry=function(t){var e,n,r,s,l,u,d,p,h;for(n=t[1],l=o.slice(0,a.indexOf(i)),s=_.filter(o,function(t){return null!=t}),e=x(y,s),r=_.find(e.countries,function(t){return t.country===n}),h=[],u=0,d=c.length;u<d;u++)p=c[u],h.push(p.unhighlightByCountry(i,r));return h},t.prototype.shouldHighlightBasedOnCountry=function(t){var e,n,r,s,l,u,d,p,h,f,g,m;for(n=t[1],u=o.slice(0,a.indexOf(i)),l=_.filter(o,function(t){return null!=t}),e=x(y,l),s=_.find(e.countries,function(t){return t.country===n}),d=0,h=t.length;d<h;d++)r=t[d],u.unshift(r);for(m=[],p=0,f=c.length;p<f;p++)g=c[p],m.push(g.highlightByCountry(u,s));return m},t.prototype.getDataSet=function(){var t,e,n;return null===h.years?_.values(y):(e=_.values(h).slice(0,a.indexOf(i)),n=x(y,e),t=_.pickBy(n,function(t,e){var n;return n=["date","casualties","incidents","countries"],_.indexOf(n,e)===-1}),_.values(t))},t.prototype.getDateState=function(){return i},t.prototype.getData=function(t,e){var n,a;if(n=_.filter(o,function(t){return null!==t}),3===n.length){if(t(),e&&!o[2]&&e[i])return this.shouldFixDate(e[i],i,e,!1)}else{if(!u(n))return a=s(n),d3.json(cors_origin+"/"+a.join("/"),function(n){return function(s,l){return s?printError(s):(l.forEach(function(t){var e,n;if(t.date=d(t.date),e=D.getFormattedDate(t.date,i),"years"===i&&(y[e]=t),"months"===i&&(n=D.monthIndex(e),y[a[0]][n]=t),"days"===i&&(n=D.monthIndex(o[1]),"days"===i))return y[a[0]][n][r(e)]=t}),t(),e&&!o[2]&&e[i]?n.shouldFixDate(e[i],i,e,!1):void 0)}}(this));if(t(),e&&!o[2]&&e[i])return this.shouldFixDate(e[i],i,e,!1)}},t}();var Transitions;Transitions=function(){function t(t){l=t,r(),p(l.getDateState())}var e,n,r,i,a,o,s,l,u,c,d,p,h,f;return f=new Utils,l=null,c=0,a=["years","months","days"],i=null,n=function(){var t,e,n;return n=parseInt($(".dates-container").css("height").replace("px","")),e=n-c,c=n,t=parseInt($(".graph-slot").css("bottom").replace("px","")),$(".graph-slot").css("bottom",t+e+"px")},e=function(){var t;if(t=parseInt($(".dates-container").css("height").replace("px","")),t>=10)return $(".graph-slot").css("bottom",t+"px")},d=function(){var t;return t=parseInt($(".dates-container").css("height").replace("px","")),$(".graph-slot").css("bottom",t+"px")},u=function(){var t;if("days"!==i)return t=a.indexOf(i),a[t+1]},r=function(){return $(".timeaxis").perfectScrollbar({theme:"sod",suppressScrollY:!0}),$(".timeline-container").perfectScrollbar({suppressScrollY:!0})},p=function(t){return i=t,$(".timeaxis."+i).on("ps-scroll-x",function(){return $(".timeline-container").scrollLeft($(this).scrollLeft())}),$(".timeline-container").on("ps-scroll-x",function(){return $(".timeaxis."+i).scrollLeft($(this).scrollLeft())})},h=function(){return $(".timeaxis."+i).off("ps-scroll-x"),$(".timeline-container").off("ps-scroll-x")},s=function(t,e){var n,r;return r=$(".xaxis .time-"+t[0]).parent().position().left,$(".statistics").css("left",r+"px"),n=parseInt($(".xaxis .time-"+t[0]).parents(".timeaxis").css("height").replace("px","")),$(".statistics").css("bottom",n+25+"px"),$(".statistics").addClass("visible"),$(".statistics ul li.incidents span.definition").text(e.incidents),$(".statistics ul li.casualties span.definition").text(e.casualties)},o=function(t,e){var n,r,a,o,s,l,u,c,d,p,h;if(e)for(_.includes(t,"dot")||t.push("dot","casualties"),c=$(".timeaxis."+i+" .ps-scrollbar-x-rail").attr("style"),c&&(n=parseInt(c.split("; ")[0].split(": ")[1].replace("px",""))),p=parseInt($(".time-"+t.join(".")).attr("cx"))+15-n,isNaN(p)&&(p=0),r={firstClasses:_.join(t,"."),secondClasses:_.join(t,"."),firstStat:"casualties",secondStat:"incidents"},_.includes(t,"incidents")&&(r.firstStat="incidents",r.secondStat="casualties"),r.secondClasses=_.replace(r.firstClasses,r.firstStat,r.secondStat),u=["first","second"],o=0,s=u.length;o<s;o++){if(l=u[o],a=$(".time-"+r[l+"Classes"]),0===a.length)return;h=$(".time-"+r[l+"Classes"]).position().top-60,d=r[l+"Stat"],$(".stats-"+d).css("top",h+"px"),$(".stats-"+d).css("left",p+"px"),$(".stats-"+d).addClass("visible"),$(".stats-"+d+" ul li."+d+" span.definition").text(e[d])}},t.prototype.highlight=function(t,e){return e||(e={incidents:0,casualties:0}),$(".timeline-container").hasClass("collapsed")?o(t,e):s(t,e)},t.prototype.unhighlight=function(t){return $(".statistics").removeClass("visible"),$(".statistics ul li.incidents span.definition").text("Loading..."),$(".statistics ul li.casualties span.definition").text("Loading..."),$(".stats-incidents").removeClass("visible"),$(".stats-casualties").removeClass("visible")},t.prototype.unfixHighlight=function(t){return $(".graph-slot p.selected-date span").text(l.getDateTextFragments().join(" ")),""===$(".graph-slot p.selected-date span").text().trim()&&$(".graph-slot p.selected-date").removeClass("visible"),h(),p(l.getDateState())},t.prototype.fixHighlight=function(t){return $(".graph-slot p.selected-date span").text(l.getDateTextFragments().join(" ")),$(".graph-slot p.selected-date").addClass("visible"),h(),p(u())},t.prototype.exploreDate=function(){return this.render(),d()},t.prototype.render=function(){return $(".xaxis-container ."+l.getDateState()).addClass("visible")},t.prototype.remove=function(t){var e,n,r;for(n=0,r=t.length;n<r;n++)e=t[n],$(".xaxis-container ."+e).removeClass("visible");return d()},t.prototype.redraw=function(){return f.printLog('{"listener.redraw()": "transitions function not implemented"}')},t.prototype.translate=function(){var t;return t=moment.locale(),$(".graph-slot p.selected-date span").text(l.getDateTextFragments().join(" ")),$(".legend .for-incidents").text(sod_locale[t].incidents.label),$(".legend .for-casualties").text(sod_locale[t].casualties.label)},$(".graph-slot .toggle-timeline").click(function(){return $(this).children("p").children("i").toggleClass("fa-chevron-down"),$(this).children("p").children("i").toggleClass("fa-chevron-up"),$(".dates-container .xaxis-container").hasClass("collapsed")?($(".dates-container .xaxis-container").removeClass("collapsed"),$(".dates-container .xaxis-container").slideDown({duration:"slow",progress:function(t,n,r){return e(),l.shouldRedraw()}})):($(".dates-container .xaxis-container").addClass("collapsed"),$(".dates-container .xaxis-container").slideUp({duration:"slow",progress:function(t,n,r){return e(),l.shouldRedraw()}}))}),$(".breadcrumb-back").click(function(){var t,e,n;return t=["years","months","days"],n=$(".graph-slot p.selected-date span").text().trim().split(" "),e=n.length-1,l.shouldFixDate(n[e],t[e])}),$(".graph-slot .slot").click(function(){return c=parseInt($(".dates-container").css("height").replace("px","")),$(".timeline-container").hasClass("collapsed")?($(".timeline-container").removeClass("collapsed"),$(".timeline-container").slideUp({duration:"slow",progress:function(t,e,r){return n()}})):($(".timeline-container").addClass("collapsed"),$(".timeline-container").slideDown({duration:"slow",progress:function(t,e,r){return n()}}))}),$(window).resize(function(){return l.shouldRedraw()}),t}();var Map;Map=function(){function t(t){r=t,s()}var e,n,r,i,a,o,s,l,u,c,d;return d=new Utils,r=null,u=null,n=["years","months","days"],c=function(){return $(".dates-container .xaxis-container").height()},s=function(){return u=d3.select("body .map-container.fixed").append("div").attr("class","world-map-container").append("svg").attr("class","world-map").attr("viewBox","0 0 1000 730").attr("width","100%").attr("height",d.height+"px").call(d3.behavior.zoom().on("zoom",function(){return u.attr("transform","translate("+d3.event.translate+")scale("+d3.event.scale+")")})).append("g").attr("style","max-height: "+(d.height-c())+"px;")},a=d3.geo.mercator().translate([500,500]),i=d3.geo.path().projection(a),l=function(t){var e,i,a,o;if(i=d3.event.target.classList,_.indexOf(i,"years")!==-1&&(e=_.last(i),a=r.getDateState(),o=n.indexOf(a)-1,e===n[o]||e===a&&"days"===a))return t(i)},o=function(t){return e(),u.selectAll(".country").data(t.features).enter().append("path").attr("class",function(t){return"country "+t.id}).attr("d",i)},e=function(){return d3.select(".world-map-container").attr("style","padding-bottom: "+d.height+"px;")},t.prototype.highlight=function(t,e){var n,r,i,a,o;if(e){for(a=e.countries,o=[],r=0,i=a.length;r<i;r++)n=a[r],o.push(d3.select(".country."+n.country).classed("highlight",!0));return o}},t.prototype.unhighlight=function(t,e){var n,r,i,a,o;if(e){for(a=e.countries,o=[],r=0,i=a.length;r<i;r++)n=a[r],o.push(d3.select(".country."+n.country).classed("highlight",!1));return o}},t.prototype.unfixHighlight=function(t){var e,i,a,o,s;if("days"!==r.getDateState()){for(e=n.indexOf(t),s=[],i=a=o=e;o<=2?a<=2:a>=2;i=o<=2?++a:--a)s.push(u.selectAll(".country."+n[i]).classed(n[i],!1));return s}},t.prototype.fixHighlight=function(t,e){var n,i,a,o,s;if("days"!==r.getDateState()){for(o=e.countries,s=[],i=0,a=o.length;i<a;i++)n=o[i],s.push(u.select(".country."+n.country).classed(t,!0));return s}},t.prototype.exploreDate=function(){return u.attr("style","max-height: "+(d.height-c())+"px;")},t.prototype.render=function(t){return d.printLog('{"listener.render()": "map function not implemented"}')},t.prototype.draw=function(t){return d3.json("map.json",function(e,n){var r;return e?d.printLog(e):(r=topojson.feature(n,n.objects.world_map),o(r),t())})},t.prototype.remove=function(t){return d.printLog('{"listener.remove()": "map function not implemented"}')},t.prototype.redraw=function(){return e(),u.attr("style","max-height: "+(d.height-c())+"px;")},t.prototype.translate=function(){return d.printLog('{"listener.translate()": "map function not implemented"}')},t}();var Axis;Axis=function(){function t(){}var e,n,r;return r=new Utils,n=null,e=function(t,e){return t===e},t.prototype.setSvg=function(t){return n=d3.select("body .dates-container .xaxis-container ."+t.axisClass).append("svg").attr("class","xaxis").attr("width",t.width).attr("height",t.height).append("g")},t.prototype.getSvg=function(){return n},t.prototype.setScale=function(t){return d3.time.scale().range([0,t.width-100])},t.prototype.setAxis=function(t){return d3.svg.axis().scale(t).tickSize(0).tickPadding(5).orient("bottom")},t.prototype.configureAxisAndScale=function(t,e,n,i){return t.domain(d3.extent(n,function(t){return t.date})),e.ticks(d3.time[i]),e.tickFormat(function(t){return r.getFormattedDate(t,i)})},t.prototype.renderAxis=function(t,n,i,a){var o,s,l,u,c;for(u=t.append("g").attr("class","x axis").attr("transform","translate("+i.x0+", 0)").on("click",function(){var t,e,n;if(t=d3.event.target.classList,n=d3.event.target.parentElement.parentElement.parentElement.parentElement.parentElement.classList.value,!_.includes(t,"fix-unhighlight")&&!_.includes(n,"days"))return e=t[0].replace("time-",""),a.shouldFixDate(e,i.axisClass)}).on("mouseover",function(){var t;if(e(i.axisClass,a.getDateState()))return t=d3.event.target.classList,a.shouldHighlight(t)}).on("mouseout",function(){var t;if(e(i.axisClass,a.getDateState()))return t=d3.event.target.classList,a.shouldUnhighlight(t)}).call(n),s=d3.selectAll(".xaxis-container .timeaxis."+i.axisClass+" .x.axis .tick text")[0],o=0,l=s.length;o<l;o++)c=s[o],d3.select(c).attr("class",function(t){return"time-"+r.getFormattedDate(t,a.getDateState())});return u},t.prototype.toggleHighlight=function(t,e,n){return t.selectAll(".time-"+e).classed("highlight",n)},t.prototype.unfixHighlight=function(t,e){return t.selectAll(".tick text").classed("fix-unhighlight",!1),t.selectAll(".tick text").classed("fix-highlight",!1)},t.prototype.fixHighlight=function(t,e,n){var r;if(r=t.select(".tick text.fix-highlight.time-"+n),this.unfixHighlight(t,e),r.empty())return t.selectAll(".tick text").classed("fix-unhighlight",!0),t.select(".tick text.time-"+n).classed("fix-unhighlight",!1).classed("fix-highlight",!0)},t.prototype.translateAxis=function(t){var e,n,i,a,o;for(n=d3.selectAll(".xaxis-container .timeaxis."+t+" .x.axis .tick text")[0],a=[],e=0,i=n.length;e<i;e++)o=n[e],a.push(d3.select(o).attr("class",function(e){var n;return n=r.getFormattedDate(e,t),this.textContent=n,this.classList.value.replace(/time-\w*/g,"time-"+n)}));return a},t}();var Years;Years=function(){function t(t,r){n=r,i=t,s=e.setSvg(n)}var e,n,r,i,a,o,s,l,u;return e=new Axis,u=null,r=null,o=null,n=null,i=null,s=null,l=new Utils,a=function(){return i.getDateState()===n.axisClass},t.prototype.getScale=function(){return u},t.prototype.highlight=function(t){if(a())return e.toggleHighlight(s,t,!0)},t.prototype.unhighlight=function(t){if(a())return e.toggleHighlight(s,t,!1)},t.prototype.unfixHighlight=function(t){if(t===n.axisClass)return e.unfixHighlight(s,t)},t.prototype.fixHighlight=function(t){var r;if(t===n.axisClass)return r=i.getDateTextFragments()[0],e.fixHighlight(s,t,r)},t.prototype.exploreDate=function(){return l.printLog('{"listener.exploreDate()": "years function not implemented"}')},t.prototype.render=function(){if(a())return u=e.setScale(n),r=e.setAxis(u),e.configureAxisAndScale(u,r,i.getDataSet(),i.getDateState()),o=e.renderAxis(s,r,n,i)},t.prototype.remove=function(t){return l.printLog('{"listener.remove()": "years function not implemented"}')},t.prototype.redraw=function(){return l.printLog('{"listener.redraw()": "years function not implemented"}')},t.prototype.translate=function(){return l.printLog('{"listener.translate()": "years function not implemented"}')},t}();var Months;Months=function(){function t(t,r){n=r,i=t,s=e.setSvg(n)}var e,n,r,i,a,o,s,l,u;return e=new Axis,u=null,r=null,o=null,n=null,i=null,s=null,l=new Utils,a=function(){return i.getDateState()===n.axisClass},t.prototype.getScale=function(){return u},t.prototype.highlight=function(t){if(a())return e.toggleHighlight(s,t,!0)},t.prototype.unhighlight=function(t){if(a())return e.toggleHighlight(s,t,!1)},t.prototype.unfixHighlight=function(t){if(t===n.axisClass)return e.unfixHighlight(s,t)},t.prototype.fixHighlight=function(t){var r;if(t===n.axisClass)return r=i.getDateTextFragments()[1],e.fixHighlight(s,t,r)},t.prototype.exploreDate=function(){if(!o)return this.render()},t.prototype.render=function(){if(a())return u=e.setScale(n),r=e.setAxis(u),e.configureAxisAndScale(u,r,i.getDataSet(),i.getDateState()),o=e.renderAxis(s,r,n,i)},t.prototype.remove=function(t){if(t.indexOf(n.axisClass)!==-1)return o?(o.remove(),o=null):void 0},t.prototype.redraw=function(){return l.printLog('{"listener.redraw()": "months function not implemented"}')},t.prototype.translate=function(){return e.translateAxis("months")},t}();var Days;Days=function(){function t(t,r){n=r,i=t,s=e.setSvg(n)}var e,n,r,i,a,o,s,l,u;return e=new Axis,u=null,r=null,o=null,n=null,i=null,s=null,l=new Utils,a=function(){return i.getDateState()===n.axisClass},t.prototype.getScale=function(){return u},t.prototype.highlight=function(t){if(a())return e.toggleHighlight(s,t,!0)},t.prototype.unhighlight=function(t){if(a())return e.toggleHighlight(s,t,!1)},t.prototype.unfixHighlight=function(t){return l.printLog('{"listener.redraw()": "days function not implemented"}')},t.prototype.fixHighlight=function(t){return l.printLog('{"listener.redraw()": "days function not implemented"}')},t.prototype.exploreDate=function(){if(!o)return this.render()},t.prototype.render=function(){if(a())return u=e.setScale(n),r=e.setAxis(u),e.configureAxisAndScale(u,r,i.getDataSet(),i.getDateState()),o=e.renderAxis(s,r,n,i)},t.prototype.remove=function(t){if(t.indexOf(n.axisClass)!==-1)return o?(o.remove(),o=null):void 0},t.prototype.redraw=function(){return l.printLog('{"listener.redraw()": "days function not implemented"}')},t.prototype.translate=function(){return e.translateAxis("days")},t}();var Dots;Dots=function(){function t(t,e,n){var r,i;o=e,u=n,p=t,i=o.height/2,r=o.height,f=d3.scale.linear().range([r-20,i+20]),g=d3.scale.linear().range([i-20,50])}var e,n,r,i,a,o,s,l,u,c,d,p,h,f,g;return h=new Utils,a=null,i=null,d=null,c=null,g=null,f=null,p=null,u=null,o={height:0,xHeight:0,x0:0},r=function(){return g.domain([0,d3.max(u.getDataSet(),function(t){return t.incidents})]),f.domain([0,d3.max(u.getDataSet(),function(t){return t.casualties})])},n=function(t){return d3.svg.axis().scale(t).orient("left").tickSize(2).ticks(5).tickFormat(function(t){switch(!1){case!(t>99):return(t/1e3).toString().replace(/^0\./,".")+"K";case!(t>99e3):return(t/1e6).toString().replace(/^0\./,".")+"M";default:return t}})},l=function(t,e,n){return p.getSvg().append("path").datum(u.getDataSet()).attr("class","line-chart "+e).attr("d",t).attr("transform","translate("+o.x0+", 0)"),p.getSvg().append("g").attr("class","yaxis").attr("transform","translate(40, 0)").call(n)},s=function(t,e,n,r,i){return t.append("circle").attr("class",function(t){var e;return e=h.getFormattedDate(t.date,u.getDateState()),"time-"+e+" dot "+n}).attr("r",r).attr("cx",function(t){return e(t.date)}).attr("cy",function(t){return i(t)}).attr("transform","translate("+o.x0+", 0)").on("click",function(t){var e;return e=d3.event.target.classList[0].replace("time-",""),u.shouldFixDate(e,u.getDateState())}).on("mouseover",function(t){var e;return e=d3.event.target.classList,u.shouldHighlight(e)}).on("mouseout",function(t){var e;return e=d3.event.target.classList,u.shouldUnhighlight(e)})},e=function(t,e,n){return d3.svg.line().x(function(e){return t(e.date)}).y(function(t){return e(t[n])})},t.prototype.remove=function(){return a&&a.remove(),i&&i.remove(),d&&d.remove(),c&&c.remove(),p.getSvg().selectAll("path").remove()},t.prototype.draw=function(t,o){var u,p,h;return r(),u=6,p=n(f),h=n(g),c=l(e(o,f,"casualties"),"casualties",p),i=s(t,o,"casualties",u,function(t){return f(t.casualties)}),d=l(e(o,g,"incidents"),"incidents",h),a=s(t,o,"incidents",u,function(t){return g(t.incidents)})},t}();var Timeline;Timeline=function(){function t(t,n,a){var o;i=a,u=n,s(),o={height:u.height,xHeight:p,x0:u.x0},r=new Dots(this,o,i),e=t}var e,n,r,i,a,o,s,l,u,c,d,p,h;return d=new Utils,r=null,e=null,i=null,h=null,a=null,l=null,u={height:0,width:0,x0:0},p=50,s=function(){return l=d3.select("body .dates-container .timeline-container").attr("style",d.sizeStyles(u.width,"auto")).append("svg").attr("class","timeline").attr("width",u.width).attr("height",u.height).append("g")},c=function(t,e){var n;if(t)return n=d.getFormattedDate(t.date,i.getDateState()),l.selectAll(".time-"+n).classed("highlight",e)},n=function(){return h.domain(d3.extent(i.getDataSet(),function(t){return t.date}))},o=function(){var t;return r.remove(),h=e.getScale(),n(),t=l.selectAll("dot").data(i.getDataSet()).enter(),r.draw(t,h)},t.prototype.getSvg=function(){return l},t.prototype.highlight=function(t,e){return c(e,!0)},t.prototype.unhighlight=function(t,e){return c(e,!1)},t.prototype.unfixHighlight=function(t){return d.printLog('{"listener.fixHighlight(dataSet)": "timeline function not implemented"}')},t.prototype.fixHighlight=function(t){return d.printLog('{"listener.fixHighlight(dataSet)": "timeline function not implemented"}')},t.prototype.exploreDate=function(t){return o()},t.prototype.render=function(){return o()},t.prototype.remove=function(){return d.printLog('{"listener.remove()": "timeline function not implemented"}')},t.prototype.redraw=function(){return d.printLog('{"listener.redraw()": "timeline function not implemented"}')},t.prototype.translate=function(){return d.printLog('{"listener.translate()": "timeline function not implemented"}')},t}();var MainController,mainController;MainController=function(){function t(){r.addListener(a),r.addListener(h),r.addListener(o),r.addListener(e),r.addListener(c),r.addListener(l)}var e,n,r,i,a,o,s,l,u,c,d,p,h,f;return d=new UrlManager,r=new EventsManager(d),p=new Utils,c=new Transitions(r),a=new Map(r),f={width:3e3,height:50,x0:50,y0:0,axisClass:"years"},h=new Years(r,f),s={width:3e3,height:50,x0:50,y0:0,axisClass:"months"},o=new Months(r,s),n={width:3e3,height:50,x0:50,y0:0,axisClass:"days"},e=new Days(r,n),u={width:3e3,height:p.timelineHeight,x0:60},l=new Timeline(h,u,r),i=new LocaleUI("en",r),t.prototype.draw=function(){return a.draw(function(){return r.shouldRender()})},t}(),mainController=new MainController,mainController.draw();