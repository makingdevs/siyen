package com.siyen

import org.codehaus.groovy.grails.plugins.jasper.JasperExportFormat
import org.codehaus.groovy.grails.plugins.jasper.JasperReportDef

class CertificadoController {

  def jasperService
  def certificadoService
  def notificacionService

  def grailsApplication

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

    def reversoReporte = new File( grailsApplication.config.jasper.dir.reports + "/${claveDelCurso}.pdf" )
    response.setHeader("Content-disposition", "attachment; filename=${claveDelCurso}.pdf")
    response.outputStream << reversoReporte.readBytes()
    response
  }

  private def frenteDelCertificado(def reportData, String nombreDelCertificado) {
    def reportDef = new JasperReportDef(
      name: reportData.nombreDelCertificado.first(),
      fileFormat: JasperExportFormat.PDF_FORMAT,
      reportData: reportData
    )

    def reporte = jasperService.generateReport(reportDef).toByteArray()
    response.setHeader("Content-disposition", "attachment; filename=${nombreDelCertificado}.pdf")
    response.outputStream << reporte

    response
  }

}
