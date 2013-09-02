package com.siyen

import jxl.*

class ProcesarArchivoController {

  def procesarArchivo() {
    FileInputStream excelParaProcesar = params.file.inputStream
    WorkbookSettings ws = new WorkbookSettings()
    ws.setEncoding("Cp1252")
    Workbook workbook = Workbook.getWorkbook(excelParaProcesar, ws)
    Sheet sheet = workbook.getSheet(0)

    def contenidoDeFilas = []

    (1..sheet.getRows() - 1).each { fila ->
      contenidoDeFilas << sheet.getRow( fila )*.getContents()
    }

    render(contentType:"text/json") {
      [ contenidoDeFilas : contenidoDeFilas ]
    }
  }

}
