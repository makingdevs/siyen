grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.work.dir = "target/work"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
grails.project.war.file = "target/${appName}-${appVersion}.war"

// uncomment (and adjust settings) to fork the JVM to isolate classpaths
forkConfig = [maxMemory: 1024, minMemory: 64, debug: false, maxPerm: 256]
grails.project.fork = [
  test: false,
  run: forkConfig,
  war: forkConfig,
  console: forkConfig
]
grails.reload.enabled = true
grails.project.dependency.resolver = "maven"
grails.project.dependency.resolution = {
  // inherit Grails' default dependencies
  inherits("global") {
    // specify dependency exclusions here; for example, uncomment this to disable ehcache:
    // excludes 'ehcache'
  }
  log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
  checksums true // Whether to verify checksums on resolve
  legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

  repositories {
    inherits true // Whether to inherit repository definitions from plugins

    grailsPlugins()
    grailsHome()
    grailsCentral()

    mavenLocal()
    mavenCentral()

    // uncomment these (or add new ones) to enable remote dependency resolution from public Maven repositories
    //mavenRepo "http://snapshots.repository.codehaus.org"
    //mavenRepo "http://repository.codehaus.org"
    //mavenRepo "http://download.java.net/maven/2/"
    //mavenRepo "http://repository.jboss.com/maven2/"
    // mavenRepo "http://makingdevs.com:8081/nexus/content/repositories/thirdparty"
    mavenRepo "http://ci.makingdevs.com:8081/repository/md/"
    mavenRepo "http://repo.grails.org/grails/core"
  }

  dependencies {
    // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.
    runtime 'mysql:mysql-connector-java:5.1.22'

    compile ('net.sf.jasperreports:jasperreports:4.7.0'){
      exclude 'commons-collections'
    }
    compile ('net.sourceforge.jexcelapi:jxl:2.6.12'){
      exclude 'jasperreports'
    }

    compile 'io.vertx:vertx-platform:2.0.0-final'
    compile 'io.vertx:vertx-core:2.0.0-final'

    runtime 'org.springframework:spring-test:3.2.5.RELEASE'
    runtime 'org.xhtmlrenderer:core-renderer:R8'
    runtime 'com.lowagie:itext:2.1.0'
  }

  plugins {

    // plugins for the build system only
    build 'org.grails.plugins:tomcat:7.0.52.1'


    // plugins for the compile step
    compile "org.grails.plugins:scaffolding:2.1.2"
    compile 'org.grails.plugins:cache:1.1.3'
    compile "org.grails.plugins:asset-pipeline:2.14.1"

    // plugins needed at runtime but not for compilation
    compile "org.grails.plugins:hibernate:3.6.10.19"
    runtime 'org.grails.plugins:database-migration:1.4.0'
    runtime ':jquery:1.11.0.2'

    compile("org.grails.plugins:jasper:1.11.0"){
      exclude 'poi'
      exclude 'jackson-core-asl'
      excludes 'itext', 'itext-rtf'
    }

    compile("org.grails.plugins:rendering:1.0.0") {
      excludes 'itext'
    }

    compile "org.grails.plugins:spring-security-core:2.0.0"

    compile "org.grails.plugins:qrcode:0.7"

    compile "org.grails.plugins:searchable:0.6.9"

    compile("org.grails.plugins:grails-melody:1.59.0") {
      excludes 'itext'
    }
  }
}
