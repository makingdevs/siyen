package com.siyen

class CatalogoService {

  def obtenerInstructores() {
    Instructor.findAllByActivo(true)
  }

  def obtenerCursos() {
    Curso.findAllByActivo(true)
  }

  def obtenerPuertos() {
    Puerto.findAllByActivo(true)
  }

}