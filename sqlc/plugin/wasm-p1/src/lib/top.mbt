///|
fn main {
  let result = try? {
      log_error("Starting SQLC plugin...")
      let reader = @protobuf.BytesReader::from_bytes(
        @bytes.from_array(read_file(@wasi.Fd(0))),
      )
      let request = @sqlc.GenerateRequest::read(reader)
      let response = @handle_request.handle_request(request)
      let writer = @buffer.new()
      @protobuf.Write::write(response, writer)
      let file_names = response.files.map(f => f.name).join(", ")
      log_error("Generated files: \{file_names}")
      let contents : Array[@bytes.View] = [
        @bytes.from_array(writer.to_bytes().to_array()),
      ]
      @wasi.Fd(1).fd_write(contents)
    }
  match result {
    Err(e) => {
      log_error("Failed to process request: \{e.to_string()}")
      @wasi.proc_exit(1)
    }
    Ok(_) => @wasi.proc_exit(0)
  }
}

///|
const BUFFER_LEN : UInt64 = 4096

///|
fn read_file(fd : @wasi.Fd) -> Array[Byte] raise @wasi.Errno {
  let result : Array[Byte] = []
  while true {
    let output = FixedArray::make(BUFFER_LEN.to_int(), b'\x00')
    let read_output : Array[FixedArray[Byte]] = [output]
    let size = try? fd.fd_read(read_output)
    match size {
      Err(err) => {
        log_error(err.to_string())
        raise err
      }
      Ok(size) =>
        if size == 0 {
          // No more data to read, exit loop
          break
        } else {
          let read = FixedArray::make(
            size.inner().reinterpret_as_int(),
            b'\x00',
          )
          output.blit_to(
            read,
            src_offset=0,
            dst_offset=0,
            len=size.inner().reinterpret_as_int(),
          )
          result.append([..read])
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
  (try? @wasi.Fd(2).fd_write(contents)) |> ignore
}
