import { RunQueryResult_ResultType, RunQueryResultSchema, RunQuerySchema, Value_ValueType } from "../gen-ts/query_pb.js";
import * as protobuf from "@bufbuild/protobuf";
import { Database } from "bun:sqlite";
import { convertColumnToValue, convertValueToQueryParam } from "./value_convert.js";

export class BunSqliteAdapter {
	async prepareContext(connect: string) {
		const db = new Database(connect, { create: true })
		return new BunSqliteRunQueryContext(db)
	}
	async runQuery(ctx: BunSqliteRunQueryContext, bytes: Uint8Array) {
		const runQueryCommand = protobuf.fromBinary(RunQuerySchema, bytes)
		console.log(runQueryCommand);

		const queryParams = runQueryCommand.values.map(convertValueToQueryParam);
		const query = ctx.database.query(runQueryCommand.query)
		const queryResultRows = query.all(...queryParams).map((row) => {
			const columns = Object.entries(row as Object).map(convertColumnToValue)
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
		return protobuf.toBinary(RunQueryResultSchema, result)
	}
}

class BunSqliteRunQueryContext {
	constructor(public database: Database) { }
}

