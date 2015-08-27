package com.siyen

class Curso {

  String clave
  String nombre
  Integer duracion // dias
  String libreta
  Boolean activo = true
  Boolean ingles = false

  String englishName
  String description

  Date dateCreated
  Date lastUpdated

  static searchable = {
    root false
  }

  static constraints = {
    clave size:1..30, blank:false, unique:true
    nombre size:1..255, blank:false
    duracion blank:false, max:5
    libreta size:1..1, blank:false
    englishName size:1..1000, blank:true, nullable: true
    description size:1..1000, blank:true, nullable: true
  }

}
