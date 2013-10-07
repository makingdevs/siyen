package com.siyen

class Puerto {

  String clave
  String puerto
  String estado
  String direccion
  Boolean activo = true

  Date dateCreated
  Date lastUpdated

  static constraints = {
    clave size:1..4, blank:false, unique:true
    puerto size:1..35, blank:false
    estado size:1..30, blank:false
    direccion size:1..500, blank: true
  }

  String toString() {
    clave
  }

}