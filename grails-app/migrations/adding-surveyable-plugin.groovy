databaseChangeLog = {

	changeSet(author: "makingdevs (generated)", id: "1396313506744-1") {
		createTable(tableName: "answer") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "answerPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "longtext") {
				constraints(nullable: "false")
			}

			column(name: "question_id", type: "bigint") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-2") {
		createTable(tableName: "answer_per_instance") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "answer_per_inPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "question_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "survey_per_instance_id", type: "bigint") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-3") {
		createTable(tableName: "answer_per_user") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "answer_per_usPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "answer_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "answer_per_instance_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "datetime") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-4") {
		createTable(tableName: "open_answer_per_user") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "open_answer_pPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "answer_per_instance_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "user_answer", type: "longtext")
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-5") {
		createTable(tableName: "question") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "questionPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "longtext") {
				constraints(nullable: "false")
			}

			column(name: "question_type", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-6") {
		createTable(tableName: "question_satisfaccion") {
			column(name: "question_id", type: "bigint")

			column(name: "satisfaccion_integer", type: "integer")

			column(name: "satisfaccion_idx", type: "integer")
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-7") {
		createTable(tableName: "range_answer_per_user") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "range_answer_PK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "answer_per_instance_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "user_answer", type: "integer")
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-8") {
		createTable(tableName: "survey") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "surveyPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "code_name", type: "varchar(100)") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "longtext") {
				constraints(nullable: "false")
			}

			column(name: "title", type: "varchar(100)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-9") {
		createTable(tableName: "survey_per_instance") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "survey_per_inPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "survey_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "survey_per_instance_status", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-10") {
		createTable(tableName: "survey_per_instance_link") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "survey_per_inPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "survey_per_instance_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "survey_per_instance_ref", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "type", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-11") {
		createTable(tableName: "survey_question") {
			column(name: "survey_questions_id", type: "bigint")

			column(name: "question_id", type: "bigint")
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-12") {
		modifyDataType(columnName: "direccion", newDataType: "longtext", tableName: "puerto")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-13") {
		dropNotNullConstraint(columnDataType: "longtext", columnName: "direccion", tableName: "puerto")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-36") {
		createIndex(indexName: "FKABCA3FBEF5588FD2", tableName: "answer") {
			column(name: "question_id")
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-37") {
		createIndex(indexName: "FK11723458869F523E", tableName: "answer_per_instance") {
			column(name: "survey_per_instance_id")
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-38") {
		createIndex(indexName: "FK11723458F5588FD2", tableName: "answer_per_instance") {
			column(name: "question_id")
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-39") {
		createIndex(indexName: "FK7786E50E689FA3BE", tableName: "answer_per_user") {
			column(name: "answer_per_instance_id")
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-40") {
		createIndex(indexName: "FK7786E50EB1A1F6D2", tableName: "answer_per_user") {
			column(name: "answer_id")
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-41") {
		createIndex(indexName: "FKCCEA8D19689FA3BE", tableName: "open_answer_per_user") {
			column(name: "answer_per_instance_id")
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-42") {
		createIndex(indexName: "FKD6045A0C689FA3BE", tableName: "range_answer_per_user") {
			column(name: "answer_per_instance_id")
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-43") {
		createIndex(indexName: "FKE23F0A3CDE1B8152", tableName: "survey_per_instance") {
			column(name: "survey_id")
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-44") {
		createIndex(indexName: "FK2967641D869F523E", tableName: "survey_per_instance_link") {
			column(name: "survey_per_instance_id")
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-45") {
		createIndex(indexName: "FK4F016B2B38B1C344", tableName: "survey_question") {
			column(name: "survey_questions_id")
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-46") {
		createIndex(indexName: "FK4F016B2BF5588FD2", tableName: "survey_question") {
			column(name: "question_id")
		}
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-14") {
		addForeignKeyConstraint(baseColumnNames: "curso_programado_id", baseTableName: "alumno", constraintName: "FKABAED504D11D6A24", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "curso_programado", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-15") {
		addForeignKeyConstraint(baseColumnNames: "question_id", baseTableName: "answer", constraintName: "FKABCA3FBEF5588FD2", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "question", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-16") {
		addForeignKeyConstraint(baseColumnNames: "question_id", baseTableName: "answer_per_instance", constraintName: "FK11723458F5588FD2", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "question", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-17") {
		addForeignKeyConstraint(baseColumnNames: "survey_per_instance_id", baseTableName: "answer_per_instance", constraintName: "FK11723458869F523E", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "survey_per_instance", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-18") {
		addForeignKeyConstraint(baseColumnNames: "answer_id", baseTableName: "answer_per_user", constraintName: "FK7786E50EB1A1F6D2", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "answer", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-19") {
		addForeignKeyConstraint(baseColumnNames: "answer_per_instance_id", baseTableName: "answer_per_user", constraintName: "FK7786E50E689FA3BE", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "answer_per_instance", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-20") {
		addForeignKeyConstraint(baseColumnNames: "curso_id", baseTableName: "curso_programado", constraintName: "FK9F26B72BF376AB8B", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "curso", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-21") {
		addForeignKeyConstraint(baseColumnNames: "instructor_id", baseTableName: "curso_programado", constraintName: "FK9F26B72B4D526BE9", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "instructor", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-22") {
		addForeignKeyConstraint(baseColumnNames: "puerto_id", baseTableName: "curso_programado", constraintName: "FK9F26B72B67E93969", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "puerto", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-23") {
		addForeignKeyConstraint(baseColumnNames: "user_id", baseTableName: "curso_programado", constraintName: "FK9F26B72B643DC69", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-24") {
		addForeignKeyConstraint(baseColumnNames: "answer_per_instance_id", baseTableName: "open_answer_per_user", constraintName: "FKCCEA8D19689FA3BE", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "answer_per_instance", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-25") {
		addForeignKeyConstraint(baseColumnNames: "answer_per_instance_id", baseTableName: "range_answer_per_user", constraintName: "FKD6045A0C689FA3BE", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "answer_per_instance", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-26") {
		addForeignKeyConstraint(baseColumnNames: "survey_id", baseTableName: "survey_per_instance", constraintName: "FKE23F0A3CDE1B8152", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "survey", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-27") {
		addForeignKeyConstraint(baseColumnNames: "survey_per_instance_id", baseTableName: "survey_per_instance_link", constraintName: "FK2967641D869F523E", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "survey_per_instance", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-28") {
		addForeignKeyConstraint(baseColumnNames: "question_id", baseTableName: "survey_question", constraintName: "FK4F016B2BF5588FD2", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "question", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-29") {
		addForeignKeyConstraint(baseColumnNames: "survey_questions_id", baseTableName: "survey_question", constraintName: "FK4F016B2B38B1C344", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "survey", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-30") {
		addForeignKeyConstraint(baseColumnNames: "instructor_id", baseTableName: "user_instructor", constraintName: "FKA2BDBD914D526BE9", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "instructor", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-31") {
		addForeignKeyConstraint(baseColumnNames: "user_instructores_id", baseTableName: "user_instructor", constraintName: "FKA2BDBD911B8D01B5", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-32") {
		addForeignKeyConstraint(baseColumnNames: "puerto_id", baseTableName: "user_puerto", constraintName: "FKF1F86E6167E93969", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "puerto", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-33") {
		addForeignKeyConstraint(baseColumnNames: "user_puertos_id", baseTableName: "user_puerto", constraintName: "FKF1F86E6158A6FCA2", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-34") {
		addForeignKeyConstraint(baseColumnNames: "role_id", baseTableName: "user_role", constraintName: "FK143BF46A61191889", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "role", referencesUniqueColumn: "false")
	}

	changeSet(author: "makingdevs (generated)", id: "1396313506744-35") {
		addForeignKeyConstraint(baseColumnNames: "user_id", baseTableName: "user_role", constraintName: "FK143BF46A643DC69", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}
}
