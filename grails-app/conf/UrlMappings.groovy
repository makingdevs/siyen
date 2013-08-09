class UrlMappings {

  static mappings = {
    "/$controller/$action?/$id?"{
      constraints {
      }
    }

    "/curso_programados"(resource: "cursoProgramado")

    "/"(view:"/index")
    "500"(view:'/error')
  }
}
