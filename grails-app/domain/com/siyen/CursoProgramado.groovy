package com.siyen

class CursoProgramado {

  // idCurso verificar el número actual para comenzar ahí `ALTER TABLE tablename AUTO_INCREMENT = 1`
  Date fechaDeInicio 
  Date fechaDeTermino

  Date dateCreated
  Date lastUpdated

  Puerto puerto
  Curso curso
  Instructor instructor

  StatusCurso statusCurso = StatusCurso.NUEVO

  static hasMany = [alumnos : Alumno]

  static constraints = {
  }

}
