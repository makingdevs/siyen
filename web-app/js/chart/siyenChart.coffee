($ "select").change ->
  if ($ @).val()
    ($ @).parent().parent().next().show()
    ($ "form").trigger 'submit'
  else
    divs = ($ @).parent().parent().nextAll("div:has(div select)")
    divs.find('select').val(null)
    divs.hide()

($ "form").submit (e) ->
  e.preventDefault()

  $.ajax
    type: "POST"
    url: "realizarInforme"
    data: ($ "form").serialize()
    success: (response) ->
      labels = []
      data = []

      $.each response, (k,v) ->
        labels.push k
        data.push v

      datasets = []
      datasets.push ({
        fillColor : "rgba(151, 187, 205, 0.5)"
        strokeColor : "rgba(151, 187, 205, 1)"
        pointColor : "rgba(151, 187, 205, 1)"
        pointStrokeColor : "#fff"
        data : data
      })

      console.log datasets

      #valoresDelDatasets = {}

      #$.each data, (k, v) ->
      #  $.each v, (key, value) ->
      #    valoresDelDatasets[key] = [] unless valoresDelDatasets[key]
      #    valoresDelDatasets[key].push value

      #datasets = []
      #$.each valoresDelDatasets, (k, v) ->
      #  properties = {}
      #  [red, green, blue] = colorChooser(k)
      #  properties['fillColor'] = "rgba( #{red}, #{green}, #{blue}, 0.5)"
      #  properties['strokeColor'] = "rgba( #{red}, #{green}, #{blue}, 1)"
      #  properties['pointColor'] = "rgba( #{red}, #{green}, #{blue}, 1)"
      #  properties['pointStrokeColor'] = "#fff"
      #  properties['data'] = v
      #  datasets.push properties

      #$.each ($ "input:checked"), (k, v) ->
      #  [red, green, blue] = colorChooser(k)
      #  monthNumber = ($ v).val()
      #  month = moment(monthNumber).format('MMMM')
      #  elementIsRender = ($ "##{month}").size()
      #  ($ "#grafica").before(($ "<div id='#{month}' class='span2'> #{month} </div>")) unless elementIsRender
      #  ($ "##{month}").css 'background-color', "rgba( #{red}, #{green}, #{blue}, 0.5)"

      chartData =
        labels : labels
        datasets : datasets

      ctx = $("#grafica").get(0).getContext("2d")
      new Chart(ctx).Bar(chartData)

colorChooser = (value) ->
  switch parseInt(value)
    when 1 then [220, 220, 220]
    when 2 then [217, 112, 65]
    when 3 then [88, 74, 94]
    when 4 then [33, 50, 61]
    when 5 then [157, 155, 127]
    when 6 then [243, 134, 48]
    when 7 then [224, 228, 204]
    when 8 then [105, 210, 231]
    when 9 then [247, 70, 74]
    when 10 then [226, 234, 233]
    when 11 then [212, 204, 197]
    else [151, 187, 205]


$.each moment.months(), (k, v) ->
  element = "<label class='checkbox'> <input type='checkbox' name='meses' value='#{k + 1}'> #{v} </label> <br />"

  if k % 4 == 0
    div = $("<div class='span2'> </div>")
  else
    div = ($ "#months div:last-child")

  div.append element
  ($ "#months").append( div )

($ "#todos").click ->
  checkboxes = ($ ':checkbox')
  checked = true
  if ($ ':checkbox:checked').length
    checked = false
  checkboxes.attr 'checked', checked
  ($ "form").trigger 'submit'

($ ":checkbox").click ->
  ($ "form").trigger 'submit'
