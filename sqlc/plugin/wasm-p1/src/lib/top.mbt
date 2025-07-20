///|
pub fn start() -> Unit {
  let input : Array[FixedArray[Byte]] = [FixedArray::make(64000000, b'\x00')]
  let read_input = try? @wasi.Fd(0).fd_read(input)
  match read_input {
    Ok(_) => ()
    Err(err) => {
      ignore(
        try? @wasi.Fd(1).fd_write([
          b"Error reading input: ",
          err.to_string() |> @encoding.encode(encoding=UTF8),
        ]),
      )
      @wasi.proc_exit(1)
    }
  }
  for bytes in input {
    let contents : Array[@bytes.View] = [@bytes.from_array([..bytes])]
    (try? @wasi.Fd(1).fd_write(contents)) |> ignore
  }
  (try? @wasi.Fd(1).fd_write([b"Input read successfully\n"])) |> ignore
  let ret = try? @wasi.Fd(1).fd_write([b"Hello\n", b"World", b"!\n"])
  match ret {
    Ok(len) =>
      (try? @wasi.Fd(1).fd_write(["\{len}" |> @encoding.encode(encoding=UTF8)]))
      |> ignore
    Err(err) => err.value() |> @wasi.proc_exit
  }
}
