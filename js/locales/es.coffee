moment.locale('es', {
  months: "Enero_Febrero_Marzo_Abril_Mayo_Junio_Julio_Agosto_Septiembre_Octubre_Noviembre_Diciembre".split("_"),
  monthsShort: "ene_feb_mars_abr_may_jun_jul_ago_sept_oct_nov_dic".split("_"),
  weekdays: "domingo_lunes_martes_miércoles_jueves_viernes_sábado".split("_"),
  weekdaysShort: "dom_lun_mar_mier_jue._vie._sab.".split("_"),
  weekdaysMin: "Do_Lu_Ma_Mi_Ju_Vi_Sa".split("_"),
  longDateFormat: {
    LT: "HH:mm",
    LTS: "HH:mm:ss",
    L: "DD/MM/YYYY",
    LL: "D MMMM YYYY",
    LLL: "D MMMM YYYY LT",
    LLLL: "dddd D MMMM YYYY LT"
  },
  calendar: {
    sameDay: "[Hoy es] LT",
    nextDay: '[Manana] LT',
    nextWeek: 'dddd [de] LT',
    lastDay: '[Ayer] LT',
    lastWeek: 'dddd [pasado] LT',
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
  ordinalParse: /\d{1,2}/,
  ordinal: (number) ->
    return number
  meridiemParse: /AM|PM/,
  isPM: (input) ->
    return input.charAt(0) == 'P'
  meridiem: (hours, minutes, isLower) ->
    if hours < 12
      return 'AM'
    else
      return 'PM'
  week: {
    dow: 1,
    doy: 4
  }
});

sod_locale['es'] = {
  incidents: {
    label: 'Incidentes'
  },
  casualties: {
    label: 'Víctimas'
  },
  loading: {
    label: 'cargando'
  }
}
