package com.siyen

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;

class ReportingController {

  def dataSource

  def generateReport(reportData) {
    try {
      String report_dir = grailsApplication.config.getProperty('jasper.dir.reports')
      String reportName = grailsApplication.mainContext.getResource(report_dir + '/certificado.jrxml').file.getAbsoluteFile()

      JasperPrint print = JasperFillManager.fillReport(reportName, reportData, new JREmptyDataSource());

      ByteArrayOutputStream  pdfStream = new ByteArrayOutputStream();

      // exports report to pdf
      JRExporter exporter = new JRPdfExporter();
      exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
      exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, pdfStream); // your output goes here

      exporter.exportReport();
      //println 'pdfStream = '+pdfStream.size()

    } catch (Exception e) {
      throw new RuntimeException("It's not possible to generate the pdf report.", e);
    } finally {
      //render(file: pdfStream.toByteArray(), contentType: 'application/pdf')
      // render(file: pdfStream.toByteArray(), fileName: 'DownloadReport.pdf', contentType: 'application/pdf')
      pdfStream
    }
  }
}
