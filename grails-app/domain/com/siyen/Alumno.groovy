package com.siyen

class Alumno {

  String nombreCompleto
  String observaciones

  static belongsTo = [cursoProgramado : CursoProgramado]

  static constraints = {
    nombreCompleto size:1..255, blank:false
    observaciones size:1..500, blank: true, nullable: true
  }

}
