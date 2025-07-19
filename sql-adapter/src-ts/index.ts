import * as sql_adapter from "../target/js/release/build/sql-adapter"
import { RunQueryResult_ResultType, RunQueryResultSchema, RunQuerySchema, Value_ValueType } from "../gen-ts/query_pb";
import * as protobuf from "@bufbuild/protobuf";
import { Unit } from "../target/js/release/build/moonbit.js";
class JsAdapter {
	async prepareContext(connect: string) {
		console.log(connect);
		return new JsRunQueryContext()
	}
	async runQuery(ctx: JsRunQueryContext, bytes: Uint8Array) {
		const runQueryCommand = protobuf.fromBinary(RunQuerySchema, bytes)
		console.log(ctx, runQueryCommand);
		const result = protobuf.create(RunQueryResultSchema, {
			resultType: RunQueryResult_ResultType.RESULT_SUCCESS,
			resultSet: {
				rows: [
					{
						columns: [
							{
								name: "age",
								value: {
									type: Value_ValueType.INT,
									int: 1000 as unknown as bigint
								}
							},
							{
								name: "name",
								value: {
									type: Value_ValueType.STRING,
									str: "taro"
								}
							},
						]
					}
				]
			}
		})
		return protobuf.toBinary(RunQueryResultSchema, result)
	}
}

class JsRunQueryContext { }

sql_adapter.setup_JsAdapter(new JsAdapter())

await new Promise<void>((res) => sql_adapter.app((unit: Unit) => {
	res();
	return unit;
}))

