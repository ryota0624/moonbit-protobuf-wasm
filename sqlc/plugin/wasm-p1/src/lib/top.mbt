///|
pub fn start() -> Unit {
  let file = try? read_file(@wasi.Fd(0))
  match file {
    Err(err) => {
      log_error(err.to_string())
      @wasi.proc_exit(1)
    }
    Ok(file) => {
      let reader = @protobuf.BytesReader::from_bytes(@bytes.from_array(file))
      let result = try? {
          let request = @sqlc.GenerateRequest::read(reader)
          let response = handle_request(request)
          let writer = @buffer.new()
          @protobuf.Write::write(response, writer)
          let contents : Array[@bytes.View] = [
            @bytes.from_array(writer.to_bytes().to_array()),
          ]
          (try? @wasi.Fd(1).fd_write(contents)) |> ignore
        }
    }
  }
}

///|
fn handle_request(request : @sqlc.GenerateRequest) -> @sqlc.GenerateResponse {
  let response = @sqlc.GenerateResponse::default()
  let file = @sqlc.File::default()
  file.name = "query.mbt"
  file.contents = request.to_string().to_bytes()
  response.files = [file]
  response
}

///|
const BUFFER_LEN : UInt64 = 4096

///|
fn read_file(fd : @wasi.Fd) -> Array[Byte] raise @wasi.Errno {
  let result : Array[Byte] = []
  let mut read_cursor : @wasi.FileSize = 0
  while true {
    let output = FixedArray::make(BUFFER_LEN.to_int(), b'\x00')
    let read_output : Array[FixedArray[Byte]] = [output]
    let size = try? fd.fd_read(read_output)
    match size {
      Err(err) if err == Success =>
        if read_cursor == 0 {
          // No data read, exit loop
          break
        }
      Err(err) => {
        log_error(err.to_string())
        raise err
      }
      Ok(size) =>
        if size == 0 {
          // No more data to read, exit loop
          break
        } else {
          read_cursor = read_cursor.inner() + size.inner().to_uint64()
          result.append([..output])
        }
    }
  }
  result
}

///|
fn log_error(err : String) -> Unit {
  let contents : Array[@bytes.View] = [
    @bytes.from_array("Error: \{err.to_string()}\n".to_bytes().to_array()),
  ]
  (try? @wasi.Fd(1).fd_write(contents)) |> ignore
}
