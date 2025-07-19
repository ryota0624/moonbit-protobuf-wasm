///|
// fn main {
//   println(@sql_adapter_query.Set::default())
// }

///|
suberror RunQueryError {
  ExecuteError(@sql_adapter_query.RunQueryError)
  InternalProtoReaderError(@protobuf.ReaderError)
  InternalProtoFormatError(String)
  InternalDelegatedRunQueryError(String)
} derive(Show)

///|
trait RunQueryContext {
  describe(Self) -> String
  async run_query_raw(Self, str : Bytes) -> Bytes raise RunQueryError
}

///|
async fn[Ctx : RunQueryContext] run_query(
  ctx : Ctx,
  command : @sql_adapter_query.RunQuery
) -> @sql_adapter_query.Set raise RunQueryError {
  let raw_input = @buffer.new()
  @protobuf.Write::write(command, raw_input)
  let raw_output = ctx.run_query_raw(raw_input.to_bytes())
  let result = try? {
      let result = (try? @sql_adapter_query.RunQueryResult::read(
          @protobuf.BytesReader::from_bytes(raw_output),
        ))
        .map_err(RunQueryError::InternalProtoReaderError(_))
        .unwrap_or_error()
      match result.result_type {
        RunQueryResult_RESULT_SUCCESS => result.result_set
        RunQueryResult_RESULT_TYPE_UNSPECIFIED =>
          raise InternalProtoFormatError(
            "RunQueryResult_RESULT_TYPE_UNSPECIFIED",
          )
        RunQueryResult_RESULT_FAILURE => raise ExecuteError(result.error)
      }
    }
  result.unwrap_or_error()
}

///|
pub async fn app() -> Unit {
  let adapter = JsAdapter::global()
  let result = try? {
      let ctx = adapter.prepare_context("psql:localhost")
      let query = @sql_adapter_query.RunQuery::default()
      query.query = "insert into users(name, age) values (?, ?)"
      query.values = [
        {
          type_: Value_VALUE_TYPE_STRING,
          str: "su",
          int: Default::default(),
          is_null: false,
        },
        {
          type_: Value_VALUE_TYPE_INT,
          str: Default::default(),
          int: 100,
          is_null: false,
        },
      ]
      ignore(run_query(ctx, query))
      let query = @sql_adapter_query.RunQuery::default()
      query.query = "select * from users"
      run_query(ctx, query)
    }
  println(result)
}

///|
// test {
//   let query = @sql_adapter_query.RunQuery::default()
//   query.query = "select * from users"
//   run_async(() => {
//     let result = try? {
//         let ctx = prepare_context("psql:localhost")
//         run_query(ctx, query)
//       }
//     println(result)
//   })
// }
