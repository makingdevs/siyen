databaseChangeLog = {
  changeSet(author: "sohjiro (generated)", id: "modify-duration-column") {
    modifyDataType(tableName: "curso", columnName: "duracion", newDataType: "double")
  }
}
