///|
fn main {
  let bytes = b"\x0a\x00\x12\x00\x1a\x04\x68\x6f\x67\x65"
  let identifier = @gen.Identifier::default()
  identifier.name = "hoge"
  let b = @buffer.new()
  identifier.write(b)
  println(b.to_bytes().to_string())
  
  let reader = @lib.BytesReader::from_bytes(bytes)
  let eq_message = try? (identifier == @gen.Identifier::read(reader))
  println(eq_message)
}
