class UrlMappings {

  static mappings = {
    "/$controller/$action?/$id?"{
      constraints {
      }
    }

    "/curso_programados"(resource: "cursoProgramado")

    "/cursos"(resource:"cursos")
    "/cursos/$id"(controller:"curso", action:"mostrar")

    "/puertos"(resource:"puertos")

    "/"(view:"/index")
    "500"(view:'/error')
  }
}
