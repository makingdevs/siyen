package com.siyen

class CertificadoController {

  def jasperService
  def certificadoService
  def notificacionService

  def generarFrenteParaCurso() {
    CursoProgramado cursoProgramado = CursoProgramado.get(params.id.toLong())
    def reportData = certificadoService.poblarCertificado(cursoProgramado)

    frenteDelCertificado(reportData, "certificado")
    notificacionService.enviarNotificacion('cursoProgramado.impresion', cursoProgramado)
  }

  def generarReversoParaCurso() {
    Long cursoProgramadoId = params.id.toLong()
    CursoProgramado cursoProgramado = CursoProgramado.get(cursoProgramadoId)

    reversoParaElCurso(cursoProgramado)
  }

  def generarFrenteParaCursoPorAlumno() {
    Alumno alumno = Alumno.get(params.id.toLong())
    def reportData = certificadoService.poblarCertificadoParaElAlumno(alumno)

    frenteDelCertificado(reportData, alumno.numeroDeControl)
    notificacionService.enviarNotificacionDeAlumno("cursoProgramado.impresion_de", alumno)
  }

  def generarReversoParaCursoPorAlumno() {
    Alumno alumno = Alumno.get(params.id.toLong())
    CursoProgramado cursoProgramado = alumno.cursoProgramado

    reversoParaElCurso(cursoProgramado)
  }

  private def reversoParaElCurso(CursoProgramado cursoProgramado) {
    String claveDelCurso = cursoProgramado.curso.clave
    String fullname = "${claveDelCurso}.pdf"

    def reversoReporte = new File(grailsApplication.config.getProperty('jasper.dir.reports') + "/${fullname}")
    render(file: reversoReporte, contentType: "application/pdf", fileName: "${fullname}")
  }

  private def frenteDelCertificado(def reportData, String nombreDelCertificado) {
    String name = reportData.nombreDelCertificado.first()
    def reporteByteArray = jasperService.generateReport(reportData, name).toByteArray()

    def tempFile = File.createTempFile(nombreDelCertificado, ".pdf")
    tempFile.withOutputStream { outputStream ->
      tempFile << reporteByteArray
    }

    render(file: tempFile, contentType: "application/pdf", fileName: "${nombreDelCertificado}.pdf")
  }

}
