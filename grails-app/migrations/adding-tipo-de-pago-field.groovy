databaseChangeLog = {

	changeSet(author: "makingdevs (generated)", id: "1391125301235-1") {
		addColumn(tableName: "alumno") {
			column(name: "tipo_de_pago", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
    sql("update alumno set tipo_de_pago='EFECTIVO'")
	}
}
