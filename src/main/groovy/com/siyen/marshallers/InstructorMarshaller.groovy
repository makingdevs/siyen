package com.siyen.marshallers

import grails.converters.JSON
import com.siyen.Instructor
import org.grails.web.converters.marshaller.ObjectMarshaller

class InstructorMarshaller implements ObjectMarshaller<JSON> {

  boolean supports(Object object) {
    return object instanceof Instructor
  }

  void marshalObject(Object object, JSON converter) {
    def instructor = object as Instructor
    def instructorValues = [
      id : instructor.id,
      nombre : instructor.nombre,
      numeroDeOficio : instructor.numeroDeOficio
    ]
    converter.convertAnother(instructorValues)
  }

}
