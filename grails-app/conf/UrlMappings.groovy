class UrlMappings {

  static mappings = {
    "/$controller/$action?/$id?"{
      constraints {
      }
    }

    "/curso_programados"(resource: "cursoProgramado")

    "/puertos"(resource:"puertos")
    "/puertos/$id"(controller:"puerto", action:"mostrar")

    "/"(view:"/index")
    "500"(view:'/error')
  }
}
