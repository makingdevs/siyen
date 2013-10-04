package com.siyen

class Alumno {

  String numeroDeControl // (II 0's ID).size() == 8
  String nombreCompleto
  String observaciones

  Date dateCreated
  Date lastUpdated

  static belongsTo = [cursoProgramado : CursoProgramado]

  static constraints = {
    numeroDeControl size:8..10, nullable:true
    nombreCompleto size:1..255, blank:false
    observaciones size:1..500, blank: true, nullable: true
  }

}
