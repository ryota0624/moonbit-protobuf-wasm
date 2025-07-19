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
) -> Set raise RunQueryError {
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
trait ValueBuildable {
  to_value(self : Self) -> @sql_adapter_query.Value
}

///|
impl ValueBuildable for String with to_value(self) -> @sql_adapter_query.Value {
  let value = @sql_adapter_query.Value::default()
  value.type_ = Value_VALUE_TYPE_STRING
  value.str = self
  value
}

///|
impl ValueBuildable for Int64 with to_value(self) -> @sql_adapter_query.Value {
  let value = @sql_adapter_query.Value::default()
  value.type_ = Value_VALUE_TYPE_INT
  value.int = self
  value
}

///|
impl[T : ValueBuildable] ValueBuildable for T? with to_value(self) -> @sql_adapter_query.Value {
  match self {
    Some(v) => ValueBuildable::to_value(v)
    None => {
      let value = @sql_adapter_query.Value::default()
      value.type_ = Value_VALUE_TYPE_NULL
      value
    }
  }
}

///|
type Row @sql_adapter_query.Row

///|
type Set @sql_adapter_query.Set

///|
impl Show for Set with output(self, logger) {
  self.inner().output(logger)
}

///|
fn[T : FromRow] Set::convert(self : Set) -> Array[T] raise FromRowError {
  let result : Array[T] = []
  for row in self.rows {
    result.push(T::from_row(row))
  }
  result
}

///|
fn[T] Row::extract(
  self : Row,
  field : String,
  extract_value : (@sql_adapter_query.Value) -> T raise FromRowError
) -> T raise FromRowError {
  let index = self.columns.search_by(col => col.name == field)
  match index {
    None => raise FromRowError::FieldNotFound(field)
    Some(i) => {
      let column = self.columns[i]
      extract_value(column.value)
    }
  }
}

///|
suberror FromRowError {
  InvalidType(String)
  FieldNotFound(String)
} derive(Show)

///|
trait FromRow {
  from_row(row : Row) -> Self raise FromRowError
}

///|
fn @sql_adapter_query.Value::int(
  self : @sql_adapter_query.Value
) -> Int64 raise FromRowError {
  if self.type_ != Value_VALUE_TYPE_INT {
    raise FromRowError::InvalidType("Column type is not Value_VALUE_TYPE_INT")
  }
  self.int
}

///|
fn @sql_adapter_query.Value::string(
  self : @sql_adapter_query.Value
) -> String raise FromRowError {
  if self.type_ != Value_VALUE_TYPE_STRING {
    raise FromRowError::InvalidType(
      "Column type is not Value_VALUE_TYPE_STRING",
    )
  }
  self.str
}

///|
trait ToPlaceHolderValue {
  to_placeholder_value(self : Self) -> Array[@sql_adapter_query.Value]
}

///|
struct RegisterUserCommand {
  name : String
  age : Int64
  gender : String?
} derive(Show)

///|
fn RegisterUserCommand::new(
  name : String,
  age : Int64,
  gender : String?
) -> RegisterUserCommand {
  { name, age, gender }
}

///|
impl ToPlaceHolderValue for RegisterUserCommand with to_placeholder_value(self) -> Array[
  @sql_adapter_query.Value,
] {
  [
    ValueBuildable::to_value(self.name),
    ValueBuildable::to_value(self.age),
    ValueBuildable::to_value(self.gender),
  ]
}

///|
fn[X] @sql_adapter_query.Value::maybe(
  to_x : (@sql_adapter_query.Value) -> X raise FromRowError
) -> (@sql_adapter_query.Value) -> X? raise FromRowError {
  (value : @sql_adapter_query.Value) => {
    if value.type_ == Value_VALUE_TYPE_NULL {
      return None
    }
    Some(to_x(value))
  }
}

///|
priv struct User {
  name : String
  age : Int64
  gender : String?
} derive(Show)

///|
impl FromRow for User with from_row(row : Row) -> User raise FromRowError {
  let name = row.extract("name", @sql_adapter_query.Value::string)
  let age = row.extract("age", @sql_adapter_query.Value::int)
  let gender = row.extract(
    "gender",
    @sql_adapter_query.Value::maybe(@sql_adapter_query.Value::string),
  )
  { name, age, gender }
}

///|
fn[T : ToPlaceHolderValue] @sql_adapter_query.RunQuery::set_values(
  self : @sql_adapter_query.RunQuery,
  placeholder_value : T
) -> Unit {
  self.values = placeholder_value.to_placeholder_value()
}

///|
pub async fn example() -> Unit {
  let adapter = JsAdapter::global()
  let result = try? {
      let ctx = adapter.prepare_context("users.sqlite")
      let query = @sql_adapter_query.RunQuery::default()
      query.query = "CREATE TABLE IF NOT EXISTS users(name VARCHAR(255), age INTEGER, gender VARCHAR(255))"
      ignore(run_query(ctx, query))
      let query = @sql_adapter_query.RunQuery::default()
      query.query = "INSERT INTO users(name, age, gender) values (?, ?, ?)"
      query.set_values(RegisterUserCommand::new("Alice", 30, None))
      ignore(run_query(ctx, query))
      let query = @sql_adapter_query.RunQuery::default()
      query.query = "select * from users where gender is not null"
      let users : Array[User] = run_query(ctx, query).convert()
      users
    }
  println(result)
}
