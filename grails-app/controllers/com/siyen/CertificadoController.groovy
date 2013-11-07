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

    def reportDef = new JasperReportDef(
      name: 'certificado.jrxml',
      fileFormat: JasperExportFormat.PDF_FORMAT,
      reportData: reportData
    )
    def reporte = jasperService.generateReport(reportDef).toByteArray()
    response.setHeader("Content-disposition", "attachment; filename=certificado.pdf")
    response.outputStream << reporte

    notificacionService.enviarNotificacion('cursoProgramado.impresion', cursoProgramado)

    response
  }

  def generarReversoParaCurso() {
    Long cursoProgramadoId = params.id.toLong()
    CursoProgramado cursoProgramado = CursoProgramado.get(cursoProgramadoId)
    String claveDelCurso = cursoProgramado.curso.clave

    def reversoReporte = new File( grailsApplication.config.jasper.dir.reports + "/${claveDelCurso}.pdf" )

    response.setHeader("Content-disposition", "attachment; filename=${claveDelCurso}.pdf")
    response.outputStream << reversoReporte.readBytes()
    response
  }

}