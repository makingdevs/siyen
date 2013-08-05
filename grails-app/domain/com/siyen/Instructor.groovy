package com.siyen

class Instructor {

  String nombre
  String numOficio

  static constraints = {
    nombre size:1..255, blank:false
    numOficio size:1..50, blank:false
  }

}