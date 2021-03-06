package com.siyen.marshallers

import grails.converters.JSON
import com.siyen.CursoProgramado
import org.codehaus.groovy.grails.web.converters.marshaller.ObjectMarshaller

class CursoProgramadoMarshaller implements ObjectMarshaller<JSON> {

  boolean supports(Object object) {
    return object instanceof CursoProgramado
  }

  void marshalObject(Object object, JSON converter) {
    def cursoProgramado = object as CursoProgramado
    def cursoProgramadoValues = [
      id : cursoProgramado.id,
      fechaDeInicio : cursoProgramado.fechaDeInicio,
      fechaDeTermino : cursoProgramado.fechaDeTermino,
      puerto : cursoProgramado.puerto.id,
      curso : cursoProgramado.curso.id,
      instructor : cursoProgramado.instructor.id,
      alumnosRestantes : cursoProgramado.alumnosRestantes,
      alumnos : cursoProgramado.alumnos?.id ?: []
    ]
    converter.convertAnother(cursoProgramadoValues)
  }

}
