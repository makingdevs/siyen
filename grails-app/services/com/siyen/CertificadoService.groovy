package com.siyen

class CertificadoService {

  def poblarCertificado(Long cursoProgramadoId) {
    CursoProgramado cursoProgramado = CursoProgramado.get(cursoProgramadoId)

    def reportData = []
    cursoProgramado.alumnos.each { alumno ->
      def data = [:]
      data.nombreCompleto = alumno.nombreCompleto
      data.numeroControl = alumno.numeroDeControl
      data.nombreDelCurso = cursoProgramado.curso.nombre
      data.claveDelCurso = cursoProgramado.curso.clave
      data.puertoNombre = cursoProgramado.puerto.puerto
      data.puertoEstado = cursoProgramado.puerto.estado
      data.fechaDeInicio = cursoProgramado.fechaDeInicio
      data.fechaDeTermino = cursoProgramado.fechaDeTermino
      data.duracionDelCurso = cursoProgramado.curso.duracion
      data.nombreDelInstructor =  cursoProgramado.instructor.nombre
      reportData << data
    }

    reportData    
  }

}
