import org.vertx.java.platform.impl.*
import grails.util.Environment

beans = {

  switch(Environment.current) {
    case Environment.DEVELOPMENT:
    case Environment.TEST:
      defaultPlatformManager(DefaultPlatformManager, 9090, "localhost")
    break
    case Environment.PRODUCTION:
      defaultPlatformManager(DefaultPlatformManager, 9090, "ienpop.net")
    break
  }

}
