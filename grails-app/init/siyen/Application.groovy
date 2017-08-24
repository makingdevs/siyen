package siyen

import grails.boot.GrailsApp
import grails.boot.config.GrailsAutoConfiguration
import org.springframework.beans.factory.config.YamlPropertiesFactoryBean
import org.springframework.context.EnvironmentAware
import org.springframework.core.env.Environment
import org.springframework.core.env.MapPropertySource
import org.springframework.core.env.PropertiesPropertySource
import org.springframework.core.io.FileSystemResource
import org.springframework.core.io.Resource
import org.springframework.context.annotation.ComponentScan

class Application extends GrailsAutoConfiguration implements EnvironmentAware {
  static void main(String[] args) {
    GrailsApp.run(Application, args)
  }

  @Override
  void setEnvironment(Environment environment) {
    def configBase = new File("${System.getProperty('user.home')}/.grails/siyen-${environment.activeProfiles[0].toUpperCase()}-config.groovy")

    if(configBase.exists()) {
      println "Loading external configuration from Groovy: ${configBase.toURL()}"
      def config = new ConfigSlurper().parse(configBase.text)
      environment.propertySources.addFirst(new MapPropertySource("externalGroovyConfig", config))
    } else {
      println "External config could not be found, checked ${configBase.absolutePath}"
    }
  }
}
