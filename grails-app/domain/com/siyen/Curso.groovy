package com.siyen

class Curso {

  String clave
  String nombre
  Integer duracion // dias
  String libreta
  Boolean activo = true

  Date dateCreated
  Date lastUpdated

  static searchable = {
    root false
  }

}