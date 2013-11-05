package com.siyen

class Instructor {

  String nombre
  String numeroDeOficio
  Boolean activo = true

  Date dateCreated
  Date lastUpdated

  static constraints = {
    nombre size:1..255, blank:false
    numeroDeOficio size:1..50, blank:false
  }

  static searchable = {
    root false
  }

  String toString() {
    nombre
  }

}