package com.siyen

import org.codehaus.groovy.grails.plugins.jasper.JasperExportFormat
import org.codehaus.groovy.grails.plugins.jasper.JasperReportDef

class CertificadoController {

  def jasperService

  def generarParaCurso() {
    log.debug "generando certificado para el curso con id ${params.id}"

    CursoProgramado cursoProgramado = CursoProgramado.get(params.id)
    def reportData = []
    def data = [:]
    data.nombreCompleto = "nombreCompleto"
    data.numeroControl = "numeroControl"
    data.nombreDelCurso = "nombreDelCurso"
    data.claveDelCurso = "claveDelCurso"
    data.puertoNombre = "puertoNombre"
    data.puertoEstado = "puertoEstado"
    data.fechaDeInicio = "fechaDeInicio"
    data.fechaDeTermino = "fechaDeTermino"
    data.duracionDelCurso = 7
    data.nombreDelInstructor = "nombreDelInstructor"
    reportData << data

    def reportDef = new JasperReportDef(
      name: 'certificado.jrxml',
      fileFormat: JasperExportFormat.PDF_FORMAT,
      reportData: reportData,
      // parameters: [urlImagen: (pathService.obtenerGrailsHome() + "log_ebc_tc.png")]
      )
    def reporte = jasperService.generateReport(reportDef).toByteArray()

    response.setHeader("Content-disposition", "attachment; filename=certificado.pdf")
    response.outputStream << reporte
    response

  }


}


class MyExpando extends Expando {

  Map props = [:]

  MyExpando(Map props) {
    super(props)
    this.props = props
  }

  def invokeMethod(String name, Object args) {
    props[name.minus('get').toLowerCase()]
  }

}