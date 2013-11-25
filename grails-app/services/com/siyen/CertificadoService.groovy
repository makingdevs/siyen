package com.siyen
import grails.plugins.qrcode.*

class CertificadoService {

  def QRCodeService
  def grailsApplication

  def poblarCertificado(CursoProgramado cursoProgramado) {
    def reportData = []
    cursoProgramado.alumnos.each { alumno ->
      reportData << obtenerDatosDelAlumno(cursoProgramado, alumno)
    }

    reportData    
  }

  private obtenerDatosDelAlumno(cursoProgramado, alumno) {
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
    data.imagenPrueba = "${grailsApplication.config.jasper.dir.reports}/documento_de_prueba.png".toString()

    data.qrImage = genearQRConElNumeroDeControl(alumno.numeroDeControl)

    data
  }

  def genearQRConElNumeroDeControl(String numeroControl) {
    String serverURL = grailsApplication.config.grails.serverURL.toString()
    Map informacion = [:]
    def participanteInfo = "${serverURL}/participanteInfo?matricula=${numeroControl}"
    informacion.put("chs", "250x250")
    informacion.put("cht", "qr")
    informacion.put("chl", participanteInfo)
    informacion.put("chld", "H|1")
    informacion.put("choe", "UTF-8")
    QRCodeService.createQRCode(informacion, null, null, null)
  }

}
