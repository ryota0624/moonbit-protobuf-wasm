pub(all) struct File {
  mut name : String
  mut contents : Bytes
} derive(Eq, Show)
pub impl @protobuf.Sized for File with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @protobuf.size_of(self.name); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.contents); @protobuf.size_of(size) + size }
  size
}
pub impl Default for File with default() -> File {
  File::{
    name : String::default(),
    contents : Bytes::default(),
  }
}
pub fn File::new(name : String, contents : Bytes) -> File {
  File::{
    name,
    contents,
  }
}
pub impl @protobuf.Read for File with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.Reader]) -> File raise {
  let msg = File::default()
  try {
    for {
      match (reader |> @protobuf.read_tag()) {
      (1, _) => msg.name = reader |> @protobuf.read_string()
      (2, _) => msg.contents = reader |> @protobuf.read_bytes()
       (_, wire) => reader |> @protobuf.read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.Write for File with write(self: File, writer : &@protobuf.Writer) -> Unit raise {
  writer |> @protobuf.write_varint(10UL);
  writer |> @protobuf.write_string(self.name)
  writer |> @protobuf.write_varint(18UL);
  writer |> @protobuf.write_bytes(self.contents)
}
pub impl @protobuf.AsyncRead for File with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.AsyncReader]) -> File raise {
  let msg = File::default()
  try {
    for {
      match (reader |> @protobuf.async_read_tag()) {
      (1, _) => msg.name = reader |> @protobuf.async_read_string()
      (2, _) => msg.contents = reader |> @protobuf.async_read_bytes()
       (_, wire) => reader |> @protobuf.async_read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.AsyncWrite for File with write(self: File, writer : &@protobuf.AsyncWriter) -> Unit raise {
  writer |> @protobuf.async_write_varint(10UL);
  writer |> @protobuf.async_write_string(self.name)
  writer |> @protobuf.async_write_varint(18UL);
  writer |> @protobuf.async_write_bytes(self.contents)
}
pub(all) struct Settings {
  mut version : String
  mut engine : String
  mut schema : Array[String]
  mut queries : Array[String]
  mut codegen :  Codegen 
} derive(Eq, Show)
pub impl @protobuf.Sized for Settings with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @protobuf.size_of(self.version); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.engine); @protobuf.size_of(size) + size }
  size += self.schema.iter().map(@protobuf.size_of).map(s => 1U + @protobuf.size_of(s) + s).fold(init=0U, UInt::op_add)
  size += self.queries.iter().map(@protobuf.size_of).map(s => 1U + @protobuf.size_of(s) + s).fold(init=0U, UInt::op_add)
  size += 1U + { let size = @protobuf.size_of(self.codegen); @protobuf.size_of(size) + size }
  size
}
pub impl Default for Settings with default() -> Settings {
  Settings::{
    version : String::default(),
    engine : String::default(),
    schema : [],
    queries : [],
    codegen : Codegen::default(),
  }
}
pub fn Settings::new(version : String, engine : String, schema : Array[String], queries : Array[String], codegen : Codegen) -> Settings {
  Settings::{
    version,
    engine,
    schema,
    queries,
    codegen,
  }
}
pub impl @protobuf.Read for Settings with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.Reader]) -> Settings raise {
  let msg = Settings::default()
  try {
    for {
      match (reader |> @protobuf.read_tag()) {
      (1, _) => msg.version = reader |> @protobuf.read_string()
      (2, _) => msg.engine = reader |> @protobuf.read_string()
      (3, _) => msg.schema.push(reader |> @protobuf.read_string())
      (4, _) => msg.queries.push(reader |> @protobuf.read_string())
      (12, _) => msg.codegen = (reader |> @protobuf.read_message() : Codegen)
       (_, wire) => reader |> @protobuf.read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.Write for Settings with write(self: Settings, writer : &@protobuf.Writer) -> Unit raise {
  writer |> @protobuf.write_varint(10UL);
  writer |> @protobuf.write_string(self.version)
  writer |> @protobuf.write_varint(18UL);
  writer |> @protobuf.write_string(self.engine)
  for item in self.schema {
    writer |> @protobuf.write_varint(26UL)
    writer |> @protobuf.write_string(item)

  }
  for item in self.queries {
    writer |> @protobuf.write_varint(34UL)
    writer |> @protobuf.write_string(item)

  }
  writer |> @protobuf.write_varint(98UL);
  writer |> @protobuf.write_uint32(@protobuf.size_of(self.codegen)); @protobuf.Write::write(self.codegen, writer)
}
pub impl @protobuf.AsyncRead for Settings with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.AsyncReader]) -> Settings raise {
  let msg = Settings::default()
  try {
    for {
      match (reader |> @protobuf.async_read_tag()) {
      (1, _) => msg.version = reader |> @protobuf.async_read_string()
      (2, _) => msg.engine = reader |> @protobuf.async_read_string()
      (3, _) => msg.schema.push(reader |> @protobuf.async_read_string())
      (4, _) => msg.queries.push(reader |> @protobuf.async_read_string())
      (12, _) => msg.codegen = (reader |> @protobuf.async_read_message() : Codegen)
       (_, wire) => reader |> @protobuf.async_read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.AsyncWrite for Settings with write(self: Settings, writer : &@protobuf.AsyncWriter) -> Unit raise {
  writer |> @protobuf.async_write_varint(10UL);
  writer |> @protobuf.async_write_string(self.version)
  writer |> @protobuf.async_write_varint(18UL);
  writer |> @protobuf.async_write_string(self.engine)
  for item in self.schema {
    writer |> @protobuf.async_write_varint(26UL)
    writer |> @protobuf.async_write_string(item)

  }
  for item in self.queries {
    writer |> @protobuf.async_write_varint(34UL)
    writer |> @protobuf.async_write_string(item)

  }
  writer |> @protobuf.async_write_varint(98UL);
  writer |> @protobuf.async_write_uint32(@protobuf.size_of(self.codegen)); @protobuf.AsyncWrite::write(self.codegen, writer)
}
pub(all) struct Codegen_Process {
  mut cmd : String
} derive(Eq, Show)
pub impl @protobuf.Sized for Codegen_Process with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @protobuf.size_of(self.cmd); @protobuf.size_of(size) + size }
  size
}
pub impl Default for Codegen_Process with default() -> Codegen_Process {
  Codegen_Process::{
    cmd : String::default(),
  }
}
pub fn Codegen_Process::new(cmd : String) -> Codegen_Process {
  Codegen_Process::{
    cmd,
  }
}
pub impl @protobuf.Read for Codegen_Process with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.Reader]) -> Codegen_Process raise {
  let msg = Codegen_Process::default()
  try {
    for {
      match (reader |> @protobuf.read_tag()) {
      (1, _) => msg.cmd = reader |> @protobuf.read_string()
       (_, wire) => reader |> @protobuf.read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.Write for Codegen_Process with write(self: Codegen_Process, writer : &@protobuf.Writer) -> Unit raise {
  writer |> @protobuf.write_varint(10UL);
  writer |> @protobuf.write_string(self.cmd)
}
pub impl @protobuf.AsyncRead for Codegen_Process with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.AsyncReader]) -> Codegen_Process raise {
  let msg = Codegen_Process::default()
  try {
    for {
      match (reader |> @protobuf.async_read_tag()) {
      (1, _) => msg.cmd = reader |> @protobuf.async_read_string()
       (_, wire) => reader |> @protobuf.async_read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.AsyncWrite for Codegen_Process with write(self: Codegen_Process, writer : &@protobuf.AsyncWriter) -> Unit raise {
  writer |> @protobuf.async_write_varint(10UL);
  writer |> @protobuf.async_write_string(self.cmd)
}
pub(all) struct Codegen_WASM {
  mut url : String
  mut sha256 : String
} derive(Eq, Show)
pub impl @protobuf.Sized for Codegen_WASM with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @protobuf.size_of(self.url); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.sha256); @protobuf.size_of(size) + size }
  size
}
pub impl Default for Codegen_WASM with default() -> Codegen_WASM {
  Codegen_WASM::{
    url : String::default(),
    sha256 : String::default(),
  }
}
pub fn Codegen_WASM::new(url : String, sha256 : String) -> Codegen_WASM {
  Codegen_WASM::{
    url,
    sha256,
  }
}
pub impl @protobuf.Read for Codegen_WASM with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.Reader]) -> Codegen_WASM raise {
  let msg = Codegen_WASM::default()
  try {
    for {
      match (reader |> @protobuf.read_tag()) {
      (1, _) => msg.url = reader |> @protobuf.read_string()
      (2, _) => msg.sha256 = reader |> @protobuf.read_string()
       (_, wire) => reader |> @protobuf.read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.Write for Codegen_WASM with write(self: Codegen_WASM, writer : &@protobuf.Writer) -> Unit raise {
  writer |> @protobuf.write_varint(10UL);
  writer |> @protobuf.write_string(self.url)
  writer |> @protobuf.write_varint(18UL);
  writer |> @protobuf.write_string(self.sha256)
}
pub impl @protobuf.AsyncRead for Codegen_WASM with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.AsyncReader]) -> Codegen_WASM raise {
  let msg = Codegen_WASM::default()
  try {
    for {
      match (reader |> @protobuf.async_read_tag()) {
      (1, _) => msg.url = reader |> @protobuf.async_read_string()
      (2, _) => msg.sha256 = reader |> @protobuf.async_read_string()
       (_, wire) => reader |> @protobuf.async_read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.AsyncWrite for Codegen_WASM with write(self: Codegen_WASM, writer : &@protobuf.AsyncWriter) -> Unit raise {
  writer |> @protobuf.async_write_varint(10UL);
  writer |> @protobuf.async_write_string(self.url)
  writer |> @protobuf.async_write_varint(18UL);
  writer |> @protobuf.async_write_string(self.sha256)
}
pub(all) struct Codegen {
  mut out : String
  mut plugin : String
  mut options : Bytes
  mut env : Array[String]
  mut process :  Codegen_Process 
  mut wasm :  Codegen_WASM 
} derive(Eq, Show)
pub impl @protobuf.Sized for Codegen with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @protobuf.size_of(self.out); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.plugin); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.options); @protobuf.size_of(size) + size }
  size += self.env.iter().map(@protobuf.size_of).map(s => 1U + @protobuf.size_of(s) + s).fold(init=0U, UInt::op_add)
  size += 1U + { let size = @protobuf.size_of(self.process); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.wasm); @protobuf.size_of(size) + size }
  size
}
pub impl Default for Codegen with default() -> Codegen {
  Codegen::{
    out : String::default(),
    plugin : String::default(),
    options : Bytes::default(),
    env : [],
    process : Codegen_Process::default(),
    wasm : Codegen_WASM::default(),
  }
}
pub fn Codegen::new(out : String, plugin : String, options : Bytes, env : Array[String], process : Codegen_Process, wasm : Codegen_WASM) -> Codegen {
  Codegen::{
    out,
    plugin,
    options,
    env,
    process,
    wasm,
  }
}
pub impl @protobuf.Read for Codegen with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.Reader]) -> Codegen raise {
  let msg = Codegen::default()
  try {
    for {
      match (reader |> @protobuf.read_tag()) {
      (1, _) => msg.out = reader |> @protobuf.read_string()
      (2, _) => msg.plugin = reader |> @protobuf.read_string()
      (3, _) => msg.options = reader |> @protobuf.read_bytes()
      (4, _) => msg.env.push(reader |> @protobuf.read_string())
      (5, _) => msg.process = (reader |> @protobuf.read_message() : Codegen_Process)
      (6, _) => msg.wasm = (reader |> @protobuf.read_message() : Codegen_WASM)
       (_, wire) => reader |> @protobuf.read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.Write for Codegen with write(self: Codegen, writer : &@protobuf.Writer) -> Unit raise {
  writer |> @protobuf.write_varint(10UL);
  writer |> @protobuf.write_string(self.out)
  writer |> @protobuf.write_varint(18UL);
  writer |> @protobuf.write_string(self.plugin)
  writer |> @protobuf.write_varint(26UL);
  writer |> @protobuf.write_bytes(self.options)
  for item in self.env {
    writer |> @protobuf.write_varint(34UL)
    writer |> @protobuf.write_string(item)

  }
  writer |> @protobuf.write_varint(42UL);
  writer |> @protobuf.write_uint32(@protobuf.size_of(self.process)); @protobuf.Write::write(self.process, writer)
  writer |> @protobuf.write_varint(50UL);
  writer |> @protobuf.write_uint32(@protobuf.size_of(self.wasm)); @protobuf.Write::write(self.wasm, writer)
}
pub impl @protobuf.AsyncRead for Codegen with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.AsyncReader]) -> Codegen raise {
  let msg = Codegen::default()
  try {
    for {
      match (reader |> @protobuf.async_read_tag()) {
      (1, _) => msg.out = reader |> @protobuf.async_read_string()
      (2, _) => msg.plugin = reader |> @protobuf.async_read_string()
      (3, _) => msg.options = reader |> @protobuf.async_read_bytes()
      (4, _) => msg.env.push(reader |> @protobuf.async_read_string())
      (5, _) => msg.process = (reader |> @protobuf.async_read_message() : Codegen_Process)
      (6, _) => msg.wasm = (reader |> @protobuf.async_read_message() : Codegen_WASM)
       (_, wire) => reader |> @protobuf.async_read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.AsyncWrite for Codegen with write(self: Codegen, writer : &@protobuf.AsyncWriter) -> Unit raise {
  writer |> @protobuf.async_write_varint(10UL);
  writer |> @protobuf.async_write_string(self.out)
  writer |> @protobuf.async_write_varint(18UL);
  writer |> @protobuf.async_write_string(self.plugin)
  writer |> @protobuf.async_write_varint(26UL);
  writer |> @protobuf.async_write_bytes(self.options)
  for item in self.env {
    writer |> @protobuf.async_write_varint(34UL)
    writer |> @protobuf.async_write_string(item)

  }
  writer |> @protobuf.async_write_varint(42UL);
  writer |> @protobuf.async_write_uint32(@protobuf.size_of(self.process)); @protobuf.AsyncWrite::write(self.process, writer)
  writer |> @protobuf.async_write_varint(50UL);
  writer |> @protobuf.async_write_uint32(@protobuf.size_of(self.wasm)); @protobuf.AsyncWrite::write(self.wasm, writer)
}
pub(all) struct Catalog {
  mut comment : String
  mut default_schema : String
  mut name : String
  mut schemas : Array[Schema]
} derive(Eq, Show)
pub impl @protobuf.Sized for Catalog with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @protobuf.size_of(self.comment); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.default_schema); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.name); @protobuf.size_of(size) + size }
  size += self.schemas.iter().map(@protobuf.size_of).map(s => 1U + @protobuf.size_of(s) + s).fold(init=0U, UInt::op_add)
  size
}
pub impl Default for Catalog with default() -> Catalog {
  Catalog::{
    comment : String::default(),
    default_schema : String::default(),
    name : String::default(),
    schemas : [],
  }
}
pub fn Catalog::new(comment : String, default_schema : String, name : String, schemas : Array[Schema]) -> Catalog {
  Catalog::{
    comment,
    default_schema,
    name,
    schemas,
  }
}
pub impl @protobuf.Read for Catalog with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.Reader]) -> Catalog raise {
  let msg = Catalog::default()
  try {
    for {
      match (reader |> @protobuf.read_tag()) {
      (1, _) => msg.comment = reader |> @protobuf.read_string()
      (2, _) => msg.default_schema = reader |> @protobuf.read_string()
      (3, _) => msg.name = reader |> @protobuf.read_string()
      (4, _) => msg.schemas.push((reader |> @protobuf.read_message() : Schema))
       (_, wire) => reader |> @protobuf.read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.Write for Catalog with write(self: Catalog, writer : &@protobuf.Writer) -> Unit raise {
  writer |> @protobuf.write_varint(10UL);
  writer |> @protobuf.write_string(self.comment)
  writer |> @protobuf.write_varint(18UL);
  writer |> @protobuf.write_string(self.default_schema)
  writer |> @protobuf.write_varint(26UL);
  writer |> @protobuf.write_string(self.name)
  for item in self.schemas {
    writer |> @protobuf.write_varint(34UL)
    writer |> @protobuf.write_uint32(@protobuf.size_of(item)); @protobuf.Write::write(item, writer)

  }
}
pub impl @protobuf.AsyncRead for Catalog with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.AsyncReader]) -> Catalog raise {
  let msg = Catalog::default()
  try {
    for {
      match (reader |> @protobuf.async_read_tag()) {
      (1, _) => msg.comment = reader |> @protobuf.async_read_string()
      (2, _) => msg.default_schema = reader |> @protobuf.async_read_string()
      (3, _) => msg.name = reader |> @protobuf.async_read_string()
      (4, _) => msg.schemas.push((reader |> @protobuf.async_read_message() : Schema))
       (_, wire) => reader |> @protobuf.async_read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.AsyncWrite for Catalog with write(self: Catalog, writer : &@protobuf.AsyncWriter) -> Unit raise {
  writer |> @protobuf.async_write_varint(10UL);
  writer |> @protobuf.async_write_string(self.comment)
  writer |> @protobuf.async_write_varint(18UL);
  writer |> @protobuf.async_write_string(self.default_schema)
  writer |> @protobuf.async_write_varint(26UL);
  writer |> @protobuf.async_write_string(self.name)
  for item in self.schemas {
    writer |> @protobuf.async_write_varint(34UL)
    writer |> @protobuf.async_write_uint32(@protobuf.size_of(item)); @protobuf.AsyncWrite::write(item, writer)

  }
}
pub(all) struct Schema {
  mut comment : String
  mut name : String
  mut tables : Array[Table]
  mut enums : Array[Enum]
  mut composite_types : Array[CompositeType]
} derive(Eq, Show)
pub impl @protobuf.Sized for Schema with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @protobuf.size_of(self.comment); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.name); @protobuf.size_of(size) + size }
  size += self.tables.iter().map(@protobuf.size_of).map(s => 1U + @protobuf.size_of(s) + s).fold(init=0U, UInt::op_add)
  size += self.enums.iter().map(@protobuf.size_of).map(s => 1U + @protobuf.size_of(s) + s).fold(init=0U, UInt::op_add)
  size += self.composite_types.iter().map(@protobuf.size_of).map(s => 1U + @protobuf.size_of(s) + s).fold(init=0U, UInt::op_add)
  size
}
pub impl Default for Schema with default() -> Schema {
  Schema::{
    comment : String::default(),
    name : String::default(),
    tables : [],
    enums : [],
    composite_types : [],
  }
}
pub fn Schema::new(comment : String, name : String, tables : Array[Table], enums : Array[Enum], composite_types : Array[CompositeType]) -> Schema {
  Schema::{
    comment,
    name,
    tables,
    enums,
    composite_types,
  }
}
pub impl @protobuf.Read for Schema with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.Reader]) -> Schema raise {
  let msg = Schema::default()
  try {
    for {
      match (reader |> @protobuf.read_tag()) {
      (1, _) => msg.comment = reader |> @protobuf.read_string()
      (2, _) => msg.name = reader |> @protobuf.read_string()
      (3, _) => msg.tables.push((reader |> @protobuf.read_message() : Table))
      (4, _) => msg.enums.push((reader |> @protobuf.read_message() : Enum))
      (5, _) => msg.composite_types.push((reader |> @protobuf.read_message() : CompositeType))
       (_, wire) => reader |> @protobuf.read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.Write for Schema with write(self: Schema, writer : &@protobuf.Writer) -> Unit raise {
  writer |> @protobuf.write_varint(10UL);
  writer |> @protobuf.write_string(self.comment)
  writer |> @protobuf.write_varint(18UL);
  writer |> @protobuf.write_string(self.name)
  for item in self.tables {
    writer |> @protobuf.write_varint(26UL)
    writer |> @protobuf.write_uint32(@protobuf.size_of(item)); @protobuf.Write::write(item, writer)

  }
  for item in self.enums {
    writer |> @protobuf.write_varint(34UL)
    writer |> @protobuf.write_uint32(@protobuf.size_of(item)); @protobuf.Write::write(item, writer)

  }
  for item in self.composite_types {
    writer |> @protobuf.write_varint(42UL)
    writer |> @protobuf.write_uint32(@protobuf.size_of(item)); @protobuf.Write::write(item, writer)

  }
}
pub impl @protobuf.AsyncRead for Schema with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.AsyncReader]) -> Schema raise {
  let msg = Schema::default()
  try {
    for {
      match (reader |> @protobuf.async_read_tag()) {
      (1, _) => msg.comment = reader |> @protobuf.async_read_string()
      (2, _) => msg.name = reader |> @protobuf.async_read_string()
      (3, _) => msg.tables.push((reader |> @protobuf.async_read_message() : Table))
      (4, _) => msg.enums.push((reader |> @protobuf.async_read_message() : Enum))
      (5, _) => msg.composite_types.push((reader |> @protobuf.async_read_message() : CompositeType))
       (_, wire) => reader |> @protobuf.async_read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.AsyncWrite for Schema with write(self: Schema, writer : &@protobuf.AsyncWriter) -> Unit raise {
  writer |> @protobuf.async_write_varint(10UL);
  writer |> @protobuf.async_write_string(self.comment)
  writer |> @protobuf.async_write_varint(18UL);
  writer |> @protobuf.async_write_string(self.name)
  for item in self.tables {
    writer |> @protobuf.async_write_varint(26UL)
    writer |> @protobuf.async_write_uint32(@protobuf.size_of(item)); @protobuf.AsyncWrite::write(item, writer)

  }
  for item in self.enums {
    writer |> @protobuf.async_write_varint(34UL)
    writer |> @protobuf.async_write_uint32(@protobuf.size_of(item)); @protobuf.AsyncWrite::write(item, writer)

  }
  for item in self.composite_types {
    writer |> @protobuf.async_write_varint(42UL)
    writer |> @protobuf.async_write_uint32(@protobuf.size_of(item)); @protobuf.AsyncWrite::write(item, writer)

  }
}
pub(all) struct CompositeType {
  mut name : String
  mut comment : String
} derive(Eq, Show)
pub impl @protobuf.Sized for CompositeType with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @protobuf.size_of(self.name); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.comment); @protobuf.size_of(size) + size }
  size
}
pub impl Default for CompositeType with default() -> CompositeType {
  CompositeType::{
    name : String::default(),
    comment : String::default(),
  }
}
pub fn CompositeType::new(name : String, comment : String) -> CompositeType {
  CompositeType::{
    name,
    comment,
  }
}
pub impl @protobuf.Read for CompositeType with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.Reader]) -> CompositeType raise {
  let msg = CompositeType::default()
  try {
    for {
      match (reader |> @protobuf.read_tag()) {
      (1, _) => msg.name = reader |> @protobuf.read_string()
      (2, _) => msg.comment = reader |> @protobuf.read_string()
       (_, wire) => reader |> @protobuf.read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.Write for CompositeType with write(self: CompositeType, writer : &@protobuf.Writer) -> Unit raise {
  writer |> @protobuf.write_varint(10UL);
  writer |> @protobuf.write_string(self.name)
  writer |> @protobuf.write_varint(18UL);
  writer |> @protobuf.write_string(self.comment)
}
pub impl @protobuf.AsyncRead for CompositeType with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.AsyncReader]) -> CompositeType raise {
  let msg = CompositeType::default()
  try {
    for {
      match (reader |> @protobuf.async_read_tag()) {
      (1, _) => msg.name = reader |> @protobuf.async_read_string()
      (2, _) => msg.comment = reader |> @protobuf.async_read_string()
       (_, wire) => reader |> @protobuf.async_read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.AsyncWrite for CompositeType with write(self: CompositeType, writer : &@protobuf.AsyncWriter) -> Unit raise {
  writer |> @protobuf.async_write_varint(10UL);
  writer |> @protobuf.async_write_string(self.name)
  writer |> @protobuf.async_write_varint(18UL);
  writer |> @protobuf.async_write_string(self.comment)
}
pub(all) struct Enum {
  mut name : String
  mut vals : Array[String]
  mut comment : String
} derive(Eq, Show)
pub impl @protobuf.Sized for Enum with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @protobuf.size_of(self.name); @protobuf.size_of(size) + size }
  size += self.vals.iter().map(@protobuf.size_of).map(s => 1U + @protobuf.size_of(s) + s).fold(init=0U, UInt::op_add)
  size += 1U + { let size = @protobuf.size_of(self.comment); @protobuf.size_of(size) + size }
  size
}
pub impl Default for Enum with default() -> Enum {
  Enum::{
    name : String::default(),
    vals : [],
    comment : String::default(),
  }
}
pub fn Enum::new(name : String, vals : Array[String], comment : String) -> Enum {
  Enum::{
    name,
    vals,
    comment,
  }
}
pub impl @protobuf.Read for Enum with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.Reader]) -> Enum raise {
  let msg = Enum::default()
  try {
    for {
      match (reader |> @protobuf.read_tag()) {
      (1, _) => msg.name = reader |> @protobuf.read_string()
      (2, _) => msg.vals.push(reader |> @protobuf.read_string())
      (3, _) => msg.comment = reader |> @protobuf.read_string()
       (_, wire) => reader |> @protobuf.read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.Write for Enum with write(self: Enum, writer : &@protobuf.Writer) -> Unit raise {
  writer |> @protobuf.write_varint(10UL);
  writer |> @protobuf.write_string(self.name)
  for item in self.vals {
    writer |> @protobuf.write_varint(18UL)
    writer |> @protobuf.write_string(item)

  }
  writer |> @protobuf.write_varint(26UL);
  writer |> @protobuf.write_string(self.comment)
}
pub impl @protobuf.AsyncRead for Enum with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.AsyncReader]) -> Enum raise {
  let msg = Enum::default()
  try {
    for {
      match (reader |> @protobuf.async_read_tag()) {
      (1, _) => msg.name = reader |> @protobuf.async_read_string()
      (2, _) => msg.vals.push(reader |> @protobuf.async_read_string())
      (3, _) => msg.comment = reader |> @protobuf.async_read_string()
       (_, wire) => reader |> @protobuf.async_read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.AsyncWrite for Enum with write(self: Enum, writer : &@protobuf.AsyncWriter) -> Unit raise {
  writer |> @protobuf.async_write_varint(10UL);
  writer |> @protobuf.async_write_string(self.name)
  for item in self.vals {
    writer |> @protobuf.async_write_varint(18UL)
    writer |> @protobuf.async_write_string(item)

  }
  writer |> @protobuf.async_write_varint(26UL);
  writer |> @protobuf.async_write_string(self.comment)
}
pub(all) struct Table {
  mut rel :  Identifier 
  mut columns : Array[Column]
  mut comment : String
} derive(Eq, Show)
pub impl @protobuf.Sized for Table with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @protobuf.size_of(self.rel); @protobuf.size_of(size) + size }
  size += self.columns.iter().map(@protobuf.size_of).map(s => 1U + @protobuf.size_of(s) + s).fold(init=0U, UInt::op_add)
  size += 1U + { let size = @protobuf.size_of(self.comment); @protobuf.size_of(size) + size }
  size
}
pub impl Default for Table with default() -> Table {
  Table::{
    rel : Identifier::default(),
    columns : [],
    comment : String::default(),
  }
}
pub fn Table::new(rel : Identifier, columns : Array[Column], comment : String) -> Table {
  Table::{
    rel,
    columns,
    comment,
  }
}
pub impl @protobuf.Read for Table with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.Reader]) -> Table raise {
  let msg = Table::default()
  try {
    for {
      match (reader |> @protobuf.read_tag()) {
      (1, _) => msg.rel = (reader |> @protobuf.read_message() : Identifier)
      (2, _) => msg.columns.push((reader |> @protobuf.read_message() : Column))
      (3, _) => msg.comment = reader |> @protobuf.read_string()
       (_, wire) => reader |> @protobuf.read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.Write for Table with write(self: Table, writer : &@protobuf.Writer) -> Unit raise {
  writer |> @protobuf.write_varint(10UL);
  writer |> @protobuf.write_uint32(@protobuf.size_of(self.rel)); @protobuf.Write::write(self.rel, writer)
  for item in self.columns {
    writer |> @protobuf.write_varint(18UL)
    writer |> @protobuf.write_uint32(@protobuf.size_of(item)); @protobuf.Write::write(item, writer)

  }
  writer |> @protobuf.write_varint(26UL);
  writer |> @protobuf.write_string(self.comment)
}
pub impl @protobuf.AsyncRead for Table with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.AsyncReader]) -> Table raise {
  let msg = Table::default()
  try {
    for {
      match (reader |> @protobuf.async_read_tag()) {
      (1, _) => msg.rel = (reader |> @protobuf.async_read_message() : Identifier)
      (2, _) => msg.columns.push((reader |> @protobuf.async_read_message() : Column))
      (3, _) => msg.comment = reader |> @protobuf.async_read_string()
       (_, wire) => reader |> @protobuf.async_read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.AsyncWrite for Table with write(self: Table, writer : &@protobuf.AsyncWriter) -> Unit raise {
  writer |> @protobuf.async_write_varint(10UL);
  writer |> @protobuf.async_write_uint32(@protobuf.size_of(self.rel)); @protobuf.AsyncWrite::write(self.rel, writer)
  for item in self.columns {
    writer |> @protobuf.async_write_varint(18UL)
    writer |> @protobuf.async_write_uint32(@protobuf.size_of(item)); @protobuf.AsyncWrite::write(item, writer)

  }
  writer |> @protobuf.async_write_varint(26UL);
  writer |> @protobuf.async_write_string(self.comment)
}
pub(all) struct Identifier {
  mut catalog : String
  mut schema : String
  mut name : String
} derive(Eq, Show)
pub impl @protobuf.Sized for Identifier with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @protobuf.size_of(self.catalog); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.schema); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.name); @protobuf.size_of(size) + size }
  size
}
pub impl Default for Identifier with default() -> Identifier {
  Identifier::{
    catalog : String::default(),
    schema : String::default(),
    name : String::default(),
  }
}
pub fn Identifier::new(catalog : String, schema : String, name : String) -> Identifier {
  Identifier::{
    catalog,
    schema,
    name,
  }
}
pub impl @protobuf.Read for Identifier with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.Reader]) -> Identifier raise {
  let msg = Identifier::default()
  try {
    for {
      match (reader |> @protobuf.read_tag()) {
      (1, _) => msg.catalog = reader |> @protobuf.read_string()
      (2, _) => msg.schema = reader |> @protobuf.read_string()
      (3, _) => msg.name = reader |> @protobuf.read_string()
       (_, wire) => reader |> @protobuf.read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.Write for Identifier with write(self: Identifier, writer : &@protobuf.Writer) -> Unit raise {
  writer |> @protobuf.write_varint(10UL);
  writer |> @protobuf.write_string(self.catalog)
  writer |> @protobuf.write_varint(18UL);
  writer |> @protobuf.write_string(self.schema)
  writer |> @protobuf.write_varint(26UL);
  writer |> @protobuf.write_string(self.name)
}
pub impl @protobuf.AsyncRead for Identifier with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.AsyncReader]) -> Identifier raise {
  let msg = Identifier::default()
  try {
    for {
      match (reader |> @protobuf.async_read_tag()) {
      (1, _) => msg.catalog = reader |> @protobuf.async_read_string()
      (2, _) => msg.schema = reader |> @protobuf.async_read_string()
      (3, _) => msg.name = reader |> @protobuf.async_read_string()
       (_, wire) => reader |> @protobuf.async_read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.AsyncWrite for Identifier with write(self: Identifier, writer : &@protobuf.AsyncWriter) -> Unit raise {
  writer |> @protobuf.async_write_varint(10UL);
  writer |> @protobuf.async_write_string(self.catalog)
  writer |> @protobuf.async_write_varint(18UL);
  writer |> @protobuf.async_write_string(self.schema)
  writer |> @protobuf.async_write_varint(26UL);
  writer |> @protobuf.async_write_string(self.name)
}
pub(all) struct Column {
  mut name : String
  mut not_null : Bool
  mut is_array : Bool
  mut comment : String
  mut length : Int
  mut is_named_param : Bool
  mut is_func_call : Bool
  mut scope : String
  mut table :  Identifier 
  mut table_alias : String
  mut type_ :  Identifier 
  mut is_sqlc_slice : Bool
  mut embed_table :  Identifier 
  mut original_name : String
  mut unsigned : Bool
  mut array_dims : Int
} derive(Eq, Show)
pub impl @protobuf.Sized for Column with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @protobuf.size_of(self.name); @protobuf.size_of(size) + size }
  size += 1U + @protobuf.size_of(self.not_null)
  size += 1U + @protobuf.size_of(self.is_array)
  size += 1U + { let size = @protobuf.size_of(self.comment); @protobuf.size_of(size) + size }
  size += 1U + @protobuf.size_of(self.length)
  size += 1U + @protobuf.size_of(self.is_named_param)
  size += 1U + @protobuf.size_of(self.is_func_call)
  size += 1U + { let size = @protobuf.size_of(self.scope); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.table); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.table_alias); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.type_); @protobuf.size_of(size) + size }
  size += 1U + @protobuf.size_of(self.is_sqlc_slice)
  size += 1U + { let size = @protobuf.size_of(self.embed_table); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.original_name); @protobuf.size_of(size) + size }
  size += 2U + @protobuf.size_of(self.unsigned)
  size += 2U + @protobuf.size_of(self.array_dims)
  size
}
pub impl Default for Column with default() -> Column {
  Column::{
    name : String::default(),
    not_null : Bool::default(),
    is_array : Bool::default(),
    comment : String::default(),
    length : Int::default(),
    is_named_param : Bool::default(),
    is_func_call : Bool::default(),
    scope : String::default(),
    table : Identifier::default(),
    table_alias : String::default(),
    type_ : Identifier::default(),
    is_sqlc_slice : Bool::default(),
    embed_table : Identifier::default(),
    original_name : String::default(),
    unsigned : Bool::default(),
    array_dims : Int::default(),
  }
}
pub fn Column::new(name : String, not_null : Bool, is_array : Bool, comment : String, length : Int, is_named_param : Bool, is_func_call : Bool, scope : String, table : Identifier, table_alias : String, type_ : Identifier, is_sqlc_slice : Bool, embed_table : Identifier, original_name : String, unsigned : Bool, array_dims : Int) -> Column {
  Column::{
    name,
    not_null,
    is_array,
    comment,
    length,
    is_named_param,
    is_func_call,
    scope,
    table,
    table_alias,
    type_,
    is_sqlc_slice,
    embed_table,
    original_name,
    unsigned,
    array_dims,
  }
}
pub impl @protobuf.Read for Column with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.Reader]) -> Column raise {
  let msg = Column::default()
  try {
    for {
      match (reader |> @protobuf.read_tag()) {
      (1, _) => msg.name = reader |> @protobuf.read_string()
      (3, _) => msg.not_null = reader |> @protobuf.read_bool()
      (4, _) => msg.is_array = reader |> @protobuf.read_bool()
      (5, _) => msg.comment = reader |> @protobuf.read_string()
      (6, _) => msg.length = reader |> @protobuf.read_int32()
      (7, _) => msg.is_named_param = reader |> @protobuf.read_bool()
      (8, _) => msg.is_func_call = reader |> @protobuf.read_bool()
      (9, _) => msg.scope = reader |> @protobuf.read_string()
      (10, _) => msg.table = (reader |> @protobuf.read_message() : Identifier)
      (11, _) => msg.table_alias = reader |> @protobuf.read_string()
      (12, _) => msg.type_ = (reader |> @protobuf.read_message() : Identifier)
      (13, _) => msg.is_sqlc_slice = reader |> @protobuf.read_bool()
      (14, _) => msg.embed_table = (reader |> @protobuf.read_message() : Identifier)
      (15, _) => msg.original_name = reader |> @protobuf.read_string()
      (16, _) => msg.unsigned = reader |> @protobuf.read_bool()
      (17, _) => msg.array_dims = reader |> @protobuf.read_int32()
       (_, wire) => reader |> @protobuf.read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.Write for Column with write(self: Column, writer : &@protobuf.Writer) -> Unit raise {
  writer |> @protobuf.write_varint(10UL);
  writer |> @protobuf.write_string(self.name)
  writer |> @protobuf.write_varint(24UL);
  writer |> @protobuf.write_bool(self.not_null)
  writer |> @protobuf.write_varint(32UL);
  writer |> @protobuf.write_bool(self.is_array)
  writer |> @protobuf.write_varint(42UL);
  writer |> @protobuf.write_string(self.comment)
  writer |> @protobuf.write_varint(48UL);
  writer |> @protobuf.write_int32(self.length)
  writer |> @protobuf.write_varint(56UL);
  writer |> @protobuf.write_bool(self.is_named_param)
  writer |> @protobuf.write_varint(64UL);
  writer |> @protobuf.write_bool(self.is_func_call)
  writer |> @protobuf.write_varint(74UL);
  writer |> @protobuf.write_string(self.scope)
  writer |> @protobuf.write_varint(82UL);
  writer |> @protobuf.write_uint32(@protobuf.size_of(self.table)); @protobuf.Write::write(self.table, writer)
  writer |> @protobuf.write_varint(90UL);
  writer |> @protobuf.write_string(self.table_alias)
  writer |> @protobuf.write_varint(98UL);
  writer |> @protobuf.write_uint32(@protobuf.size_of(self.type_)); @protobuf.Write::write(self.type_, writer)
  writer |> @protobuf.write_varint(104UL);
  writer |> @protobuf.write_bool(self.is_sqlc_slice)
  writer |> @protobuf.write_varint(114UL);
  writer |> @protobuf.write_uint32(@protobuf.size_of(self.embed_table)); @protobuf.Write::write(self.embed_table, writer)
  writer |> @protobuf.write_varint(122UL);
  writer |> @protobuf.write_string(self.original_name)
  writer |> @protobuf.write_varint(128UL);
  writer |> @protobuf.write_bool(self.unsigned)
  writer |> @protobuf.write_varint(136UL);
  writer |> @protobuf.write_int32(self.array_dims)
}
pub impl @protobuf.AsyncRead for Column with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.AsyncReader]) -> Column raise {
  let msg = Column::default()
  try {
    for {
      match (reader |> @protobuf.async_read_tag()) {
      (1, _) => msg.name = reader |> @protobuf.async_read_string()
      (3, _) => msg.not_null = reader |> @protobuf.async_read_bool()
      (4, _) => msg.is_array = reader |> @protobuf.async_read_bool()
      (5, _) => msg.comment = reader |> @protobuf.async_read_string()
      (6, _) => msg.length = reader |> @protobuf.async_read_int32()
      (7, _) => msg.is_named_param = reader |> @protobuf.async_read_bool()
      (8, _) => msg.is_func_call = reader |> @protobuf.async_read_bool()
      (9, _) => msg.scope = reader |> @protobuf.async_read_string()
      (10, _) => msg.table = (reader |> @protobuf.async_read_message() : Identifier)
      (11, _) => msg.table_alias = reader |> @protobuf.async_read_string()
      (12, _) => msg.type_ = (reader |> @protobuf.async_read_message() : Identifier)
      (13, _) => msg.is_sqlc_slice = reader |> @protobuf.async_read_bool()
      (14, _) => msg.embed_table = (reader |> @protobuf.async_read_message() : Identifier)
      (15, _) => msg.original_name = reader |> @protobuf.async_read_string()
      (16, _) => msg.unsigned = reader |> @protobuf.async_read_bool()
      (17, _) => msg.array_dims = reader |> @protobuf.async_read_int32()
       (_, wire) => reader |> @protobuf.async_read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.AsyncWrite for Column with write(self: Column, writer : &@protobuf.AsyncWriter) -> Unit raise {
  writer |> @protobuf.async_write_varint(10UL);
  writer |> @protobuf.async_write_string(self.name)
  writer |> @protobuf.async_write_varint(24UL);
  writer |> @protobuf.async_write_bool(self.not_null)
  writer |> @protobuf.async_write_varint(32UL);
  writer |> @protobuf.async_write_bool(self.is_array)
  writer |> @protobuf.async_write_varint(42UL);
  writer |> @protobuf.async_write_string(self.comment)
  writer |> @protobuf.async_write_varint(48UL);
  writer |> @protobuf.async_write_int32(self.length)
  writer |> @protobuf.async_write_varint(56UL);
  writer |> @protobuf.async_write_bool(self.is_named_param)
  writer |> @protobuf.async_write_varint(64UL);
  writer |> @protobuf.async_write_bool(self.is_func_call)
  writer |> @protobuf.async_write_varint(74UL);
  writer |> @protobuf.async_write_string(self.scope)
  writer |> @protobuf.async_write_varint(82UL);
  writer |> @protobuf.async_write_uint32(@protobuf.size_of(self.table)); @protobuf.AsyncWrite::write(self.table, writer)
  writer |> @protobuf.async_write_varint(90UL);
  writer |> @protobuf.async_write_string(self.table_alias)
  writer |> @protobuf.async_write_varint(98UL);
  writer |> @protobuf.async_write_uint32(@protobuf.size_of(self.type_)); @protobuf.AsyncWrite::write(self.type_, writer)
  writer |> @protobuf.async_write_varint(104UL);
  writer |> @protobuf.async_write_bool(self.is_sqlc_slice)
  writer |> @protobuf.async_write_varint(114UL);
  writer |> @protobuf.async_write_uint32(@protobuf.size_of(self.embed_table)); @protobuf.AsyncWrite::write(self.embed_table, writer)
  writer |> @protobuf.async_write_varint(122UL);
  writer |> @protobuf.async_write_string(self.original_name)
  writer |> @protobuf.async_write_varint(128UL);
  writer |> @protobuf.async_write_bool(self.unsigned)
  writer |> @protobuf.async_write_varint(136UL);
  writer |> @protobuf.async_write_int32(self.array_dims)
}
pub(all) struct Query {
  mut text : String
  mut name : String
  mut cmd : String
  mut columns : Array[Column]
  mut params : Array[Parameter]
  mut comments : Array[String]
  mut filename : String
  mut insert_into_table :  Identifier 
} derive(Eq, Show)
pub impl @protobuf.Sized for Query with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @protobuf.size_of(self.text); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.name); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.cmd); @protobuf.size_of(size) + size }
  size += self.columns.iter().map(@protobuf.size_of).map(s => 1U + @protobuf.size_of(s) + s).fold(init=0U, UInt::op_add)
  size += self.parameters.iter().map(@protobuf.size_of).map(s => 1U + @protobuf.size_of(s) + s).fold(init=0U, UInt::op_add)
  size += self.comments.iter().map(@protobuf.size_of).map(s => 1U + @protobuf.size_of(s) + s).fold(init=0U, UInt::op_add)
  size += 1U + { let size = @protobuf.size_of(self.filename); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.insert_into_table); @protobuf.size_of(size) + size }
  size
}
pub impl Default for Query with default() -> Query {
  Query::{
    text : String::default(),
    name : String::default(),
    cmd : String::default(),
    columns : [],
    params : [],
    comments : [],
    filename : String::default(),
    insert_into_table : Identifier::default(),
  }
}
pub fn Query::new(text : String, name : String, cmd : String, columns : Array[Column], params : Array[Parameter], comments : Array[String], filename : String, insert_into_table : Identifier) -> Query {
  Query::{
    text,
    name,
    cmd,
    columns,
    params,
    comments,
    filename,
    insert_into_table,
  }
}
pub impl @protobuf.Read for Query with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.Reader]) -> Query raise {
  let msg = Query::default()
  try {
    for {
      match (reader |> @protobuf.read_tag()) {
      (1, _) => msg.text = reader |> @protobuf.read_string()
      (2, _) => msg.name = reader |> @protobuf.read_string()
      (3, _) => msg.cmd = reader |> @protobuf.read_string()
      (4, _) => msg.columns.push((reader |> @protobuf.read_message() : Column))
      (5, _) => msg.params.push((reader |> @protobuf.read_message() : Parameter))
      (6, _) => msg.comments.push(reader |> @protobuf.read_string())
      (7, _) => msg.filename = reader |> @protobuf.read_string()
      (8, _) => msg.insert_into_table = (reader |> @protobuf.read_message() : Identifier)
       (_, wire) => reader |> @protobuf.read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.Write for Query with write(self: Query, writer : &@protobuf.Writer) -> Unit raise {
  writer |> @protobuf.write_varint(10UL);
  writer |> @protobuf.write_string(self.text)
  writer |> @protobuf.write_varint(18UL);
  writer |> @protobuf.write_string(self.name)
  writer |> @protobuf.write_varint(26UL);
  writer |> @protobuf.write_string(self.cmd)
  for item in self.columns {
    writer |> @protobuf.write_varint(34UL)
    writer |> @protobuf.write_uint32(@protobuf.size_of(item)); @protobuf.Write::write(item, writer)

  }
  for item in self.params {
    writer |> @protobuf.write_varint(42UL)
    writer |> @protobuf.write_uint32(@protobuf.size_of(item)); @protobuf.Write::write(item, writer)

  }
  for item in self.comments {
    writer |> @protobuf.write_varint(50UL)
    writer |> @protobuf.write_string(item)

  }
  writer |> @protobuf.write_varint(58UL);
  writer |> @protobuf.write_string(self.filename)
  writer |> @protobuf.write_varint(66UL);
  writer |> @protobuf.write_uint32(@protobuf.size_of(self.insert_into_table)); @protobuf.Write::write(self.insert_into_table, writer)
}
pub impl @protobuf.AsyncRead for Query with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.AsyncReader]) -> Query raise {
  let msg = Query::default()
  try {
    for {
      match (reader |> @protobuf.async_read_tag()) {
      (1, _) => msg.text = reader |> @protobuf.async_read_string()
      (2, _) => msg.name = reader |> @protobuf.async_read_string()
      (3, _) => msg.cmd = reader |> @protobuf.async_read_string()
      (4, _) => msg.columns.push((reader |> @protobuf.async_read_message() : Column))
      (5, _) => msg.params.push((reader |> @protobuf.async_read_message() : Parameter))
      (6, _) => msg.comments.push(reader |> @protobuf.async_read_string())
      (7, _) => msg.filename = reader |> @protobuf.async_read_string()
      (8, _) => msg.insert_into_table = (reader |> @protobuf.async_read_message() : Identifier)
       (_, wire) => reader |> @protobuf.async_read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.AsyncWrite for Query with write(self: Query, writer : &@protobuf.AsyncWriter) -> Unit raise {
  writer |> @protobuf.async_write_varint(10UL);
  writer |> @protobuf.async_write_string(self.text)
  writer |> @protobuf.async_write_varint(18UL);
  writer |> @protobuf.async_write_string(self.name)
  writer |> @protobuf.async_write_varint(26UL);
  writer |> @protobuf.async_write_string(self.cmd)
  for item in self.columns {
    writer |> @protobuf.async_write_varint(34UL)
    writer |> @protobuf.async_write_uint32(@protobuf.size_of(item)); @protobuf.AsyncWrite::write(item, writer)

  }
  for item in self.params {
    writer |> @protobuf.async_write_varint(42UL)
    writer |> @protobuf.async_write_uint32(@protobuf.size_of(item)); @protobuf.AsyncWrite::write(item, writer)

  }
  for item in self.comments {
    writer |> @protobuf.async_write_varint(50UL)
    writer |> @protobuf.async_write_string(item)

  }
  writer |> @protobuf.async_write_varint(58UL);
  writer |> @protobuf.async_write_string(self.filename)
  writer |> @protobuf.async_write_varint(66UL);
  writer |> @protobuf.async_write_uint32(@protobuf.size_of(self.insert_into_table)); @protobuf.AsyncWrite::write(self.insert_into_table, writer)
}
pub(all) struct Parameter {
  mut number : Int
  mut column :  Column 
} derive(Eq, Show)
pub impl @protobuf.Sized for Parameter with size_of(self) {
  let mut size = 0U
  size += 1U + @protobuf.size_of(self.number)
  size += 1U + { let size = @protobuf.size_of(self.column); @protobuf.size_of(size) + size }
  size
}
pub impl Default for Parameter with default() -> Parameter {
  Parameter::{
    number : Int::default(),
    column : Column::default(),
  }
}
pub fn Parameter::new(number : Int, column : Column) -> Parameter {
  Parameter::{
    number,
    column,
  }
}
pub impl @protobuf.Read for Parameter with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.Reader]) -> Parameter raise {
  let msg = Parameter::default()
  try {
    for {
      match (reader |> @protobuf.read_tag()) {
      (1, _) => msg.number = reader |> @protobuf.read_int32()
      (2, _) => msg.column = (reader |> @protobuf.read_message() : Column)
       (_, wire) => reader |> @protobuf.read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.Write for Parameter with write(self: Parameter, writer : &@protobuf.Writer) -> Unit raise {
  writer |> @protobuf.write_varint(8UL);
  writer |> @protobuf.write_int32(self.number)
  writer |> @protobuf.write_varint(18UL);
  writer |> @protobuf.write_uint32(@protobuf.size_of(self.column)); @protobuf.Write::write(self.column, writer)
}
pub impl @protobuf.AsyncRead for Parameter with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.AsyncReader]) -> Parameter raise {
  let msg = Parameter::default()
  try {
    for {
      match (reader |> @protobuf.async_read_tag()) {
      (1, _) => msg.number = reader |> @protobuf.async_read_int32()
      (2, _) => msg.column = (reader |> @protobuf.async_read_message() : Column)
       (_, wire) => reader |> @protobuf.async_read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.AsyncWrite for Parameter with write(self: Parameter, writer : &@protobuf.AsyncWriter) -> Unit raise {
  writer |> @protobuf.async_write_varint(8UL);
  writer |> @protobuf.async_write_int32(self.number)
  writer |> @protobuf.async_write_varint(18UL);
  writer |> @protobuf.async_write_uint32(@protobuf.size_of(self.column)); @protobuf.AsyncWrite::write(self.column, writer)
}
pub(all) struct GenerateRequest {
  mut settings :  Settings 
  mut catalog :  Catalog 
  mut queries : Array[Query]
  mut sqlc_version : String
  mut plugin_options : Bytes
  mut global_options : Bytes
} derive(Eq, Show)
pub impl @protobuf.Sized for GenerateRequest with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @protobuf.size_of(self.settings); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.catalog); @protobuf.size_of(size) + size }
  size += self.queries.iter().map(@protobuf.size_of).map(s => 1U + @protobuf.size_of(s) + s).fold(init=0U, UInt::op_add)
  size += 1U + { let size = @protobuf.size_of(self.sqlc_version); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.plugin_options); @protobuf.size_of(size) + size }
  size += 1U + { let size = @protobuf.size_of(self.global_options); @protobuf.size_of(size) + size }
  size
}
pub impl Default for GenerateRequest with default() -> GenerateRequest {
  GenerateRequest::{
    settings : Settings::default(),
    catalog : Catalog::default(),
    queries : [],
    sqlc_version : String::default(),
    plugin_options : Bytes::default(),
    global_options : Bytes::default(),
  }
}
pub fn GenerateRequest::new(settings : Settings, catalog : Catalog, queries : Array[Query], sqlc_version : String, plugin_options : Bytes, global_options : Bytes) -> GenerateRequest {
  GenerateRequest::{
    settings,
    catalog,
    queries,
    sqlc_version,
    plugin_options,
    global_options,
  }
}
pub impl @protobuf.Read for GenerateRequest with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.Reader]) -> GenerateRequest raise {
  let msg = GenerateRequest::default()
  try {
    for {
      match (reader |> @protobuf.read_tag()) {
      (1, _) => msg.settings = (reader |> @protobuf.read_message() : Settings)
      (2, _) => msg.catalog = (reader |> @protobuf.read_message() : Catalog)
      (3, _) => msg.queries.push((reader |> @protobuf.read_message() : Query))
      (4, _) => msg.sqlc_version = reader |> @protobuf.read_string()
      (5, _) => msg.plugin_options = reader |> @protobuf.read_bytes()
      (6, _) => msg.global_options = reader |> @protobuf.read_bytes()
       (_, wire) => reader |> @protobuf.read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.Write for GenerateRequest with write(self: GenerateRequest, writer : &@protobuf.Writer) -> Unit raise {
  writer |> @protobuf.write_varint(10UL);
  writer |> @protobuf.write_uint32(@protobuf.size_of(self.settings)); @protobuf.Write::write(self.settings, writer)
  writer |> @protobuf.write_varint(18UL);
  writer |> @protobuf.write_uint32(@protobuf.size_of(self.catalog)); @protobuf.Write::write(self.catalog, writer)
  for item in self.queries {
    writer |> @protobuf.write_varint(26UL)
    writer |> @protobuf.write_uint32(@protobuf.size_of(item)); @protobuf.Write::write(item, writer)

  }
  writer |> @protobuf.write_varint(34UL);
  writer |> @protobuf.write_string(self.sqlc_version)
  writer |> @protobuf.write_varint(42UL);
  writer |> @protobuf.write_bytes(self.plugin_options)
  writer |> @protobuf.write_varint(50UL);
  writer |> @protobuf.write_bytes(self.global_options)
}
pub impl @protobuf.AsyncRead for GenerateRequest with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.AsyncReader]) -> GenerateRequest raise {
  let msg = GenerateRequest::default()
  try {
    for {
      match (reader |> @protobuf.async_read_tag()) {
      (1, _) => msg.settings = (reader |> @protobuf.async_read_message() : Settings)
      (2, _) => msg.catalog = (reader |> @protobuf.async_read_message() : Catalog)
      (3, _) => msg.queries.push((reader |> @protobuf.async_read_message() : Query))
      (4, _) => msg.sqlc_version = reader |> @protobuf.async_read_string()
      (5, _) => msg.plugin_options = reader |> @protobuf.async_read_bytes()
      (6, _) => msg.global_options = reader |> @protobuf.async_read_bytes()
       (_, wire) => reader |> @protobuf.async_read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.AsyncWrite for GenerateRequest with write(self: GenerateRequest, writer : &@protobuf.AsyncWriter) -> Unit raise {
  writer |> @protobuf.async_write_varint(10UL);
  writer |> @protobuf.async_write_uint32(@protobuf.size_of(self.settings)); @protobuf.AsyncWrite::write(self.settings, writer)
  writer |> @protobuf.async_write_varint(18UL);
  writer |> @protobuf.async_write_uint32(@protobuf.size_of(self.catalog)); @protobuf.AsyncWrite::write(self.catalog, writer)
  for item in self.queries {
    writer |> @protobuf.async_write_varint(26UL)
    writer |> @protobuf.async_write_uint32(@protobuf.size_of(item)); @protobuf.AsyncWrite::write(item, writer)

  }
  writer |> @protobuf.async_write_varint(34UL);
  writer |> @protobuf.async_write_string(self.sqlc_version)
  writer |> @protobuf.async_write_varint(42UL);
  writer |> @protobuf.async_write_bytes(self.plugin_options)
  writer |> @protobuf.async_write_varint(50UL);
  writer |> @protobuf.async_write_bytes(self.global_options)
}
pub(all) struct GenerateResponse {
  mut files : Array[File]
} derive(Eq, Show)
pub impl @protobuf.Sized for GenerateResponse with size_of(self) {
  let mut size = 0U
  size += self.files.iter().map(@protobuf.size_of).map(s => 1U + @protobuf.size_of(s) + s).fold(init=0U, UInt::op_add)
  size
}
pub impl Default for GenerateResponse with default() -> GenerateResponse {
  GenerateResponse::{
    files : [],
  }
}
pub fn GenerateResponse::new(files : Array[File]) -> GenerateResponse {
  GenerateResponse::{
    files,
  }
}
pub impl @protobuf.Read for GenerateResponse with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.Reader]) -> GenerateResponse raise {
  let msg = GenerateResponse::default()
  try {
    for {
      match (reader |> @protobuf.read_tag()) {
      (1, _) => msg.files.push((reader |> @protobuf.read_message() : File))
       (_, wire) => reader |> @protobuf.read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.Write for GenerateResponse with write(self: GenerateResponse, writer : &@protobuf.Writer) -> Unit raise {
  for item in self.files {
    writer |> @protobuf.write_varint(10UL)
    writer |> @protobuf.write_uint32(@protobuf.size_of(item)); @protobuf.Write::write(item, writer)

  }
}
pub impl @protobuf.AsyncRead for GenerateResponse with read_with_limit(reader : @protobuf.LimitedReader[&@protobuf.AsyncReader]) -> GenerateResponse raise {
  let msg = GenerateResponse::default()
  try {
    for {
      match (reader |> @protobuf.async_read_tag()) {
      (1, _) => msg.files.push((reader |> @protobuf.async_read_message() : File))
       (_, wire) => reader |> @protobuf.async_read_unknown(wire)
      }
    }
  } catch {
    @protobuf.EndOfStream => ()
    err => raise err
  }
  msg
}
pub impl @protobuf.AsyncWrite for GenerateResponse with write(self: GenerateResponse, writer : &@protobuf.AsyncWriter) -> Unit raise {
  for item in self.files {
    writer |> @protobuf.async_write_varint(10UL)
    writer |> @protobuf.async_write_uint32(@protobuf.size_of(item)); @protobuf.AsyncWrite::write(item, writer)

  }
}
