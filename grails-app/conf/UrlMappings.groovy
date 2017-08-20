class UrlMappings {

  static mappings = {
    "/$controller/$action?/$id?"{
      constraints {
      }
    }

    "/cursos_programados/$id?"(resource: "cursoProgramado")
    "/alumnos/$id?"(resource: "alumno")

    "/participanteInfo"(controller:"participante", action:"index")

    "/cursos"(controller:"curso", action:"jsonList")

    "/puertos"(controller:"puerto", action:"jsonList")
    "/puertos/$id"(controller:"puerto", action:"view")

    "/instructores"(controller:"instructor", action:"jsonList")
    "/instructores/$id"(controller:"instructor", action:"view")

    "/oficio/generarOficio"(controller:"oficio", action:"generarOficio")

    "/"(view:"/index")
    "500"(view:'/error')
  }
}
