package com.siyen

class Alumno {

  String numeroDeControl // (II 0's ID).size() == 8
  String nombreCompleto
  String observaciones

  static belongsTo = [cursoProgramado : CursoProgramado]

  static constraints = {
    numeroDeControl size:1..8, blank:false // cambiar a 8..8
    nombreCompleto size:1..255, blank:false
    observaciones size:1..500, blank: true, nullable: true
  }

}
