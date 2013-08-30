import grails.util.Environment

import com.siyen.*

class BootStrap {

  def init = { servletContext ->

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

//    CursoProgramado cursoProgramado = new CursoProgramado (
//      fechaDeInicio : new Date(),
//      fechaDeTermino : new Date() + 4,
//      puerto : puerto,
//      curso : curso,
//      instructor : instructor,
//      statusCurso : StatusCurso.NUEVO )
//    cursoProgramado.save()
//
//    CursoProgramado cursoProgramado2 = new CursoProgramado (
//      fechaDeInicio : new Date() + 1,
//      fechaDeTermino : new Date() + 5,
//      puerto : puerto,
//      curso : curso,
//      instructor : instructor,
//      statusCurso : StatusCurso.NUEVO )
//    cursoProgramado2.save()
  }

  def destroy = {
  }
  
}
