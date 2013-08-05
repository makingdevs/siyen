package com.siyen

class Instructor {

  String nombre
  String numeroDeOficio
  Boolean activo = true

  static constraints = {
    nombre size:1..255, blank:false
    numeroDeOficio size:1..50, blank:false
  }

}