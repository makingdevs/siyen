grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.7
grails.project.source.level = 1.7
grails.project.war.file = "target/${appName}-${appVersion}.war"

// uncomment (and adjust settings) to fork the JVM to isolate classpaths
grails.project.fork = [
    // configure settings for compilation JVM, note that if you alter the Groovy version forked compilation is required
    //  compile: [maxMemory: 256, minMemory: 64, debug: false, maxPerm: 256, daemon:true],

    // configure settings for the test-app JVM, uses the daemon by default
    test: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, daemon:true],
    // configure settings for the run-app JVM
    run: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    // configure settings for the run-war JVM
    war: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    // configure settings for the Console UI JVM
    console: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256]
]

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
    mavenRepo "http://makingdevs.com:8081/nexus/content/repositories/thirdparty"
  }

  dependencies {
    // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.
    runtime 'mysql:mysql-connector-java:5.1.22'

    compile 'net.sourceforge.jexcelapi:jxl:2.6.12'

    compile 'io.vertx:vertx-platform:2.0.0-final'
    compile 'io.vertx:vertx-core:2.0.0-final'

    runtime 'org.springframework:spring-test:3.2.5.RELEASE'
    runtime 'org.xhtmlrenderer:core-renderer:R8'
    runtime 'com.lowagie:itext:2.1.0'
  }

  plugins {
    runtime ":hibernate:3.6.10.4"
    runtime ":jquery:1.8.3"
    runtime ":resources:1.2"

    // Uncomment these (or add new ones) to enable additional resources capabilities
    //runtime ":zipped-resources:1.0"
    //runtime ":cached-resources:1.0"
    //runtime ":yui-minify-resources:0.1.5"

    compile(":jasper:1.6.1"){
      exclude 'poi'
      exclude 'jackson-core-asl'
      excludes 'itext', 'itext-rtf'
    }

    compile(":rendering:0.4.4") {
      excludes 'itext', 'itext-rtf'
    }

    build ":tomcat:7.0.47"

    runtime ":database-migration:1.3.8"

    compile ':cache:1.0.1'

    compile ":spring-security-core:1.2.7.3"

    compile ":qrcode:0.6"

    compile ":searchable:0.6.9"

    compile(":grails-melody:1.49.2") {
      excludes 'itext'
    }

    compile ':surveyable:0.1.3'

    compile ":scaffolding:2.0.1"
  }

}
