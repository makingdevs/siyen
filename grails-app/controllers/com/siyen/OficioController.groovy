package com.siyen

class OficioController {

  def generarOficio() {
    def puerto = Puerto.get(params.puertoDeEnvio.toLong())
    def desde = Date.parse('dd/MMMM/yyyy', params.desde)
    def hasta = Date.parse('dd/MMMM/yyyy', params.hasta)

    def data = [:]
    data.dirigidoA = params.dirigidoA
    data.puesto = params.puesto
    data.direccion = puerto.direccion
    data.deParteDe = Instructor.get(params.deParteDe.toLong()).nombre

    data.fechaActual = new Date().format("dd 'de' MMMM 'del' yyyy")
    data.puertoFechaAbbr = "${puerto.clave}_${new Date().format('ddMMyy')}"
    data.puerto = "${puerto.puerto}, ${puerto.estado}"
    data.desde = desde.format("dd 'de' MMMM 'del' yyyy")
    data.hasta = hasta.format("dd 'de' MMMM 'del' yyyy")

    def consulta = CursoProgramado.findAllByFechaDeInicioBetweenAndPuerto(desde, hasta, puerto)
    data.cursos = consulta.groupBy({ "${it.curso.nombre}-${it.curso.clave}" })

    renderPdf(template: "/pdfs/oficio", model: [data:data], filename: "oficio")
  }

}
