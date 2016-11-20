databaseChangeLog = {

	changeSet(author: "sohjiro (generated)", id: "1479611480515-1") {
		createTable(tableName: "alumno") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "curso_programado_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "nombre_completo", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "numero_de_control", type: "VARCHAR(10)")

			column(name: "observaciones", type: "LONGTEXT")

			column(name: "monto", type: "BIGINT")

			column(name: "tipo_de_pago", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-2") {
		createTable(tableName: "answer") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "LONGTEXT") {
				constraints(nullable: "false")
			}

			column(name: "question_id", type: "BIGINT") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-3") {
		createTable(tableName: "answer_per_instance") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "question_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "survey_per_instance_id", type: "BIGINT") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-4") {
		createTable(tableName: "answer_per_user") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "answer_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "answer_per_instance_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "DATETIME") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-5") {
		createTable(tableName: "curso") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "activo", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "clave", type: "VARCHAR(30)") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "duracion", type: "INT") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "libreta", type: "VARCHAR(1)") {
				constraints(nullable: "false")
			}

			column(name: "nombre", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "ingles", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "LONGTEXT")

			column(name: "english_name", type: "LONGTEXT")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-6") {
		createTable(tableName: "curso_programado") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "curso_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "fecha_de_inicio", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "fecha_de_termino", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "instructor_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "puerto_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "user_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "alumnos_restantes", type: "BIGINT") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-7") {
		createTable(tableName: "instructor") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "activo", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "nombre", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "numero_de_oficio", type: "VARCHAR(50)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-8") {
		createTable(tableName: "open_answer_per_user") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "answer_per_instance_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "user_answer", type: "LONGTEXT")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-9") {
		createTable(tableName: "payu") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "authorization_code", type: "VARCHAR(255)")

			column(name: "buyer_email", type: "VARCHAR(255)")

			column(name: "currency", type: "VARCHAR(255)")

			column(name: "installments_number", type: "VARCHAR(255)")

			column(name: "lap_payment_method_type", type: "VARCHAR(255)")

			column(name: "lap_response_code", type: "VARCHAR(255)")

			column(name: "lap_transaction_state", type: "VARCHAR(255)")

			column(name: "merchant_id", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "message", type: "VARCHAR(255)")

			column(name: "pol_payment_method", type: "VARCHAR(255)")

			column(name: "pol_payment_method_type", type: "VARCHAR(255)")

			column(name: "processing_date", type: "VARCHAR(255)")

			column(name: "reference_code", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "reference_pol", type: "VARCHAR(255)")

			column(name: "signature", type: "VARCHAR(255)")

			column(name: "transaction_id", type: "VARCHAR(255)")

			column(name: "transaction_state", type: "VARCHAR(255)")

			column(name: "trazability_code", type: "VARCHAR(255)")

			column(name: "tx_administrative_fee", type: "VARCHAR(255)")

			column(name: "tx_tax", type: "VARCHAR(255)")

			column(name: "tx_tax_administrative_fee", type: "VARCHAR(255)")

			column(name: "tx_tax_administrative_fee_return_base", type: "VARCHAR(255)")

			column(name: "tx_value", type: "VARCHAR(255)")

			column(name: "state_pol", type: "VARCHAR(255)")

			column(name: "sign_confirmation", type: "VARCHAR(255)")

			column(name: "payment_method", type: "VARCHAR(255)")

			column(name: "payment_method_type", type: "VARCHAR(255)")

			column(name: "transaction_date", type: "VARCHAR(255)")

			column(name: "test", type: "VARCHAR(255)")

			column(name: "account_number_ach", type: "VARCHAR(255)")

			column(name: "account_type_ach", type: "VARCHAR(255)")

			column(name: "attempts", type: "VARCHAR(255)")

			column(name: "bank_id", type: "VARCHAR(255)")

			column(name: "commision_pol", type: "VARCHAR(255)")

			column(name: "commision_pol_currency", type: "VARCHAR(255)")

			column(name: "customer_number", type: "VARCHAR(255)")

			column(name: "date", type: "VARCHAR(255)")

			column(name: "error_code_bank", type: "VARCHAR(255)")

			column(name: "error_message_bank", type: "VARCHAR(255)")

			column(name: "payment_method_id", type: "VARCHAR(255)")

			column(name: "payment_request_state", type: "VARCHAR(255)")

			column(name: "response_message_pol", type: "VARCHAR(255)")

			column(name: "transaction_bank_id", type: "VARCHAR(255)")

			column(name: "description", type: "VARCHAR(255)")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-10") {
		createTable(tableName: "puerto") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "activo", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "clave", type: "VARCHAR(4)") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "direccion", type: "LONGTEXT")

			column(name: "estado", type: "VARCHAR(30)") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "puerto", type: "VARCHAR(35)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-11") {
		createTable(tableName: "question") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "LONGTEXT") {
				constraints(nullable: "false")
			}

			column(name: "question_type", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-12") {
		createTable(tableName: "question_satisfaccion") {
			column(name: "question_id", type: "BIGINT")

			column(name: "satisfaccion_integer", type: "INT")

			column(name: "satisfaccion_idx", type: "INT")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-13") {
		createTable(tableName: "range_answer_per_user") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "answer_per_instance_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "user_answer", type: "INT")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-14") {
		createTable(tableName: "request_map") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "config_attribute", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "url", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-15") {
		createTable(tableName: "role") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "authority", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-16") {
		createTable(tableName: "survey") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "code_name", type: "VARCHAR(100)") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "LONGTEXT") {
				constraints(nullable: "false")
			}

			column(name: "title", type: "VARCHAR(100)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-17") {
		createTable(tableName: "survey_per_instance") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "survey_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "survey_per_instance_status", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-18") {
		createTable(tableName: "survey_per_instance_link") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "survey_per_instance_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "survey_per_instance_ref", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "type", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-19") {
		createTable(tableName: "survey_question") {
			column(name: "survey_questions_id", type: "BIGINT")

			column(name: "question_id", type: "BIGINT")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-20") {
		createTable(tableName: "user") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "account_expired", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "account_locked", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "enabled", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "password", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "password_expired", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "username", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-21") {
		createTable(tableName: "user_instructor") {
			column(name: "user_instructores_id", type: "BIGINT")

			column(name: "instructor_id", type: "BIGINT")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-22") {
		createTable(tableName: "user_puerto") {
			column(name: "user_puertos_id", type: "BIGINT")

			column(name: "puerto_id", type: "BIGINT")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-23") {
		createTable(tableName: "user_role") {
			column(name: "role_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "user_id", type: "BIGINT") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-24") {
		addPrimaryKey(columnNames: "role_id, user_id", tableName: "user_role")
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-25") {
		createIndex(indexName: "FKABAED504D11D6A24", tableName: "alumno", unique: "false") {
			column(name: "curso_programado_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-26") {
		createIndex(indexName: "FKABCA3FBEF5588FD2", tableName: "answer", unique: "false") {
			column(name: "question_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-27") {
		createIndex(indexName: "FK11723458869F523E", tableName: "answer_per_instance", unique: "false") {
			column(name: "survey_per_instance_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-28") {
		createIndex(indexName: "FK11723458F5588FD2", tableName: "answer_per_instance", unique: "false") {
			column(name: "question_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-29") {
		createIndex(indexName: "FK7786E50E689FA3BE", tableName: "answer_per_user", unique: "false") {
			column(name: "answer_per_instance_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-30") {
		createIndex(indexName: "FK7786E50EB1A1F6D2", tableName: "answer_per_user", unique: "false") {
			column(name: "answer_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-31") {
		createIndex(indexName: "clave_uniq_1384888856787", tableName: "curso", unique: "true") {
			column(name: "clave")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-32") {
		createIndex(indexName: "FK9F26B72B4D526BE9", tableName: "curso_programado", unique: "false") {
			column(name: "instructor_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-33") {
		createIndex(indexName: "FK9F26B72B643DC69", tableName: "curso_programado", unique: "false") {
			column(name: "user_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-34") {
		createIndex(indexName: "FK9F26B72B67E93969", tableName: "curso_programado", unique: "false") {
			column(name: "puerto_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-35") {
		createIndex(indexName: "FK9F26B72BF376AB8B", tableName: "curso_programado", unique: "false") {
			column(name: "curso_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-36") {
		createIndex(indexName: "FKCCEA8D19689FA3BE", tableName: "open_answer_per_user", unique: "false") {
			column(name: "answer_per_instance_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-37") {
		createIndex(indexName: "clave_uniq_1384888856805", tableName: "puerto", unique: "true") {
			column(name: "clave")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-38") {
		createIndex(indexName: "FKD6045A0C689FA3BE", tableName: "range_answer_per_user", unique: "false") {
			column(name: "answer_per_instance_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-39") {
		createIndex(indexName: "url_uniq_1384888856809", tableName: "request_map", unique: "true") {
			column(name: "url")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-40") {
		createIndex(indexName: "authority_uniq_1384888856810", tableName: "role", unique: "true") {
			column(name: "authority")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-41") {
		createIndex(indexName: "FKE23F0A3CDE1B8152", tableName: "survey_per_instance", unique: "false") {
			column(name: "survey_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-42") {
		createIndex(indexName: "FK2967641D869F523E", tableName: "survey_per_instance_link", unique: "false") {
			column(name: "survey_per_instance_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-43") {
		createIndex(indexName: "FK4F016B2B38B1C344", tableName: "survey_question", unique: "false") {
			column(name: "survey_questions_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-44") {
		createIndex(indexName: "FK4F016B2BF5588FD2", tableName: "survey_question", unique: "false") {
			column(name: "question_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-45") {
		createIndex(indexName: "username_uniq_1384888856814", tableName: "user", unique: "true") {
			column(name: "username")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-46") {
		createIndex(indexName: "FKA2BDBD911B8D01B5", tableName: "user_instructor", unique: "false") {
			column(name: "user_instructores_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-47") {
		createIndex(indexName: "FKA2BDBD914D526BE9", tableName: "user_instructor", unique: "false") {
			column(name: "instructor_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-48") {
		createIndex(indexName: "FKF1F86E6158A6FCA2", tableName: "user_puerto", unique: "false") {
			column(name: "user_puertos_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-49") {
		createIndex(indexName: "FKF1F86E6167E93969", tableName: "user_puerto", unique: "false") {
			column(name: "puerto_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-50") {
		createIndex(indexName: "FK143BF46A61191889", tableName: "user_role", unique: "false") {
			column(name: "role_id")
		}
	}

	changeSet(author: "sohjiro (generated)", id: "1479611480515-51") {
		createIndex(indexName: "FK143BF46A643DC69", tableName: "user_role", unique: "false") {
			column(name: "user_id")
		}
	}
}
