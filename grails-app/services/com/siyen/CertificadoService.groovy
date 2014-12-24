package com.siyen
import grails.plugins.qrcode.*
import javax.imageio.ImageIO

class CertificadoService {

  def QrCodeService
  def grailsApplication

  def poblarCertificado(CursoProgramado cursoProgramado) {
    def reportData = []
    def dataCursoProgramado = obtenerDatosCursoProgramado(cursoProgramado)
    cursoProgramado.alumnos.each { alumno ->
      reportData << obtenerDatosDelAlumno(alumno) + dataCursoProgramado
    }
    reportData
  }

  def poblarCertificadoParaElAlumno(Alumno alumno) {
    def dataCursoProgramado = obtenerDatosCursoProgramado(cursoProgramado)
    [ obtenerDatosDelAlumno(alumno) + dataCursoProgramado]
  }

  private obtenerDatosCursoProgramado(cursoProgramado){
    def dataCursoProgramado = [:]
    dataCursoProgramado.nombreDelCurso = cursoProgramado.curso.nombre
    dataCursoProgramado.claveDelCurso = cursoProgramado.curso.clave
    if(dataCursoProgramado.claveDelCurso.startsWith('PATRON_DE_YATE_')) {
      dataCursoProgramado.claveDelCurso = 'PATRON_DE_YATE'
    }
    dataCursoProgramado.puertoNombre = cursoProgramado.puerto.puerto
    dataCursoProgramado.puertoEstado = cursoProgramado.puerto.estado
    dataCursoProgramado.fechaDeInicio = cursoProgramado.fechaDeInicio
    dataCursoProgramado.fechaDeTermino = cursoProgramado.fechaDeTermino
    dataCursoProgramado.duracionDelCurso = cursoProgramado.curso.duracion
    dataCursoProgramado.nombreDelInstructor =  cursoProgramado.instructor.nombre
    dataCursoProgramado
  }

  private obtenerDatosDelAlumno(alumno) {
    def dataAlumno = [:]
    dataAlumno.nombreCompleto = alumno.nombreCompleto
    dataAlumno.numeroControl = alumno.numeroDeControl
    dataAlumno.imagenPrueba = "${grailsApplication.config.jasper.dir.reports}/documento_de_prueba.png".toString()
    dataAlumno.qrImage = genearQRConElNumeroDeControl(alumno.numeroDeControl)
    dataAlumno
  }

  def genearQRConElNumeroDeControl(String numeroControl) {
    String serverURL = grailsApplication.config.grails.serverURL.toString()
    OutputStream os = new FileOutputStream("${grailsApplication.config.jasper.dir.reports}/qrImage${numeroControl}.png");
    def participanteInfo = "${serverURL}/participanteInfo?matricula=${numeroControl}".toString()
    QrCodeService.renderPng(participanteInfo, 150, os)
    def fileQRCode = new File("${grailsApplication.config.jasper.dir.reports}/qrImage${numeroControl}.png")
    def image = ImageIO.read(fileQRCode)
    fileQRCode.delete()
    image
  }

}
