///|
pub fn handle_request(
  request : @sqlc.GenerateRequest
) -> @sqlc.GenerateResponse {
  let _ = try? @mustache.parse("", Json::null())
  let response = @sqlc.GenerateResponse::default()
  let file = @sqlc.File::default()
  file.name = "query_2.mbt"
  file.contents = request.to_string().to_bytes()

  response.files = [file]
  response
}
