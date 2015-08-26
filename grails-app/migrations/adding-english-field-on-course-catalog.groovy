databaseChangeLog = {

	changeSet(author: "sohjiro (generated)", id: "1440565278477-1") {
		addColumn(tableName: "curso") {
			column(name: "ingles", type: "bit") {
				constraints(nullable: "false")
			}
		}
    sql("update curso set ingles=0")
	}
}
