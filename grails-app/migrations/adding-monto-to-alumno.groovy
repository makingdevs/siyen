databaseChangeLog = {

	changeSet(author: "makingdevs (generated)", id: "1389981243868-1") {
		addColumn(tableName: "alumno") {
			column(name: "monto", type: "bigint")
		}
	}
}
