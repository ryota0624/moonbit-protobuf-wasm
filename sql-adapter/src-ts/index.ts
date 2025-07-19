import * as sql_adapter from "../target/js/release/build/sql-adapter.js"
import { RunQueryResult_ResultType, RunQueryResultSchema, RunQuerySchema, Value_ValueType } from "../gen-ts/query_pb.js";
import * as protobuf from "@bufbuild/protobuf";
import { Unit } from "../target/js/release/build/moonbit.js";
import { Database } from "bun:sqlite";


class JsAdapter {

	async prepareContext(connect: string) {
		const dbFileName = 'users.sqlite'
		const db = new Database(dbFileName, { create: true })

		const tableName = 'users'
		db.query('CREATE TABLE IF NOT EXISTS ' + tableName + ' (name VARCHAR(255), age INTEGER)').run()
		return new JsRunQueryContext(db)
	}
	async runQuery(ctx: JsRunQueryContext, bytes: Uint8Array) {
		const runQueryCommand = protobuf.fromBinary(RunQuerySchema, bytes)
		console.log(ctx, runQueryCommand);

		const queryParams = runQueryCommand.values.map((value) => {
			switch (value.type) {
				case Value_ValueType.UNSPECIFIED:
					throw Error("value type unspecified")
				case Value_ValueType.STRING:
					return value.str
				case Value_ValueType.INT:
					return value.int
			}
		});

		const query = ctx.database?.query(runQueryCommand.query)
		const queryResultRows = query?.all(...queryParams)?.map((row) => {
			const columns = Object.entries(row as Object).map((column) => {
				const value = (() => {
					/// TODO: null support
					switch (typeof column[1]) {
						case "string":
							return {
								type: Value_ValueType.STRING,
								str: column[1] as string,
							
							}
						case "number":
							return {
								type: Value_ValueType.INT,
								int: column[1] as unknown as bigint,
							}
						default:
							console.log(column)
							throw Error(`unsupproted column type ${typeof column[1]}`)
					}
				})()

				return {
					name: column[0],
					value: value,
				}
			})

			return {
				columns,
			}
		})

		const result = protobuf.create(RunQueryResultSchema, {
			resultType: RunQueryResult_ResultType.RESULT_SUCCESS,
			resultSet: {
				rows: queryResultRows,
			}
		})
		return (protobuf.toBinary(RunQueryResultSchema, result))


	}
}

class JsRunQueryContext {
	constructor(public database?: Database) { }
}

sql_adapter.setup_JsAdapter(new JsAdapter())

await new Promise<void>((res) => sql_adapter.app((unit: Unit) => {
	res();
	return unit;
}))

