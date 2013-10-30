package com.siyen

import org.codehaus.groovy.grails.plugins.jasper.JasperExportFormat
import org.codehaus.groovy.grails.plugins.jasper.JasperReportDef

class CertificadoController {

  def jasperService
  def certificadoService

  def generarFrenteParaCurso() {
    def reportData = certificadoService.poblarCertificado(params.id.toLong())

    def reportDef = new JasperReportDef(
      name: 'certificado.jrxml',
      fileFormat: JasperExportFormat.PDF_FORMAT,
      reportData: reportData
    )
    def reporte = jasperService.generateReport(reportDef).toByteArray()
    response.setHeader("Content-disposition", "attachment; filename=certificado.pdf")
    response.outputStream << reporte
    response
  }

  def generarReversoParaCurso() {
    Long cursoProgramadoId = params.id.toLong()
    CursoProgramado cursoProgramado = CursoProgramado.get(cursoProgramadoId)
    String claveDelCurso = cursoProgramado.curso.clave

    def reporteReversoDef = new JasperReportDef(
      name: "${claveDelCurso}.jrxml",
      fileFormat: JasperExportFormat.PDF_FORMAT,
      reportData: []
    )
    def reversoReporte = jasperService.generateReport(reporteReversoDef).toByteArray()
    response.setHeader("Content-disposition", "attachment; filename=${claveDelCurso}.pdf")
    response.outputStream << reversoReporte
    response
  }

}