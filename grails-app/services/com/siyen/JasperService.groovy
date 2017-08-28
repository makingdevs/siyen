package com.siyen

import net.sf.jasperreports.engine.JRException
import net.sf.jasperreports.engine.JRExporter
import net.sf.jasperreports.engine.JRExporterParameter
import net.sf.jasperreports.engine.JREmptyDataSource
import net.sf.jasperreports.engine.JasperCompileManager
import net.sf.jasperreports.engine.JasperFillManager
import net.sf.jasperreports.engine.JasperPrint
import net.sf.jasperreports.engine.JasperReport
import net.sf.jasperreports.engine.export.JRPdfExporter
import net.sf.jasperreports.engine.JRDataSource
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource

import org.springframework.core.io.FileSystemResource
import org.springframework.core.io.Resource

class JasperService {

  def grailsApplication

  def generateReport(reportData) {
    String name = reportData.nombreDelCertificado.first()
    String report_dir = grailsApplication.config.getProperty('jasper.dir.reports')
    String resourcePath = "${report_dir}/${name}"

    ByteArrayOutputStream byteArray = new ByteArrayOutputStream()
    JRExporter exporter = new JRPdfExporter()

    exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, byteArray)
    exporter.setParameter(JRExporterParameter.CHARACTER_ENCODING, "UTF-8")

    Resource resource = new FileSystemResource(resourcePath)
    JRDataSource jrDataSource = new JRBeanCollectionDataSource(reportData)
    JasperPrint jasperPrint = JasperFillManager.fillReport(JasperCompileManager.compileReport(resource.inputStream), [:], jrDataSource)

    exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint)
    exporter.exportReport()

    byteArray
  }
}
