package com.siyen.marshallers

import grails.converters.JSON
import com.siyen.Curso
import org.codehaus.groovy.grails.web.converters.marshaller.ObjectMarshaller

class CursoMarshaller implements ObjectMarshaller<JSON> {

  boolean supports(Object object) {
    return object instanceof Curso
  }

  void marshalObject(Object object, JSON converter) {
    def curso = object as Curso
    def cursoValues = [
      id : curso.id,
      clave : curso.clave,
      nombre : curso.nombre,
      duracion : curso.duracion,
    ]
    converter.convertAnother(cursoValues)
  }

}