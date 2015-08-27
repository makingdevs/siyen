databaseChangeLog = {

  changeSet(author: "sohjiro (generated)", id: "1440640672357-1") {
    addColumn(tableName: "curso") {
      column(name: "description", type: "longtext")
    }
  }

  changeSet(author: "sohjiro (generated)", id: "1440640672357-2") {
    addColumn(tableName: "curso") {
      column(name: "english_name", type: "longtext")
    }
  }
}
