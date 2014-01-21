databaseChangeLog = {

	changeSet(author: "makingdevs (generated)", id: "1390339733926-1") {
		addColumn(tableName: "curso_programado") {
			column(name: "alumnos_restantes", type: "bigint") {
				constraints(nullable: "false")
			}
		}
    sql("update curso_programado set alumnos_restantes=10")
	}
}
