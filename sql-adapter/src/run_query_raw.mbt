///|
async fn run_query_raw(str : Bytes) -> Bytes raise RunQueryError {
  let result = @sql_adapter_query.RunQueryResult::default()
  result.result_type = @sql_adapter_query.RunQueryResult_ResultType::RunQueryResult_RESULT_FAILURE
  result.error = @sql_adapter_query.RunQueryError::default()
  result.error.error_type = @sql_adapter_query.RunQueryError_ERROR_TYPE_CONNECTION_ERROR
  result.error.connection_error = "fail \{str.to_string()}"

  let result_buff = @buffer.new()
  @protobuf.Write::write(result, result_buff)
  result_buff.to_bytes()
}
