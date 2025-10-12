///|
pub suberror RunQueryError {
  InternalDelegatedRunQueryError(String)
  InternalProtoUnknownError(Error)
} derive(Show)

///|
pub trait RunQueryContext {
  async run_query_raw(Self, str : Bytes) -> Bytes raise RunQueryError
}



///|
pub async fn[Ctx : RunQueryContext] execute(
  ctx : Ctx,
  command : @sql_adapter_query.RunQuery,
) -> Set raise RunQueryError {
  let raw_input = @buffer.new()
  let write_r = try?(@protobuf.Write::write(command, raw_input))
  write_r.map_err(RunQueryError::InternalProtoUnknownError(_)).unwrap_or_error()

  let raw_output = ctx.run_query_raw(raw_input.to_bytes())
  let r : Result[@sql_adapter_query.RunQueryResult, Error] = try? @protobuf.Read::read(
      @protobuf.BytesReader::from_bytes(raw_output),
    )
  r
  .map(res => res.result_set)
  .map(Set(_))
  .map_err(RunQueryError::InternalProtoUnknownError(_))
  .unwrap()
}

///|
pub trait ToQueryValue {
  to_value(self : Self) -> @sql_adapter_query.Value
}

///|
impl ToQueryValue for String with to_value(self) -> @sql_adapter_query.Value {
  let value = @sql_adapter_query.Value::default()
  value.type_ = VALUE_TYPE_STRING
  value.str = self
  value
}

///|
impl ToQueryValue for Int64 with to_value(self) -> @sql_adapter_query.Value {
  let value = @sql_adapter_query.Value::default()
  value.type_ = VALUE_TYPE_INT
  value.int = self
  value
}

///|
impl[T : ToQueryValue] ToQueryValue for T? with to_value(self) -> @sql_adapter_query.Value {
  match self {
    Some(v) => ToQueryValue::to_value(v)
    None => {
      let value = @sql_adapter_query.Value::default()
      value.type_ = VALUE_TYPE_NULL
      value
    }
  }
}

///|
struct Row(@sql_adapter_query.Row)

///|
struct Set(@sql_adapter_query.Set)

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
  extract_value : (@sql_adapter_query.Value) -> T raise FromRowError,
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
pub suberror FromRowError {
  InvalidType(String)
  FieldNotFound(String)
} derive(Show)

///|
pub trait FromRow {
  from_row(row : Row) -> Self raise FromRowError
}

///|
fn @sql_adapter_query.Value::int(
  self : @sql_adapter_query.Value,
) -> Int64 raise FromRowError {
  if self.type_ != VALUE_TYPE_INT {
    raise FromRowError::InvalidType("Column type is not VALUE_TYPE_INT")
  }
  self.int
}

///|
fn @sql_adapter_query.Value::string(
  self : @sql_adapter_query.Value,
) -> String raise FromRowError {
  if self.type_ != VALUE_TYPE_STRING {
    raise FromRowError::InvalidType(
      "Column type is not VALUE_TYPE_STRING",
    )
  }
  self.str
}

///|
pub trait ToPlaceHolderValue {
  to_placeholder_value(self : Self) -> Array[@sql_adapter_query.Value]
}

///|
priv struct RegisterUserCommand {
  name : String
  age : Int64
  gender : String?
}

///|
fn RegisterUserCommand::new(
  name : String,
  age : Int64,
  gender : String?,
) -> RegisterUserCommand {
  { name, age, gender }
}

///|
impl ToPlaceHolderValue for RegisterUserCommand with to_placeholder_value(self) -> Array[
  @sql_adapter_query.Value,
] {
  [
    ToQueryValue::to_value(self.name),
    ToQueryValue::to_value(self.age),
    ToQueryValue::to_value(self.gender),
  ]
}

///|
fn[X] @sql_adapter_query.Value::option(
  to_x : (@sql_adapter_query.Value) -> X raise FromRowError,
) -> (@sql_adapter_query.Value) -> X? raise FromRowError {
  (value : @sql_adapter_query.Value) => {
    if value.type_ == VALUE_TYPE_NULL {
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
    @sql_adapter_query.Value::option(@sql_adapter_query.Value::string),
  )
  { name, age, gender }
}

///|
fn[T : ToPlaceHolderValue] @sql_adapter_query.RunQuery::set_values(
  self : @sql_adapter_query.RunQuery,
  placeholder_value : T,
) -> Unit {
  self.values = placeholder_value.to_placeholder_value()
}

///|
pub async fn example(adapter : JsAdapter) -> Unit {
  let result = try? {
      let ctx = adapter.prepare_context("users.sqlite")
      let run_query = @sql_adapter_query.RunQuery::default()
      run_query.query = "CREATE TABLE IF NOT EXISTS users(name VARCHAR(255), age INTEGER, gender VARCHAR(255))"
      ignore(execute(ctx, run_query))
      let run_query = @sql_adapter_query.RunQuery::default()
      run_query.query = "INSERT INTO users(name, age, gender) values (?, ?, ?)"
      run_query.set_values(RegisterUserCommand::new("Alice", 30, None))
      ignore(execute(ctx, run_query))
      let run_query = @sql_adapter_query.RunQuery::default()
      run_query.query = "select * from users"
      let users : Array[User] = execute(ctx, run_query).convert()
      users
    }
  println(result)
}
