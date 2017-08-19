modules = {
  dropzonejs {
    resource url:'css/dropzone/basic.css'
    resource url:'css/dropzone/dropzone.css'
    resource url:'js/dropzone/dropzone.js'
  }

  bootstrap {
    dependsOn 'jquery'
    resource url:'css/bootstrap/bootstrap.min.css'
    resource url:'css/bootstrap/bootstrap-responsive.min.css'
    resource url:'js/bootstrap/bootstrap.min.js'
  }


  momentjs {
    resource url:'js/momentjs/moment.js'
    resource url:'js/momentjs/lang/es.js'
  }

  datepicker {
    resource url:'css/datepicker/datepicker.css'
    resource url:'js/datepicker/bootstrap-datepicker.js'
    resource url:'js/datepicker/locales/bootstrap-datepicker.es.js'
  }

  vertx {
    dependsOn 'jquery'
    resource url:'js/vertx/sockjs.min.js'
    resource url:'js/vertx/vertxbus.min.js'
  }

  menu {
    resource url:'css/menu/menu.css'
  }

  chartjs {
    resource url:'js/chart/Chart.js'
  }

  siyenChart {
    dependsOn 'chartjs'
    dependsOn 'datepicker'
    dependsOn 'momentjs'
    resource url:'js/chart/siyenChart.js'
  }

  payujs {
    resource url:'js/md5/core-min.js'
    resource url:'js/md5/md5.js'
    resource url:'js/payu/payu.js'
  }

  searchAdvanced {
    dependsOn 'datepicker'
    resource url:'css/searchCurso/search-curso-programado.css'
    resource url:'js/searchCurso/search-curso-programado.js'
  }
  editCursoProgramado{
    dependsOn 'datepicker'
    resource url:'js/searchCurso/edit-curso-programado.js'
  }
}
