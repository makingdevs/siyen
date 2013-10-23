package com.siyen

class CursoProgramadoService {

  def defaultPlatformManager

  def crearCursoDesdeCommand(CursoProgramadoCommand cmd) {
    CursoProgramado cursoProgramado = new CursoProgramado()
    Date fechaDeInicio = Date.parse("dd/MMM/yyyy", cmd.fechaDeInicio)
    cursoProgramado.fechaDeInicio = fechaDeInicio
    cursoProgramado.puerto = Puerto.get(cmd.puerto)
    cursoProgramado.curso = Curso.get(cmd.curso)
    cursoProgramado.instructor = Instructor.get(cmd.instructor)
    cursoProgramado.fechaDeTermino = fechaDeInicio.clone().plus( cursoProgramado.curso.duracion )

    cmd.alumnos.each { alumnoData ->
      Alumno alumno = generarAlumnoConParams(alumnoData)
      cursoProgramado.addToAlumnos(alumno)
    }

    cursoProgramado.save(failOnError:true)

    cursoProgramado.alumnos.each { alumno ->
      alumno.numeroDeControl = generarNumeroDeControl(alumno.id)
      alumno.save(failOnError:true)
    }

    def vertx = defaultPlatformManager.vertx()
    def eventBus = vertx.eventBus()
    eventBus.publish('cursoProgramado.save', cursoProgramado.id)

    cursoProgramado
  }

  private Alumno generarAlumnoConParams( def alumnoData ) {
    Alumno alumno = new Alumno( nombreCompleto : alumnoData.nombreCompleto, observaciones : alumnoData.observaciones )
    alumno
  }

  private String generarNumeroDeControl(def id) {
    String prefijo = "II"
    Integer numerosEnMatricula = 6
    String numeroDeControl = prefijo + String.format("%0${numerosEnMatricula}d", id)
    numeroDeControl
  }

}
