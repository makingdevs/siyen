package com.siyen

class Curso {

  String clave
  String nombre
  Integer duracion // dias
  String libreta

  static constraints = {
    clave size:1..30, blank:false, unique:true
    nombre size:1..255, blank:false
    duracion blank:false, max:5
    libreta size:1..1, blank:false
  }

}