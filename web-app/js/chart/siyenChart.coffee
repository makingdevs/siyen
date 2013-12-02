$(".busquedaChosen").chosen
  disable_search: true
  search_contains : true
  display_selected_options : false
  placeholder_text_single : "Selecciona una opción"
  no_results_text: "Oops, ¡No hubo resultados!"

($ ".datepicker").attr('readonly', 'true')
($ ".datepicker").val(moment().format('DD/MMMM/YYYY'))


($ "form").submit (e) ->
  e.preventDefault()

  data =
    "desde" : ($ "#desde").val(),
    "hasta" : ($ "#hasta").val()

  $.ajax
    type: "POST"
    url: "realizarInforme"
    data: data
    success: (response) ->
      labels = []
      data = []

      $.each response, (k,v) ->
        labels.push k
        data.push v

      chartData =
        labels : labels,
        datasets : [
          {
            fillColor : "rgba(151,187,205,0.5)"
            strokeColor : "rgba(151,187,205,1)"
            pointColor : "rgba(151,187,205,1)"
            pointStrokeColor : "#fff"
            data : data
          }
        ]

      ctx = $("#myChart").get(0).getContext("2d")
      new Chart(ctx).Bar(chartData)
