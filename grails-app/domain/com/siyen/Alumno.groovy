package com.siyen

import com.makingdevs.Surveyable

class Alumno implements Surveyable{

  String numeroDeControl // (II 0's ID).size() == 8
  String nombreCompleto
  String observaciones
  Long monto

  Date dateCreated
  Date lastUpdated

  TipoDePago tipoDePago = TipoDePago.EFECTIVO

  static belongsTo = [cursoProgramado : CursoProgramado]

  static constraints = {
    numeroDeControl size:8..10, nullable:true
    nombreCompleto size:1..255, blank:false
    observaciones size:1..500, blank: true, nullable: true
    monto blank: true, nullable: true
  }

  static searchable = true

}
