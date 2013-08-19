class UrlMappings {

  static mappings = {
    "/$controller/$action?/$id?"{
      constraints {
      }
    }

    "/curso_programados"(resource: "cursoProgramado")

    "/cursos"(controller:"curso", action:"jsonList")
    "/puertos"(controller:"puerto", action:"jsonList")
    "/instructores"(controller:"instructor", action:"jsonList")

    "/"(view:"/index")
    "500"(view:'/error')
  }
}
