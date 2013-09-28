class UrlMappings {

  static mappings = {
    "/$controller/$action?/$id?"{
      constraints {
      }
    }

    "/cursos_programados"(resource: "cursoProgramado")
    "/alumnos/$id?"(resource: "alumno")

    "/cursos"(controller:"curso", action:"jsonList")
    "/puertos"(controller:"puerto", action:"jsonList")
    "/instructores"(controller:"instructor", action:"jsonList")

    "/"(view:"/index")
    "500"(view:'/error')
  }
}
