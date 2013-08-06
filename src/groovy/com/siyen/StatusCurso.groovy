package com.siyen

enum StatusCurso {
  
  NUEVO("Nuevo"),
  ABIERTO("Abierto"),
  APROBADO("Aprobado"),
  CONCLUIDO("Concluido"),
  RECHAZADO("Rechazado")

  final String value
  StatusCurso(String value){ this.value = value }

  String toString(){ value }
  String getKey(){ name() }
}