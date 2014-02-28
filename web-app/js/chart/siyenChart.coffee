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
      scaleStepWidth = 0
      datasets = []

      hasMonthsSelected = ($ ".checkbox :checked").size() > 1
      ($ "#acotaciones").html(" ")

      unless hasMonthsSelected
        $.each response, (k,v) ->
          labels.push k
          data.push v

        scaleStepWidth = calculateScaleStepWidth(data)
        properties =
          fillColor : "rgba(151, 187, 205, 0.5)"
          strokeColor : "rgba(151, 187, 205, 1)"
          pointColor : "rgba(151, 187, 205, 1)"
          pointStrokeColor : "#fff"
          data : data
        datasets.push properties
      else
        valoresDelDatasets = {}
        $.each response, (k, v) ->
          $.each v, (key, value) ->
            labels.push key unless key in labels
            valoresDelDatasets[k] = [] unless valoresDelDatasets[k]
            valoresDelDatasets[k].push value

        completeData = []
        flattenData = []
        $.each valoresDelDatasets, (k, v) ->
          properties = {}
          [red, green, blue] = colorChooser(k)
          properties['fillColor'] = "rgba( #{red}, #{green}, #{blue}, 0.5)"
          properties['strokeColor'] = "rgba( #{red}, #{green}, #{blue}, 1)"
          properties['pointColor'] = "rgba( #{red}, #{green}, #{blue}, 1)"
          properties['pointStrokeColor'] = "#fff"
          properties['data'] = v
          completeData.push( v )
          datasets.push properties

        flattenData = flattenData.concat.apply(flattenData, completeData)
        scaleStepWidth = calculateScaleStepWidth(flattenData)

        $.each ($ ".checkbox :checked"), (k, v) ->
          monthNumber = ($ v).val()
          [red, green, blue] = colorChooser(monthNumber)
          month = moment(monthNumber).format('MMMM')
          elementIsRender = ($ "##{month}").size()
          ($ "#acotaciones").append(($ "<div id='#{month}' class='span2'> #{month} </div>")) unless elementIsRender
          ($ "##{month}").css 'background-color', "rgba( #{red}, #{green}, #{blue}, 0.5)"

      chartData =
        labels : labels
        datasets : datasets

      options =
        scaleOverride : true
        scaleSteps : 10
        scaleStepWidth : scaleStepWidth
        scaleStartValue : 0

      ctx = $("#grafica").get(0).getContext("2d")
      new Chart(ctx).Bar(chartData, options)

calculateScaleStepWidth = (array, number) ->
  maxValue = Math.max.apply(Math, array)
  if(maxValue < 100)
    return (Math.ceil(maxValue / 10) * 10) / 10

  (Math.ceil(maxValue / 100) * 100) / 10


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
  element = "<label class='checkbox'> <input type='checkbox' name='mes' value='#{k + 1}'> #{v} </label> <br />"

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

($ ":radio").click ->
  ($ "form").trigger 'submit'

($ ":checkbox").click ->
  ($ "form").trigger 'submit'
