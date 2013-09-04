package com.siyen

import org.codehaus.groovy.grails.plugins.jasper.JasperExportFormat
import org.codehaus.groovy.grails.plugins.jasper.JasperReportDef

class CertificadoController {

  def jasperService

  def generarParaCurso() {
    log.debug "generando certificado para el curso con id ${params.id}"

    CursoProgramado cursoProgramado = CursoProgramado.get(params.id)

    model.addAttribute("curso",curso);
    model.addAttribute("puerto",puerto);
    model.addAttribute("tipoCurso",tipoCurso);
    model.addAttribute("usuario",usuario);
    model.addAttribute("alumnos", curso.getAlumnos());
    model.addAttribute("format", "pdf");

    def reportDef = new JasperReportDef(
      name: 'certificado.jrxml',
      fileFormat: JasperExportFormat.PDF_FORMAT,
      reportData: [],
      // parameters: [urlImagen: (pathService.obtenerGrailsHome() + "log_ebc_tc.png")]
      )
    log.debug reportDef
    def reporte = []// jasperService.generateReport(reportDef).toByteArray()

    response.setHeader("Content-disposition", "attachment; filename=certificado.pdf")
    response.outputStream << reporte
    response

  }


}