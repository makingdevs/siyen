import grails.util.Environment
import org.apache.log4j.DailyRollingFileAppender

def configLocations = []
def archivoDeConfiguracion = "${appName}-${Environment.current}-config.groovy"
configLocations << "file:${userHome}/.grails/${archivoDeConfiguracion}"
grails.config.locations = configLocations

log.debug "Archivos de configuración: " + configLocations

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [
    all:           '*/*',
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false
def logDirectory = 'target/'

environments {
  development {
    grails.logging.jul.usebridge = true
    grails.app.context = "/"
  }
  production {
    grails.logging.jul.usebridge = false
    logDirectory = 'logs/'
  }
}

grails.plugin.databasemigration.updateOnStart = true
grails.plugin.databasemigration.updateOnStartFileNames = ['changelog.groovy']

searchable {
  bulkIndexOnStartup = false
}

// log4j configuration
log4j = {
  appenders {
    // file name:'file', file:'/tmp/bitsapi.log'
    console name: 'stdout', layout: pattern(conversionPattern: '%d{ISO8601}\t%p\t%c:%L\t%m%n'), threshold: org.apache.log4j.Level.ERROR
    appender new DailyRollingFileAppender(name: 'file', file: logDirectory + "siyen.log",
        datePattern: '\'_\'yyyy-MM-dd', layout: pattern(conversionPattern: '%d{ISO8601}\t%p\t%c:%L\t%m%n'))
  }

  root {
    debug 'stdout', 'file'
    additivity = true
  }

  debug 'grails.app.controllers.com.siyen',
        'grails.app.taglib.com.siyen',
        'grails.app.services.com.siyen',
        'grails.app.domain.com.siyen',
        'grails.app.jobs.com.siyen'
        'grails.app.conf'

  error 'org.codehaus.groovy.grails.web.servlet',  //  controllers
        'org.codehaus.groovy.grails.web.pages', //  GSP
        'org.codehaus.groovy.grails.web.sitemesh', //  layouts
        'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
        'org.codehaus.groovy.grails.web.mapping', // URL mapping
        'org.codehaus.groovy.grails.commons', // core / classloading
        'org.codehaus.groovy.grails.plugins', // plugins
        'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
        'org.grails.plugin',
        'grails.plugin.webxml',
        'org.codehaus',
        'grails.spring',
        'net.sf.ehcache',
        'grails.util',
        'org.apache',
        'grails.plugin',
        'grails.app.resourceMappers',
        'grails.app.taglib',
        'org.grails.datastore.mapping.core',
        'io.netty',
        'com.hazelcast',
        'grails.plugin.rendering',
        'org.compass',
        'liquibase',
        'grails.app.services.grails.plugin.rendering'
}

report{
  captim321{
    englishStringCourse = "HELMSMAN FORMING PART OF A NAVIGATIONAL WATCH STCW78/95, A-II/4"
    englishStringParticipant = "Has participated in the course"
  }
  capcon322{
    englishStringCourse = "BOSUN"
    englishStringParticipant = "Has participated in the course"
  }
  capmot331{
    englishStringCourse = "FIRST MOTORMAN  FORMING PART OF AN ENGINEERING WATCH STCW78/95, A-III/4"
    englishStringParticipant = "Has participated in the course"
  }
  capmot332{
    englishStringCourse = "SECOND MOTORMAN  FORMING PART OF AN ENGINEERING WATCH STCW78/95, A-III/4"
    englishStringParticipant = "Has participated in the course"
  }
  capmot333{
    englishStringCourse = "THIRD MOTORMAN FORMING PART OF A ENGINEERING WATCH STCW78/95, A-III/4"
    englishStringParticipant = "Has participated in the course"
  }
  course2_09{
    englishStringCourse = "CROWD MANAGEMENT, PASSENGER SAFETY AND SAFETY TRAINING FOR PERSONNEL PROVIDING DIRECT SERVICES TO PASSENGERS IN PASSENGER SPACES"
    englishStringParticipant = "Has participated in the course"
  }
  fambt1{
    englishStringCourse = "TANKER FAMILIARIZATION STCW78/95, A-V/1"
    englishStringParticipant = "Has participated in the course"
  }
  opbots1{
    englishStringCourse = "PROFICIENCY IN SURVIVAL CRAFT AND RESCUE BOATS OTHER THAN FAST RESCUE BOATS STCW78/95, A-VI/2-1"
    englishStringParticipant = "Has participated in the course"
  }
  stcw95_1{
    englishStringCourse = 'Curso de repaso y actualización acorde con lo señalado en el Capítulo VI “Normas relativas a las funciones de emergencia, seguridad en el trabajo, atención médica y supervivencia”, Sección A-VI/1, (A-VI/1-1, A-VI/1-2, A-VI/1-3 y A-VI/1-4) PRIMERA REVALIDACIÓN “SITUACIONES DE EMERGENCIA”'
    englishStringParticipant = ""
  }
  stcw95_2010{
    englishStringCourse = "Acorde con lo señalado en el Capítulo VI “Normas relativas a las funciones de emergencia, seguridad en el trabajo, atención médica y supervivencia”, Sección A-VI/1 en materia de técnicas de supervivencia personal A-VI/1-1, prevención y lucha contra incendio A-VI/1-2, primeros auxilios básicos A-VI/1-3, seguridad personal y seguridad social A-VI/1-4"
    englishStringParticipant = ""
  }  
}