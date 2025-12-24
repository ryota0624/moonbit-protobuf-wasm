import { Value_ValueType } from "../gen-ts/query_pb.js";

export function convertValueToQueryParam(value: {
	type: Value_ValueType,
	str?: string,
	int?: bigint,
}): string | bigint | null {
	switch (value.type) {
		case Value_ValueType.UNSPECIFIED:
			throw Error("value type unspecified")
		case Value_ValueType.STRING:
			return value.str as string
		case Value_ValueType.INT:
			return value.int as bigint
		case Value_ValueType.NULL:
			return null;
	}
}

export function convertColumnToValue(column: [string, unknown]): { name: string, value: { type: Value_ValueType, str?: string, int?: bigint } } {
	const value = (() => {
		if (column[1] === null) {
			return {
				type: Value_ValueType.NULL,
			}
		}
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
				console.debug(column)
				throw Error(`unsupproted column type ${typeof column[1]}`)
		}
	})()

	return {
		name: column[0],
		value: value,
	}
}