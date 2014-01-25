package com.siyen

import grails.plugin.rendering.pdf.*

class OficioController {

  def springSecurityService

  def generarOficio() {
    def puerto = Puerto.get(params.puertoDeEnvio.toLong())
    def desde = Date.parse('dd/MMMM/yyyy', params.desde)
    def hasta = Date.parse('dd/MMMM/yyyy', params.hasta)

    def data = [:]
    data.dirigidoA = params.dirigidoA
    data.puesto = params.puesto
    data.direccion = params.direccion
    data.deParteDe = Instructor.get(params.deParteDe.toLong()).nombre

    data.fechaActual = new Date().format("dd 'de' MMMM 'del' yyyy")
    data.puertoFechaAbbr = "${puerto.clave}_${new Date().format('ddMMyy')}"
    data.puerto = "${puerto.puerto}, ${puerto.estado}"
    data.desde = desde.format("dd 'de' MMMM 'del' yyyy")
    data.hasta = hasta.format("dd 'de' MMMM 'del' yyyy")
    data.cursos = CursoProgramado.findAllByFechaDeInicioBetween(desde, hasta)

    renderPdf(template: "/pdfs/oficio", model: [data:data], filename: "oficio")
  }

}
