databaseChangeLog = {

	changeSet(author: "sohjiro (generated)", id: "1479611480515-1") {
		addColumn(tableName: "curso_programado") {
      column(name: "expiration_date", type: "datetime")
		}
    sql("update curso_programado set expiration_date = date_add(fecha_de_inicio, interval 5 year)")
	}

}
