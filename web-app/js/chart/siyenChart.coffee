($ '.datepicker').datepicker
  format          : "dd/MM/yyyy"
  autoclose       : true
  todayHighlight  : true
  language        : 'es'
  startDate       : '1d'

($ ".datepicker").attr('readonly', 'true')
($ ".datepicker").val(moment().format('DD/MMMM/YYYY'))