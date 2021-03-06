moment.locale('fr', {
  months: "Janvier_Février_Mars_Avril_Mai_Juin_Juillet_Août_Septembre_Octobre_Novembre_Décembre".split("_"),
  monthsShort: "janv._févr._mars_avr._mai_juin_juil._août_sept._oct._nov._déc.".split("_"),
  weekdays: "dimanche_lundi_mardi_mercredi_jeudi_vendredi_samedi".split("_"),
  weekdaysShort: "dim._lun._mar._mer._jeu._ven._sam.".split("_"),
  weekdaysMin: "Di_Lu_Ma_Me_Je_Ve_Sa".split("_"),
  longDateFormat: {
    LT: "HH:mm",
    LTS: "HH:mm:ss",
    L: "DD/MM/YYYY",
    LL: "D MMMM YYYY",
    LLL: "D MMMM YYYY LT",
    LLLL: "dddd D MMMM YYYY LT"
  },
  calendar: {
    sameDay: "[Aujourd'hui à] LT",
    nextDay: '[Demain à] LT',
    nextWeek: 'dddd [à] LT',
    lastDay: '[Hier à] LT',
    lastWeek: 'dddd [dernier à] LT',
    sameElse: 'L'
  },
  relativeTime: {
    future: "dans %s",
    past: "il y a %s",
    s: "quelques secondes",
    m: "une minute",
    mm: "%d minutes",
    h: "une heure",
    hh: "%d heures",
    d: "un jour",
    dd: "%d jours",
    M: "un mois",
    MM: "%d mois",
    y: "une année",
    yy: "%d années"
  },
  ordinalParse: /\d{1,2}(er|ème)/,
  ordinal: (number) ->
    if number == 1
      endWith = 'er'
    else
      endWith = 'ème'
    return number + endWith
  meridiemParse: /PD|MD/,
  isPM: (input) ->
    return input.charAt(0) == 'M'
  meridiem: (hours, minutes, isLower) ->
    if hours < 12
      return 'PD'
    else
      return 'MD'
  week: {
    dow: 1,
    doy: 4
  }
});

sod_locale['fr'] = {
  incidents: {
    label: 'Incidentes'
  },
  casualties: {
    label: 'Victimes'
  },
  loading: {
    label: 'chargement'
  },
  menu: {
    info: 'info'
  },
  info: {
    title: "Symphonie de Mort",
    headline: "Ce n'est pas seulement le groupe de personnes ou la ville 
          ou le bloc qui ont été attaqués qui souffrent, cela laisse une 
          cicatrice parmi tous et si nous ne faisons pas attention à ces 
          petits endroits où les médias ne rapportent pas, alors ces 
          sentiments vont commencer à se répandre Plus vite que les 
          médias peuvent attraper et il sera pire.",
    related: "Il s'agit d'une chronologie liée aux attentats terroristes 
          depuis 1970. Les données utilisées pour afficher l'information 
          proviennent du projet 
          <a href='https://www.start.umd.edu'>START's</a> 
          <a href='https://www.start.umd.edu/gtd/'>Global Database Terrorism</a>",
    footnote: "Si vous voulez signaler un bogue ou suggérer une idée, ou un RP, 
          <a href='https://github.com/diablourbano/sod'>c'est le repo</a>."
  }
}
