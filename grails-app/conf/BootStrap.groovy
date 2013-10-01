import grails.util.Environment

import grails.converters.JSON
import com.siyen.marshallers.*
import com.siyen.*

class BootStrap {

  def springSecurityService

  def init = { servletContext ->

    JSON.createNamedConfig('siyen') {
      it.registerObjectMarshaller(new CursoProgramadoMarshaller())
      it.registerObjectMarshaller(new PuertoMarshaller())
      it.registerObjectMarshaller(new CursoMarshaller())
      it.registerObjectMarshaller(new InstructorMarshaller())
      it.registerObjectMarshaller(new AlumnoMarshaller())

    }

    switch(Environment.current) {
      case Environment.DEVELOPMENT:
        inicializarDominios()
        break
    }

  }

  def inicializarDominios() {
    Puerto puerto = new Puerto(
      clave : "ACG",
      puerto : "Acapulco",
      estado : "Guerrero",
      direccion : "AV. MIGUEL ALEMAN No. 306 EDIFICIO S.C.T. 2do. PISO C.P.- 39300")

    puerto.save()

    Curso curso = new Curso(
      clave : "CAPACO3234",
      nombre : "Patrón de costa (subalterno)",
      duracion : 4,
      libreta : "A")

    curso.save()

    Instructor instructor = new Instructor(
      nombre : "Cap. Alt. Joaquín Antonio Borda Aviles",
      numeroDeOficio : "109.219/2000-5706"
    )

    instructor.save()

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

  def destroy = {
  }
  
}
