package com.siyen.marshallers

import grails.converters.JSON
import com.siyen.Puerto
import org.codehaus.groovy.grails.web.converters.marshaller.ObjectMarshaller

class PuertoMarshaller implements ObjectMarshaller<JSON> {

  boolean supports(Object object) {
    return object instanceof Puerto
  }

  void marshalObject(Object object, JSON converter) {
    def puerto = object as Puerto
    def puertoValues = [
      id : puerto.id,
      clave : puerto.clave,
      puerto : puerto.puerto,
    ]
    converter.convertAnother(puertoValues)
  }

}