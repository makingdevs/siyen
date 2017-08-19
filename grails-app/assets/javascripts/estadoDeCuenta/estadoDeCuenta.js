$(function() {
  $('.datepicker').datepicker({
    format          : "dd/MM/yyyy",
    autoclose       : true,
    todayHighlight  : true,
    language        : 'es'
  })

  $(".datepicker").attr('readonly', 'true');
  $(".datepicker").val(moment().format('DD/MMMM/YYYY'));

  $('#result').on('click', '#calcular', function() {
    var porcentaje = parseInt( $("#porcentaje").val() );
    var total = parseInt( $("#total").text() );
    var porcentajeTotal = (porcentaje / 100) * total;
    console.log(porcentajeTotal);
    $('#totalPorcentaje').html( '<h1> Porcentaje otorgado : $' + porcentajeTotal + '</h1>' );
  });
});
