databaseChangeLog = {

  changeSet(author: "makingdevs (generated)", id: "1384888857007-1") {
    createTable(tableName: "alumno") {
      column(autoIncrement: "true", name: "id", type: "bigint") {
        constraints(nullable: "false", primaryKey: "true", primaryKeyName: "alumnoPK")
      }

      column(name: "version", type: "bigint") {
        constraints(nullable: "false")
      }

      column(name: "curso_programado_id", type: "bigint") {
        constraints(nullable: "false")
      }

      column(name: "date_created", type: "datetime") {
        constraints(nullable: "false")
      }

      column(name: "last_updated", type: "datetime") {
        constraints(nullable: "false")
      }

      column(name: "nombre_completo", type: "varchar(255)") {
        constraints(nullable: "false")
      }

      column(name: "numero_de_control", type: "varchar(10)")

      column(name: "observaciones", type: "longtext")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-2") {
    createTable(tableName: "curso") {
      column(autoIncrement: "true", name: "id", type: "bigint") {
        constraints(nullable: "false", primaryKey: "true", primaryKeyName: "cursoPK")
      }

      column(name: "version", type: "bigint") {
        constraints(nullable: "false")
      }

      column(name: "activo", type: "bit") {
        constraints(nullable: "false")
      }

      column(name: "clave", type: "varchar(30)") {
        constraints(nullable: "false")
      }

      column(name: "date_created", type: "datetime") {
        constraints(nullable: "false")
      }

      column(name: "duracion", type: "integer") {
        constraints(nullable: "false")
      }

      column(name: "last_updated", type: "datetime") {
        constraints(nullable: "false")
      }

      column(name: "libreta", type: "varchar(1)") {
        constraints(nullable: "false")
      }

      column(name: "nombre", type: "varchar(255)") {
        constraints(nullable: "false")
      }
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-3") {
    createTable(tableName: "curso_programado") {
      column(autoIncrement: "true", name: "id", type: "bigint") {
        constraints(nullable: "false", primaryKey: "true", primaryKeyName: "curso_programPK")
      }

      column(name: "version", type: "bigint") {
        constraints(nullable: "false")
      }

      column(name: "curso_id", type: "bigint") {
        constraints(nullable: "false")
      }

      column(name: "date_created", type: "datetime") {
        constraints(nullable: "false")
      }

      column(name: "fecha_de_inicio", type: "datetime") {
        constraints(nullable: "false")
      }

      column(name: "fecha_de_termino", type: "datetime") {
        constraints(nullable: "false")
      }

      column(name: "instructor_id", type: "bigint") {
        constraints(nullable: "false")
      }

      column(name: "last_updated", type: "datetime") {
        constraints(nullable: "false")
      }

      column(name: "puerto_id", type: "bigint") {
        constraints(nullable: "false")
      }

      column(name: "user_id", type: "bigint") {
        constraints(nullable: "false")
      }
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-4") {
    createTable(tableName: "instructor") {
      column(autoIncrement: "true", name: "id", type: "bigint") {
        constraints(nullable: "false", primaryKey: "true", primaryKeyName: "instructorPK")
      }

      column(name: "version", type: "bigint") {
        constraints(nullable: "false")
      }

      column(name: "activo", type: "bit") {
        constraints(nullable: "false")
      }

      column(name: "date_created", type: "datetime") {
        constraints(nullable: "false")
      }

      column(name: "last_updated", type: "datetime") {
        constraints(nullable: "false")
      }

      column(name: "nombre", type: "varchar(255)") {
        constraints(nullable: "false")
      }

      column(name: "numero_de_oficio", type: "varchar(50)") {
        constraints(nullable: "false")
      }
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-5") {
    createTable(tableName: "puerto") {
      column(autoIncrement: "true", name: "id", type: "bigint") {
        constraints(nullable: "false", primaryKey: "true", primaryKeyName: "puertoPK")
      }

      column(name: "version", type: "bigint") {
        constraints(nullable: "false")
      }

      column(name: "activo", type: "bit") {
        constraints(nullable: "false")
      }

      column(name: "clave", type: "varchar(4)") {
        constraints(nullable: "false")
      }

      column(name: "date_created", type: "datetime") {
        constraints(nullable: "false")
      }

      column(name: "direccion", type: "longtext") {
        constraints(nullable: "false")
      }

      column(name: "estado", type: "varchar(30)") {
        constraints(nullable: "false")
      }

      column(name: "last_updated", type: "datetime") {
        constraints(nullable: "false")
      }

      column(name: "puerto", type: "varchar(35)") {
        constraints(nullable: "false")
      }
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-6") {
    createTable(tableName: "request_map") {
      column(autoIncrement: "true", name: "id", type: "bigint") {
        constraints(nullable: "false", primaryKey: "true", primaryKeyName: "request_mapPK")
      }

      column(name: "version", type: "bigint") {
        constraints(nullable: "false")
      }

      column(name: "config_attribute", type: "varchar(255)") {
        constraints(nullable: "false")
      }

      column(name: "url", type: "varchar(255)") {
        constraints(nullable: "false")
      }
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-7") {
    createTable(tableName: "role") {
      column(autoIncrement: "true", name: "id", type: "bigint") {
        constraints(nullable: "false", primaryKey: "true", primaryKeyName: "rolePK")
      }

      column(name: "version", type: "bigint") {
        constraints(nullable: "false")
      }

      column(name: "authority", type: "varchar(255)") {
        constraints(nullable: "false")
      }
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-8") {
    createTable(tableName: "user") {
      column(autoIncrement: "true", name: "id", type: "bigint") {
        constraints(nullable: "false", primaryKey: "true", primaryKeyName: "userPK")
      }

      column(name: "version", type: "bigint") {
        constraints(nullable: "false")
      }

      column(name: "account_expired", type: "bit") {
        constraints(nullable: "false")
      }

      column(name: "account_locked", type: "bit") {
        constraints(nullable: "false")
      }

      column(name: "enabled", type: "bit") {
        constraints(nullable: "false")
      }

      column(name: "password", type: "varchar(255)") {
        constraints(nullable: "false")
      }

      column(name: "password_expired", type: "bit") {
        constraints(nullable: "false")
      }

      column(name: "username", type: "varchar(255)") {
        constraints(nullable: "false")
      }
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-9") {
    createTable(tableName: "user_instructor") {
      column(name: "user_instructores_id", type: "bigint")

      column(name: "instructor_id", type: "bigint")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-10") {
    createTable(tableName: "user_puerto") {
      column(name: "user_puertos_id", type: "bigint")

      column(name: "puerto_id", type: "bigint")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-11") {
    createTable(tableName: "user_role") {
      column(name: "role_id", type: "bigint") {
        constraints(nullable: "false")
      }

      column(name: "user_id", type: "bigint") {
        constraints(nullable: "false")
      }
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-12") {
    addPrimaryKey(columnNames: "role_id, user_id", constraintName: "user_rolePK", tableName: "user_role")
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-24") {
    createIndex(indexName: "FKABAED504D11D6A24", tableName: "alumno") {
      column(name: "curso_programado_id")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-25") {
    createIndex(indexName: "clave_uniq_1384888856787", tableName: "curso", unique: "true") {
      column(name: "clave")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-26") {
    createIndex(indexName: "FK9F26B72B4D526BE9", tableName: "curso_programado") {
      column(name: "instructor_id")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-27") {
    createIndex(indexName: "FK9F26B72B643DC69", tableName: "curso_programado") {
      column(name: "user_id")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-28") {
    createIndex(indexName: "FK9F26B72B67E93969", tableName: "curso_programado") {
      column(name: "puerto_id")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-29") {
    createIndex(indexName: "FK9F26B72BF376AB8B", tableName: "curso_programado") {
      column(name: "curso_id")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-30") {
    createIndex(indexName: "clave_uniq_1384888856805", tableName: "puerto", unique: "true") {
      column(name: "clave")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-31") {
    createIndex(indexName: "url_uniq_1384888856809", tableName: "request_map", unique: "true") {
      column(name: "url")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-32") {
    createIndex(indexName: "authority_uniq_1384888856810", tableName: "role", unique: "true") {
      column(name: "authority")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-33") {
    createIndex(indexName: "username_uniq_1384888856814", tableName: "user", unique: "true") {
      column(name: "username")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-34") {
    createIndex(indexName: "FKA2BDBD911B8D01B5", tableName: "user_instructor") {
      column(name: "user_instructores_id")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-35") {
    createIndex(indexName: "FKA2BDBD914D526BE9", tableName: "user_instructor") {
      column(name: "instructor_id")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-36") {
    createIndex(indexName: "FKF1F86E6158A6FCA2", tableName: "user_puerto") {
      column(name: "user_puertos_id")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-37") {
    createIndex(indexName: "FKF1F86E6167E93969", tableName: "user_puerto") {
      column(name: "puerto_id")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-38") {
    createIndex(indexName: "FK143BF46A61191889", tableName: "user_role") {
      column(name: "role_id")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-39") {
    createIndex(indexName: "FK143BF46A643DC69", tableName: "user_role") {
      column(name: "user_id")
    }
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-13") {
    addForeignKeyConstraint(baseColumnNames: "curso_programado_id", baseTableName: "alumno", constraintName: "FKABAED504D11D6A24", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "curso_programado", referencesUniqueColumn: "false")
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-14") {
    addForeignKeyConstraint(baseColumnNames: "curso_id", baseTableName: "curso_programado", constraintName: "FK9F26B72BF376AB8B", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "curso", referencesUniqueColumn: "false")
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-15") {
    addForeignKeyConstraint(baseColumnNames: "instructor_id", baseTableName: "curso_programado", constraintName: "FK9F26B72B4D526BE9", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "instructor", referencesUniqueColumn: "false")
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-16") {
    addForeignKeyConstraint(baseColumnNames: "puerto_id", baseTableName: "curso_programado", constraintName: "FK9F26B72B67E93969", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "puerto", referencesUniqueColumn: "false")
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-17") {
    addForeignKeyConstraint(baseColumnNames: "user_id", baseTableName: "curso_programado", constraintName: "FK9F26B72B643DC69", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-18") {
    addForeignKeyConstraint(baseColumnNames: "instructor_id", baseTableName: "user_instructor", constraintName: "FKA2BDBD914D526BE9", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "instructor", referencesUniqueColumn: "false")
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-19") {
    addForeignKeyConstraint(baseColumnNames: "user_instructores_id", baseTableName: "user_instructor", constraintName: "FKA2BDBD911B8D01B5", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-20") {
    addForeignKeyConstraint(baseColumnNames: "puerto_id", baseTableName: "user_puerto", constraintName: "FKF1F86E6167E93969", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "puerto", referencesUniqueColumn: "false")
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-21") {
    addForeignKeyConstraint(baseColumnNames: "user_puertos_id", baseTableName: "user_puerto", constraintName: "FKF1F86E6158A6FCA2", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-22") {
    addForeignKeyConstraint(baseColumnNames: "role_id", baseTableName: "user_role", constraintName: "FK143BF46A61191889", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "role", referencesUniqueColumn: "false")
  }

  changeSet(author: "makingdevs (generated)", id: "1384888857007-23") {
    addForeignKeyConstraint(baseColumnNames: "user_id", baseTableName: "user_role", constraintName: "FK143BF46A643DC69", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
  }

	include file: 'adding-monto-to-alumno.groovy'

	include file: 'adding-alumnos-restantes-field.groovy'

	include file: 'adding-tipo-de-pago-field.groovy'

  changeSet(author: "makingdevs (generated)", id: "1384888852004-24") {
    sql("update alumno set monto=0 where monto is null")
  }

  include file: 'adding-surveyable-plugin.groovy'

	include file: 'adding-payu-table.groovy'

	include file: 'adding-english-field-on-course-catalog.groovy'

	include file: 'adding-description-and-english-name-for-curso.groovy'

	include file: 'adding-expiration-date.groovy'

	include file: 'modify-duration-column.groovy'
}
