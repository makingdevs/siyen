package com.siyen

class CursoProgramadoService {

  def crearCursoDesdeCommand(CursoProgramadoCommand cmd) {
    CursoProgramado cursoProgramado = new CursoProgramado()
    Date fechaDeInicio = Date.parse("dd/MMM/yyyy", cmd.fechaDeInicio)
    cursoProgramado.fechaDeInicio = fechaDeInicio
    cursoProgramado.puerto = Puerto.get(cmd.puerto)
    cursoProgramado.curso = Curso.get(cmd.curso)
    cursoProgramado.instructor = Instructor.get(cmd.instructor)
    cursoProgramado.fechaDeTermino = fechaDeInicio.clone().plus( cursoProgramado.curso.duracion )

    cmd.alumnos.each {
      String prefijo = "II"
      Integer numerosEnMatricula = 6

      Integer id = (Alumno.createCriteria().get {
        projections {
            max "id"
        }
      } ?: 0) + 1
      String numeroDeControl = prefijo + String.format("%0${numerosEnMatricula}d", id)

      Alumno alumno = new Alumno( numeroDeControl:numeroDeControl, nombreCompleto : it.nombre_completo, observaciones : it.observaciones )
      cursoProgramado.addToAlumnos(alumno)
    }

    cursoProgramado.save(failOnError:true)
    cursoProgramado
  }

}
