

///|
pub suberror RunQueryError {
  ExecuteError(@sql_adapter_query.RunQueryError)
  InternalProtoReaderError(@protobuf.ReaderError)
  InternalProtoFormatError(String)
  InternalDelegatedRunQueryError(String)
} derive(Show)

///|
pub trait RunQueryContext {
  async run_query_raw(Self, str : Bytes) -> Bytes raise RunQueryError
}

///|
pub async fn[Ctx : RunQueryContext] run_query(
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
pub type ValueBuilder Unit

///|
pub fn ValueBuilder::string(str : String) -> @sql_adapter_query.Value {
  let value = @sql_adapter_query.Value::default()
  value.type_ = Value_VALUE_TYPE_STRING
  value.str = str
  value
}

///|
pub fn ValueBuilder::int(int : Int64) -> @sql_adapter_query.Value {
  let value = @sql_adapter_query.Value::default()
  value.type_ = Value_VALUE_TYPE_INT
  value.int = int
  value
}

///|
pub async fn example() -> Unit {
  let adapter = JsAdapter::global()
  let result = try? {
      let ctx = adapter.prepare_context("users.sqlite")
      let query = @sql_adapter_query.RunQuery::default()
      query.query = "CREATE TABLE IF NOT EXISTS users(name VARCHAR(255), age INTEGER)"
      ignore(run_query(ctx, query))
      let query = @sql_adapter_query.RunQuery::default()
      query.query = "insert into users(name, age) values (?, ?)"
      query.values = [ValueBuilder::string("Alice"), ValueBuilder::int(100)]
      ignore(run_query(ctx, query))
      let query = @sql_adapter_query.RunQuery::default()
      query.query = "select * from users"
      run_query(ctx, query)
    }
  println(result)
}

