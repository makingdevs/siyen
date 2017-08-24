package com.siyen

enum TipoDePago {
  
  BECADO("Becado"),
  DEPOSITO_BANCARIO("Depósito bancario"),
  EFECTIVO("Efectivo")

  final String value
  TipoDePago(String value){ this.value = value }

  String toString(){ value }
  String getKey(){ name() }
}
