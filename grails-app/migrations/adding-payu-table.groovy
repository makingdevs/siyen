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

			column(name: "signature", type: "varchar(255)")

			column(name: "transaction_id", type: "varchar(255)")

			column(name: "transaction_state", type: "varchar(255)")

			column(name: "trazability_code", type: "varchar(255)")

			column(name: "tx_administrative_fee", type: "varchar(255)")

			column(name: "tx_tax", type: "varchar(255)")

			column(name: "tx_tax_administrative_fee", type: "varchar(255)")

			column(name: "tx_tax_administrative_fee_return_base", type: "varchar(255)")

			column(name: "tx_value", type: "varchar(255)")

			column(name: "state_pol", type: "varchar(255)")

			column(name: "sign_confirmation", type: "varchar(255)")

			column(name: "payment_method", type: "varchar(255)")

			column(name: "payment_method_type", type: "varchar(255)")

			column(name: "transaction_date", type: "varchar(255)")

			column(name: "test", type: "varchar(255)")

			column(name: "account_number_ach", type: "varchar(255)")

			column(name: "account_type_ach", type: "varchar(255)")

			column(name: "attempts", type: "varchar(255)")

			column(name: "bank_id", type: "varchar(255)")

			column(name: "commision_pol", type: "varchar(255)")

			column(name: "commision_pol_currency", type: "varchar(255)")

			column(name: "customer_number", type: "varchar(255)")

			column(name: "date", type: "varchar(255)")

			column(name: "error_code_bank", type: "varchar(255)")

			column(name: "error_message_bank", type: "varchar(255)")

			column(name: "payment_method_id", type: "varchar(255)")

			column(name: "payment_request_state", type: "varchar(255)")

			column(name: "response_message_pol", type: "varchar(255)")

			column(name: "transaction_bank_id", type: "varchar(255)")

			column(name: "description", type: "varchar(255)")

		}
	}
}
