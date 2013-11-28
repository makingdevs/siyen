modules = {
  application {
    resource url:'js/emberApplication.js'
    resource url:'js/emberApplication/router/router.js'
    resource url:'js/emberApplication/controller/controller.js'
    resource url:'js/emberApplication/model/store.js'
    resource url:'js/emberApplication/model/model.js'
    resource url:'js/emberApplication/helper/helper.js'
    resource url:'js/emberApplication/helper/templates.js'
    resource url:'js/emberApplication/view/view.js'
  }

  chosen {
    resource url:'css/chosen/chosen.css'
    resource url:'js/chosen/chosen.jquery.js'
  }

  dropzonejs {
    resource url:'css/dropzone/basic.css'
    resource url:'css/dropzone/dropzone.css'
    resource url:'js/dropzone/dropzone.js'
  }

  bootstrap {
    dependsOn 'jquery'
    resource url:'css/bootstrap/bootstrap.min.css'
    resource url:'js/bootstrap/bootstrap.min.js'
  }

  emberjs {
    dependsOn 'jquery'
    resource url:'js/ember/handlebars-1.0.0.js'
    resource url:'js/ember/ember-1.0.0.js'
    resource url:'js/ember/ember-data-1.0.0.js'
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
    resource url:'js/chart/siyenChart.js'
  }

}