modules = {
  application {
    resource url:'js/emberApplication.js'
    resource url:'js/emberApplication/router/router.js'
    resource url:'js/emberApplication/controller/Controller.js'
    resource url:'js/emberApplication/model/store.js'
    resource url:'js/emberApplication/model/model.js'
    resource url:'js/emberApplication/helper/helper.js'
    resource url:'js/emberApplication/view/view.js'
  }

  bootstrap {
    dependsOn 'jquery'
    resource url:'css/bootstrap/bootstrap.min.css'
    resource url:'js/bootstrap/bootstrap.min.js'
  }

  emberjs {
    dependsOn 'jquery'
    resource url:'js/ember/handlebars-1.0.0-rc.4.js'
    resource url:'js/ember/ember-1.0.0-rc.6.1.js'
    resource url:'js/ember/ember-data.js'
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

}