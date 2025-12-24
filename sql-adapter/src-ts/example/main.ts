import * as sql_adapter from "../../target/js/release/build/sql-adapter.js"

import { Unit } from "../../target/js/release/build/moonbit.js";
import { BunSqliteAdapter } from "../bun_sqlite.js";

// sql_adapter.setup_JsAdapter(new BunSqliteAdapter())

await new Promise<void>((res) => sql_adapter.example(new BunSqliteAdapter(), (unit: Unit) => {
	res();
	return unit;
}, (err: any) => {
	console.error(err);
}));


