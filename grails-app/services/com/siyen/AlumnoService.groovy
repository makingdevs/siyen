package com.siyen

import grails.transaction.Transactional

@Transactional
class AlumnoService {

  def saveAlumno(alumnoData) {

    Alumno alumno = new Alumno(
      nombreCompleto : alumnoData.nombreCompleto,
      observaciones : alumnoData.observaciones,
      tipoDePago : alumnoData.tipoDePago,
      monto : alumnoData.monto
    )

    CursoProgramado cursoProgramado = CursoProgramado.get(alumnoData.cursoProgramado)
    cursoProgramado.alumnosRestantes -= 1

    def cupoRegla = cursoProgramado.alumnosRestantes >= 0 && (cursoProgramado.fechaDeInicio > (new Date() - 15))
    if(!cupoRegla) {
      return 403
    }

    cursoProgramado.save()
    alumno.cursoProgramado = cursoProgramado
    alumno.save()
    cursoProgramado.addToAlumnos(alumno)
    alumno
  }

  def updateAlumno(alumnoData){
    CursoProgramado cursoProgramado = CursoProgramado.get(alumnoData.cursoProgramado)
    def alumno = Alumno.findByNumeroDeControl(alumnoData.numeroDeControl)
    def tmpCursoProgramado = alumno.cursoProgramado
    tmpCursoProgramado.removeFromAlumnos(alumno)
    tmpCursoProgramado.save()
    cursoProgramado.addToAlumnos(alumno)
    cursoProgramado.save()
    alumno

  }

}
