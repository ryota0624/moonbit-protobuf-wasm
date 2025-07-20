
///|
pub fn handle_request(request : @sqlc.GenerateRequest) -> @sqlc.GenerateResponse {
  let response = @sqlc.GenerateResponse::default()
  let file = @sqlc.File::default()
  file.name = "query.mbt"
  file.contents = request.to_string().to_bytes()
  response.files = [file]
  response
}
