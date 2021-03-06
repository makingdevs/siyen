package com.siyen

class BusquedaController {

  def searchableService
  def cursoProgramadoService

  def realizarBusqueda() {

    def busquedaDeResultados = cursoProgramadoService.buscarCursosProgramados(params)

    render template:"/cursoProgramado/list", model:[ busqueda : params.buscar, cursos : params.cursos, puertos : params.puertos, instructores : params.instructores,  desde : params.desde, hasta : params.hasta, totalResultados : busquedaDeResultados.total, lista : busquedaDeResultados.results]
  }

  def buscarCursosProgramados(){
    def busquedaDeResultados = cursoProgramadoService.buscarCursosProgramados(params)

    render view:"/cursoProgramado/search", 
          model:[ busqueda : params.buscar, 
                  cursos : params.cursos, 
                  puertos : params.puertos, 
                  instructores : params.instructores,  
                  desde : params.desde, hasta : params.hasta, 
                  totalResultados : busquedaDeResultados.total, 
                  lista : busquedaDeResultados.results,
                  catCursos: Curso.findAll { activo == true },
                  catPuertos: Puerto.findAll { it.activo },
                  catInstructores: Instructor.findAll { it.activo }
                ]
  }

  def realizarBusquedaDeAlumnos() {
    String busqueda = params.buscar

    def busquedaDeResultados = searchableService.search({
      mustNot(term("alias", "CursoProgramado"))
      if(busqueda) {
        must(queryString(busqueda))
      }
    }, params)

    render template:"/alumno/list", model:[ busqueda : busqueda, totalResultados : busquedaDeResultados.total, lista : busquedaDeResultados.results, edicion : params.edicion ]
  }

}
