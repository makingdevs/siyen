import org.vertx.java.platform.impl.*
import grails.util.Environment

beans = {
  defaultPlatformManager(DefaultPlatformManager){
    9090
    grailsApplication.config.grails.app.vertx.hostname
  }
}
