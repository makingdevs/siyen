package com.siyen

class CursoProgramado {

  // idCurso verificar el número actual para comenzar ahí `ALTER TABLE tablename AUTO_INCREMENT = 1`
  Date fechaDeInicio
  Date fechaDeTermino

  Date dateCreated
  Date lastUpdated
  Date expirationDate

  Puerto puerto
  Curso curso
  Instructor instructor

  Long alumnosRestantes = 10

  static belongsTo = [user : User]
  static hasMany = [alumnos : Alumno]

  static constraints = {
    expirationDate nullable: false
  }

  static searchable = {
    alumnos component: true
    puerto component : true
    curso component : true
    instructor component : true
  }

}
