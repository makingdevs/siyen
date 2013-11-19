import grails.util.Environment

import com.siyen.*
import grails.converters.JSON
import com.siyen.marshallers.*

import org.vertx.java.core.*
import org.vertx.java.core.http.*
import org.vertx.java.core.json.*
import org.vertx.java.core.eventbus.*
import org.vertx.java.core.sockjs.SockJSServer

class BootStrap {

  def springSecurityService
  def searchableService

  def init = { servletContext ->

    def vertx = VertxFactory.newVertx("localhost")
    def eventBus = vertx.eventBus()

    HttpServer server = vertx.createHttpServer()
    JsonArray permitted = new JsonArray()
    permitted.add(new JsonObject())
    SockJSServer sockJSServer = vertx.createSockJSServer(server)
    sockJSServer.bridge(new JsonObject().putString('prefix', '/eventbus'), permitted, permitted)
    server.listen(9090)


    JSON.createNamedConfig('siyen') {
      it.registerObjectMarshaller(new CursoProgramadoMarshaller())
      it.registerObjectMarshaller(new PuertoMarshaller())
      it.registerObjectMarshaller(new CursoMarshaller())
      it.registerObjectMarshaller(new InstructorMarshaller())
      it.registerObjectMarshaller(new AlumnoMarshaller())
    }

    cargarCursos()
    cargarPuertos()
    cargarInstructores()

    switch(Environment.current) {
      case Environment.DEVELOPMENT:
        inicializarDominios()
        searchableService.index()
        break
      case Environment.PRODUCTION:
        searchableService.index()
        break
    }
  }

  def inicializarDominios() {
    createUser()
  }

  private def createUser() {
    def uniqueUser = User.findByUsername("usuario")
    if(!uniqueUser){
      log.debug "Creando usuario único en sistema: usuario/password"
      uniqueUser = new User(
        username:"usuario",
        password:"password",
        enabled:true,
        accountExpired:false,
        accountLocked:false,
        passwordExpired:false)
      uniqueUser.addToPuertos(Puerto.get(1))
      uniqueUser.addToInstructores(Instructor.get(1))
      uniqueUser.save(flush:true)
    }
    def role = Role.findByAuthority("ROLE_USER")
    if(!role)
      role = new Role(authority:"ROLE_USER").save(flush:true)
    def userRole = UserRole.findByUserAndRole(uniqueUser,role)
    def user = User.read(uniqueUser.id)
    if(!userRole)
      userRole = UserRole.create(user, role, true)
  }

  private cargarCursos() {
    if(!Curso.count()){
      log.debug "Importando cursos"
      def curso = new File( obtenerGrailsHome() + "catalogo_curso.csv" )

      curso.eachLine {
        def data = it.tokenize(';')

        new Curso( clave : data.get(0).trim(),
          nombre : data.get(1).trim(),
          duracion : data.get(2).trim().toInteger(),
          libreta : data.get(3).trim()).save(failOnError:true)
      }
    }
  }

  private cargarPuertos() {
    if(!Puerto.count()){
      log.debug "Importando puertos"
      def puerto = new File( obtenerGrailsHome() + "catalogo_puerto.csv" )

      puerto.eachLine {
        def data = it.tokenize(';')
        String direccion = data.size() == 3 ? ' ' : data.get(3).trim()

        new Puerto(
          clave : data.get(0).trim(),
          puerto : data.get(1).trim(),
          estado : data.get(2).trim(),
          direccion : direccion).save(failOnError:true)
      }
    }
  }

  private cargarInstructores() {
    if(!Instructor.count()){
      log.debug "Importando instructores antes usuarios"
      def instructor = new File( obtenerGrailsHome() + "usuario_instructor.csv" )

      instructor.eachLine {
        def data = it.tokenize(';')

        new Instructor(
          nombre : data.get(2).trim(),
          numeroDeOficio : data.get(4).trim()).save(failOnError:true)
      }
    }
  }

  private obtenerGrailsHome() {
    "${System.properties.'user.home'}/.grails/"
  }

  def destroy = {
  }
  
}
