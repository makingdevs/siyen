modules = {
  application {
    resource url:'js/emberApplication.js'
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

}