//=require chosen/chosen.jquery.js
//=require chart/Chart.js
//=require datepicker/bootstrap-datepicker.js
//=require datepicker/locales/bootstrap-datepicker.es.js
//=require momentjs/moment.js
//=require momentjs/lang/es.js

(function() {
  var calculateScaleStepWidth, colorChooser,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  ($("select")).change(function() {
    var divs;
    if (($(this)).val()) {
      ($(this)).parent().parent().next().show();
      return ($("form")).trigger('submit');
    } else {
      divs = ($(this)).parent().parent().nextAll("div:has(div select)");
      divs.find('select').val(null);
      return divs.hide();
    }
  });

  ($("form")).submit(function(e) {
    e.preventDefault();
    return $.ajax({
      type: "POST",
      url: "realizarInforme",
      data: ($("form")).serialize(),
      success: function(response) {
        var chartData, completeData, ctx, data, datasets, flattenData, hasMonthsSelected, labels, options, properties, scaleStepWidth, valoresDelDatasets;
        labels = [];
        data = [];
        scaleStepWidth = 0;
        datasets = [];
        hasMonthsSelected = ($(".checkbox :checked")).size() > 1;
        ($("#acotaciones")).html(" ");
        if (!hasMonthsSelected) {
          $.each(response, function(k, v) {
            labels.push(k);
            return data.push(v);
          });
          scaleStepWidth = calculateScaleStepWidth(data);
          properties = {
            fillColor: "rgba(151, 187, 205, 0.5)",
            strokeColor: "rgba(151, 187, 205, 1)",
            pointColor: "rgba(151, 187, 205, 1)",
            pointStrokeColor: "#fff",
            data: data
          };
          datasets.push(properties);
        } else {
          valoresDelDatasets = {};
          $.each(response, function(k, v) {
            return $.each(v, function(key, value) {
              if (__indexOf.call(labels, key) < 0) {
                labels.push(key);
              }
              if (!valoresDelDatasets[k]) {
                valoresDelDatasets[k] = [];
              }
              return valoresDelDatasets[k].push(value);
            });
          });
          completeData = [];
          flattenData = [];
          $.each(valoresDelDatasets, function(k, v) {
            var blue, green, red, _ref;
            properties = {};
            _ref = colorChooser(k), red = _ref[0], green = _ref[1], blue = _ref[2];
            properties['fillColor'] = "rgba( " + red + ", " + green + ", " + blue + ", 0.5)";
            properties['strokeColor'] = "rgba( " + red + ", " + green + ", " + blue + ", 1)";
            properties['pointColor'] = "rgba( " + red + ", " + green + ", " + blue + ", 1)";
            properties['pointStrokeColor'] = "#fff";
            properties['data'] = v;
            completeData.push(v);
            return datasets.push(properties);
          });
          flattenData = flattenData.concat.apply(flattenData, completeData);
          scaleStepWidth = calculateScaleStepWidth(flattenData);
          $.each($(".checkbox :checked"), function(k, v) {
            var blue, elementIsRender, green, month, monthNumber, red, _ref;
            monthNumber = ($(v)).val();
            _ref = colorChooser(monthNumber), red = _ref[0], green = _ref[1], blue = _ref[2];
            month = moment(monthNumber).format('MMMM');
            elementIsRender = ($("#" + month)).size();
            if (!elementIsRender) {
              ($("#acotaciones")).append($("<div id='" + month + "' class='span2'> " + month + " </div>"));
            }
            return ($("#" + month)).css('background-color', "rgba( " + red + ", " + green + ", " + blue + ", 0.5)");
          });
        }
        chartData = {
          labels: labels,
          datasets: datasets
        };
        options = {
          scaleOverride: true,
          scaleSteps: 10,
          scaleStepWidth: scaleStepWidth,
          scaleStartValue: 0
        };
        ctx = $("#grafica").get(0).getContext("2d");
        return new Chart(ctx).Bar(chartData, options);
      }
    });
  });

  calculateScaleStepWidth = function(array, number) {
    var maxValue;
    maxValue = Math.max.apply(Math, array);
    if (maxValue < 100) {
      return (Math.ceil(maxValue / 10) * 10) / 10;
    }
    return (Math.ceil(maxValue / 100) * 100) / 10;
  };

  colorChooser = function(value) {
    switch (parseInt(value)) {
      case 1:
        return [220, 220, 220];
      case 2:
        return [217, 112, 65];
      case 3:
        return [88, 74, 94];
      case 4:
        return [33, 50, 61];
      case 5:
        return [157, 155, 127];
      case 6:
        return [243, 134, 48];
      case 7:
        return [224, 228, 204];
      case 8:
        return [105, 210, 231];
      case 9:
        return [247, 70, 74];
      case 10:
        return [226, 234, 233];
      case 11:
        return [212, 204, 197];
      default:
        return [151, 187, 205];
    }
  };

  $.each(moment.months(), function(k, v) {
    var div, element;
    element = "<label class='checkbox'> <input type='checkbox' name='mes' value='" + (k + 1) + "'> " + v + " </label> <br />";
    if (k % 4 === 0) {
      div = $("<div class='span2'> </div>");
    } else {
      div = $("#months div:last-child");
    }
    div.append(element);
    return ($("#months")).append(div);
  });

  ($("#todos")).click(function() {
    var checkboxes, checked;
    checkboxes = $(':checkbox');
    checked = true;
    if (($(':checkbox:checked')).length) {
      checked = false;
    }
    checkboxes.attr('checked', checked);
    return ($("form")).trigger('submit');
  });

  ($(":radio")).click(function() {
    return ($("form")).trigger('submit');
  });

  ($(":checkbox")).click(function() {
    return ($("form")).trigger('submit');
  });

}).call(this);
