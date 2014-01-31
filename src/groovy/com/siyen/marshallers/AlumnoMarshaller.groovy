package com.siyen.marshallers

import grails.converters.JSON
import com.siyen.Alumno
import org.codehaus.groovy.grails.web.converters.marshaller.ObjectMarshaller

class AlumnoMarshaller implements ObjectMarshaller<JSON> {

  boolean supports(Object object) {
    return object instanceof Alumno
  }

  void marshalObject(Object object, JSON converter) {
    def alumno = object as Alumno
    def alumnoValues = [
      id : alumno.id,
      numeroDeControl : alumno.numeroDeControl,
      nombreCompleto : alumno.nombreCompleto,
      tipoDePago : alumno.tipoDePago.key,
      observaciones : alumno.observaciones,
      monto : alumno.monto,
      cursoProgramado : alumno.cursoProgramado.id
    ]
    converter.convertAnother(alumnoValues)
  }

}
