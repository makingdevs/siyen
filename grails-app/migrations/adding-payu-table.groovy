databaseChangeLog = {


	changeSet(author: "Makingdevs (generated)", id: "1421337739456-5") {
		createTable(tableName: "payu") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "payuPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "authorization_code", type: "varchar(255)")

			column(name: "buyer_email", type: "varchar(255)")

			column(name: "currency", type: "varchar(255)")

			column(name: "installments_number", type: "varchar(255)")

			column(name: "lap_payment_method_type", type: "varchar(255)")

			column(name: "lap_response_code", type: "varchar(255)")

			column(name: "lap_transaction_state", type: "varchar(255)")

			column(name: "merchant_id", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "message", type: "varchar(255)")

			column(name: "pol_payment_method", type: "varchar(255)")

			column(name: "pol_payment_method_type", type: "varchar(255)")

			column(name: "processing_date", type: "varchar(255)")

			column(name: "reference_code", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "reference_pol", type: "varchar(255)")

			column(name: "signature", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "transaction_id", type: "varchar(255)")

			column(name: "transaction_state", type: "varchar(255)")

			column(name: "trazability_code", type: "varchar(255)")

			column(name: "tx_administrative_fee", type: "varchar(255)")

			column(name: "tx_tax", type: "varchar(255)")

			column(name: "tx_tax_administrative_fee", type: "varchar(255)")

			column(name: "tx_tax_administrative_fee_return_base", type: "varchar(255)")

			column(name: "tx_value", type: "varchar(255)")
		}
	}
}
