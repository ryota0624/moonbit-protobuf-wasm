// Code generated from codegen.proto by protoc-gen-mbt. DO NOT EDIT.

pub(all) struct File {
  mut name : String
  mut contents : Bytes
} derive(Default, Eq, Show)
impl @lib.Sized for File with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @lib.size_of(self.name); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.contents); @lib.size_of(size) + size }
  size
}
pub impl @lib.Read for File with read(reader : &@lib.Reader) {
	let msg =   File::default()
  while not(reader |> @lib.is_eof()) {
    match (reader |> @lib.read_tag!()) {
      (1, _) => msg.name = reader |> @lib.read_string!()
      (2, _) => msg.contents = reader |> @lib.read_bytes!()
      (_, wire) => reader |> @lib.read_unknown!(wire)
    }
  }
  msg
}
pub impl @lib.Write for File with write(self, writer) {
  writer |> @lib.write_varint(10UL);writer |> @lib.write_string(self.name)
  writer |> @lib.write_varint(18UL);writer |> @lib.write_bytes(self.contents)
}
pub(all) struct Settings {
  mut version : String
  mut engine : String
  mut schema : Array[String]
  mut queries : Array[String]
  mut codegen : Codegen
} derive(Default, Eq, Show)
impl @lib.Sized for Settings with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @lib.size_of(self.version); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.engine); @lib.size_of(size) + size }
  size += self.schema.iter().map(@lib.size_of).map(fn { s => 1U + @lib.size_of(s) + s }).fold(init=0U, UInt::op_add)
  size += self.queries.iter().map(@lib.size_of).map(fn { s => 1U + @lib.size_of(s) + s }).fold(init=0U, UInt::op_add)
  size += 1U + { let size = @lib.size_of(self.codegen); @lib.size_of(size) + size }
  size
}
pub impl @lib.Read for Settings with read(reader : &@lib.Reader) {
	let msg =   Settings::default()
  while not(reader |> @lib.is_eof()) {
    match (reader |> @lib.read_tag!()) {
      (1, _) => msg.version = reader |> @lib.read_string!()
      (2, _) => msg.engine = reader |> @lib.read_string!()
      (3, _) => msg.schema.push(reader |> @lib.read_string!())
      (4, _) => msg.queries.push(reader |> @lib.read_string!())
      (12, _) => msg.codegen = ((reader |> @lib.read_message!()) : Codegen)
      (_, wire) => reader |> @lib.read_unknown!(wire)
    }
  }
  msg
}
pub impl @lib.Write for Settings with write(self, writer) {
  writer |> @lib.write_varint(10UL);writer |> @lib.write_string(self.version)
  writer |> @lib.write_varint(18UL);writer |> @lib.write_string(self.engine)
  self.schema.iter().each(fn(v) {
    writer |> @lib.write_varint(26UL)
    writer |> @lib.write_string(v)
  })
  self.queries.iter().each(fn(v) {
    writer |> @lib.write_varint(34UL)
    writer |> @lib.write_string(v)
  })
  writer |> @lib.write_varint(98UL);writer |> @lib.write_uint32(@lib.size_of(self.codegen)); @lib.Write::write(self.codegen, writer)
}
pub(all) struct Codegen_Process {
  mut cmd : String
} derive(Default, Eq, Show)
impl @lib.Sized for Codegen_Process with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @lib.size_of(self.cmd); @lib.size_of(size) + size }
  size
}
pub impl @lib.Read for Codegen_Process with read(reader : &@lib.Reader) {
	let msg =   Codegen_Process::default()
  while not(reader |> @lib.is_eof()) {
    match (reader |> @lib.read_tag!()) {
      (1, _) => msg.cmd = reader |> @lib.read_string!()
      (_, wire) => reader |> @lib.read_unknown!(wire)
    }
  }
  msg
}
pub impl @lib.Write for Codegen_Process with write(self, writer) {
  writer |> @lib.write_varint(10UL);writer |> @lib.write_string(self.cmd)
}
pub(all) struct Codegen_WASM {
  mut url : String
  mut sha256 : String
} derive(Default, Eq, Show)
impl @lib.Sized for Codegen_WASM with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @lib.size_of(self.url); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.sha256); @lib.size_of(size) + size }
  size
}
pub impl @lib.Read for Codegen_WASM with read(reader : &@lib.Reader) {
	let msg =   Codegen_WASM::default()
  while not(reader |> @lib.is_eof()) {
    match (reader |> @lib.read_tag!()) {
      (1, _) => msg.url = reader |> @lib.read_string!()
      (2, _) => msg.sha256 = reader |> @lib.read_string!()
      (_, wire) => reader |> @lib.read_unknown!(wire)
    }
  }
  msg
}
pub impl @lib.Write for Codegen_WASM with write(self, writer) {
  writer |> @lib.write_varint(10UL);writer |> @lib.write_string(self.url)
  writer |> @lib.write_varint(18UL);writer |> @lib.write_string(self.sha256)
}
pub(all) struct Codegen {
  mut out : String
  mut plugin : String
  mut options : Bytes
  mut env : Array[String]
  mut process : Codegen_Process
  mut wasm : Codegen_WASM
} derive(Default, Eq, Show)
impl @lib.Sized for Codegen with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @lib.size_of(self.out); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.plugin); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.options); @lib.size_of(size) + size }
  size += self.env.iter().map(@lib.size_of).map(fn { s => 1U + @lib.size_of(s) + s }).fold(init=0U, UInt::op_add)
  size += 1U + { let size = @lib.size_of(self.process); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.wasm); @lib.size_of(size) + size }
  size
}
pub impl @lib.Read for Codegen with read(reader : &@lib.Reader) {
	let msg =   Codegen::default()
  while not(reader |> @lib.is_eof()) {
    match (reader |> @lib.read_tag!()) {
      (1, _) => msg.out = reader |> @lib.read_string!()
      (2, _) => msg.plugin = reader |> @lib.read_string!()
      (3, _) => msg.options = reader |> @lib.read_bytes!()
      (4, _) => msg.env.push(reader |> @lib.read_string!())
      (5, _) => msg.process = ((reader |> @lib.read_message!()) : Codegen_Process)
      (6, _) => msg.wasm = ((reader |> @lib.read_message!()) : Codegen_WASM)
      (_, wire) => reader |> @lib.read_unknown!(wire)
    }
  }
  msg
}
pub impl @lib.Write for Codegen with write(self, writer) {
  writer |> @lib.write_varint(10UL);writer |> @lib.write_string(self.out)
  writer |> @lib.write_varint(18UL);writer |> @lib.write_string(self.plugin)
  writer |> @lib.write_varint(26UL);writer |> @lib.write_bytes(self.options)
  self.env.iter().each(fn(v) {
    writer |> @lib.write_varint(34UL)
    writer |> @lib.write_string(v)
  })
  writer |> @lib.write_varint(42UL);writer |> @lib.write_uint32(@lib.size_of(self.process)); @lib.Write::write(self.process, writer)
  writer |> @lib.write_varint(50UL);writer |> @lib.write_uint32(@lib.size_of(self.wasm)); @lib.Write::write(self.wasm, writer)
}
pub(all) struct Catalog {
  mut comment : String
  mut default_schema : String
  mut name : String
  mut schemas : Array[Schema]
} derive(Default, Eq, Show)
impl @lib.Sized for Catalog with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @lib.size_of(self.comment); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.default_schema); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.name); @lib.size_of(size) + size }
  size += self.schemas.iter().map(@lib.size_of).map(fn { s => 1U + @lib.size_of(s) + s }).fold(init=0U, UInt::op_add)
  size
}
pub impl @lib.Read for Catalog with read(reader : &@lib.Reader) {
	let msg =   Catalog::default()
  while not(reader |> @lib.is_eof()) {
    match (reader |> @lib.read_tag!()) {
      (1, _) => msg.comment = reader |> @lib.read_string!()
      (2, _) => msg.default_schema = reader |> @lib.read_string!()
      (3, _) => msg.name = reader |> @lib.read_string!()
      (4, _) => msg.schemas.push(((reader |> @lib.read_message!()) : Schema))
      (_, wire) => reader |> @lib.read_unknown!(wire)
    }
  }
  msg
}
pub impl @lib.Write for Catalog with write(self, writer) {
  writer |> @lib.write_varint(10UL);writer |> @lib.write_string(self.comment)
  writer |> @lib.write_varint(18UL);writer |> @lib.write_string(self.default_schema)
  writer |> @lib.write_varint(26UL);writer |> @lib.write_string(self.name)
  self.schemas.iter().each(fn(v) {
    writer |> @lib.write_varint(34UL)
    writer |> @lib.write_uint32(@lib.size_of(v)); @lib.Write::write(v, writer)
  })
}
pub(all) struct Schema {
  mut comment : String
  mut name : String
  mut tables : Array[Table]
  mut enums : Array[Enum]
  mut composite_types : Array[CompositeType]
} derive(Default, Eq, Show)
impl @lib.Sized for Schema with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @lib.size_of(self.comment); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.name); @lib.size_of(size) + size }
  size += self.tables.iter().map(@lib.size_of).map(fn { s => 1U + @lib.size_of(s) + s }).fold(init=0U, UInt::op_add)
  size += self.enums.iter().map(@lib.size_of).map(fn { s => 1U + @lib.size_of(s) + s }).fold(init=0U, UInt::op_add)
  size += self.composite_types.iter().map(@lib.size_of).map(fn { s => 1U + @lib.size_of(s) + s }).fold(init=0U, UInt::op_add)
  size
}
pub impl @lib.Read for Schema with read(reader : &@lib.Reader) {
	let msg =   Schema::default()
  while not(reader |> @lib.is_eof()) {
    match (reader |> @lib.read_tag!()) {
      (1, _) => msg.comment = reader |> @lib.read_string!()
      (2, _) => msg.name = reader |> @lib.read_string!()
      (3, _) => msg.tables.push(((reader |> @lib.read_message!()) : Table))
      (4, _) => msg.enums.push(((reader |> @lib.read_message!()) : Enum))
      (5, _) => msg.composite_types.push(((reader |> @lib.read_message!()) : CompositeType))
      (_, wire) => reader |> @lib.read_unknown!(wire)
    }
  }
  msg
}
pub impl @lib.Write for Schema with write(self, writer) {
  writer |> @lib.write_varint(10UL);writer |> @lib.write_string(self.comment)
  writer |> @lib.write_varint(18UL);writer |> @lib.write_string(self.name)
  self.tables.iter().each(fn(v) {
    writer |> @lib.write_varint(26UL)
    writer |> @lib.write_uint32(@lib.size_of(v)); @lib.Write::write(v, writer)
  })
  self.enums.iter().each(fn(v) {
    writer |> @lib.write_varint(34UL)
    writer |> @lib.write_uint32(@lib.size_of(v)); @lib.Write::write(v, writer)
  })
  self.composite_types.iter().each(fn(v) {
    writer |> @lib.write_varint(42UL)
    writer |> @lib.write_uint32(@lib.size_of(v)); @lib.Write::write(v, writer)
  })
}
pub(all) struct CompositeType {
  mut name : String
  mut comment : String
} derive(Default, Eq, Show)
impl @lib.Sized for CompositeType with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @lib.size_of(self.name); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.comment); @lib.size_of(size) + size }
  size
}
pub impl @lib.Read for CompositeType with read(reader : &@lib.Reader) {
	let msg =   CompositeType::default()
  while not(reader |> @lib.is_eof()) {
    match (reader |> @lib.read_tag!()) {
      (1, _) => msg.name = reader |> @lib.read_string!()
      (2, _) => msg.comment = reader |> @lib.read_string!()
      (_, wire) => reader |> @lib.read_unknown!(wire)
    }
  }
  msg
}
pub impl @lib.Write for CompositeType with write(self, writer) {
  writer |> @lib.write_varint(10UL);writer |> @lib.write_string(self.name)
  writer |> @lib.write_varint(18UL);writer |> @lib.write_string(self.comment)
}
pub(all) struct Enum {
  mut name : String
  mut vals : Array[String]
  mut comment : String
} derive(Default, Eq, Show)
impl @lib.Sized for Enum with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @lib.size_of(self.name); @lib.size_of(size) + size }
  size += self.vals.iter().map(@lib.size_of).map(fn { s => 1U + @lib.size_of(s) + s }).fold(init=0U, UInt::op_add)
  size += 1U + { let size = @lib.size_of(self.comment); @lib.size_of(size) + size }
  size
}
pub impl @lib.Read for Enum with read(reader : &@lib.Reader) {
	let msg =   Enum::default()
  while not(reader |> @lib.is_eof()) {
    match (reader |> @lib.read_tag!()) {
      (1, _) => msg.name = reader |> @lib.read_string!()
      (2, _) => msg.vals.push(reader |> @lib.read_string!())
      (3, _) => msg.comment = reader |> @lib.read_string!()
      (_, wire) => reader |> @lib.read_unknown!(wire)
    }
  }
  msg
}
pub impl @lib.Write for Enum with write(self, writer) {
  writer |> @lib.write_varint(10UL);writer |> @lib.write_string(self.name)
  self.vals.iter().each(fn(v) {
    writer |> @lib.write_varint(18UL)
    writer |> @lib.write_string(v)
  })
  writer |> @lib.write_varint(26UL);writer |> @lib.write_string(self.comment)
}
pub(all) struct Table {
  mut rel : Identifier
  mut columns : Array[Column]
  mut comment : String
} derive(Default, Eq, Show)
impl @lib.Sized for Table with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @lib.size_of(self.rel); @lib.size_of(size) + size }
  size += self.columns.iter().map(@lib.size_of).map(fn { s => 1U + @lib.size_of(s) + s }).fold(init=0U, UInt::op_add)
  size += 1U + { let size = @lib.size_of(self.comment); @lib.size_of(size) + size }
  size
}
pub impl @lib.Read for Table with read(reader : &@lib.Reader) {
	let msg =   Table::default()
  while not(reader |> @lib.is_eof()) {
    match (reader |> @lib.read_tag!()) {
      (1, _) => msg.rel = ((reader |> @lib.read_message!()) : Identifier)
      (2, _) => msg.columns.push(((reader |> @lib.read_message!()) : Column))
      (3, _) => msg.comment = reader |> @lib.read_string!()
      (_, wire) => reader |> @lib.read_unknown!(wire)
    }
  }
  msg
}
pub impl @lib.Write for Table with write(self, writer) {
  writer |> @lib.write_varint(10UL);writer |> @lib.write_uint32(@lib.size_of(self.rel)); @lib.Write::write(self.rel, writer)
  self.columns.iter().each(fn(v) {
    writer |> @lib.write_varint(18UL)
    writer |> @lib.write_uint32(@lib.size_of(v)); @lib.Write::write(v, writer)
  })
  writer |> @lib.write_varint(26UL);writer |> @lib.write_string(self.comment)
}
pub(all) struct Identifier {
  mut catalog : String
  mut schema : String
  mut name : String
} derive(Default, Eq, Show)
impl @lib.Sized for Identifier with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @lib.size_of(self.catalog); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.schema); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.name); @lib.size_of(size) + size }
  size
}
pub impl @lib.Read for Identifier with read(reader : &@lib.Reader) {
	let msg =   Identifier::default()
  while not(reader |> @lib.is_eof()) {
    match (reader |> @lib.read_tag!()) {
      (1, _) => msg.catalog = reader |> @lib.read_string!()
      (2, _) => msg.schema = reader |> @lib.read_string!()
      (3, _) => msg.name = reader |> @lib.read_string!()
      (_, wire) => reader |> @lib.read_unknown!(wire)
    }
  }
  msg
}
pub impl @lib.Write for Identifier with write(self, writer) {
  writer |> @lib.write_varint(10UL);writer |> @lib.write_string(self.catalog)
  writer |> @lib.write_varint(18UL);writer |> @lib.write_string(self.schema)
  writer |> @lib.write_varint(26UL);writer |> @lib.write_string(self.name)
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
  mut table : Identifier
  mut table_alias : String
  mut type : Identifier
  mut is_sqlc_slice : Bool
  mut embed_table : Identifier
  mut original_name : String
  mut unsigned : Bool
  mut array_dims : Int
} derive(Default, Eq, Show)
impl @lib.Sized for Column with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @lib.size_of(self.name); @lib.size_of(size) + size }
  size += 1U + @lib.size_of(self.not_null)
  size += 1U + @lib.size_of(self.is_array)
  size += 1U + { let size = @lib.size_of(self.comment); @lib.size_of(size) + size }
  size += 1U + @lib.size_of(self.length)
  size += 1U + @lib.size_of(self.is_named_param)
  size += 1U + @lib.size_of(self.is_func_call)
  size += 1U + { let size = @lib.size_of(self.scope); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.table); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.table_alias); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.type); @lib.size_of(size) + size }
  size += 1U + @lib.size_of(self.is_sqlc_slice)
  size += 1U + { let size = @lib.size_of(self.embed_table); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.original_name); @lib.size_of(size) + size }
  size += 2U + @lib.size_of(self.unsigned)
  size += 2U + @lib.size_of(self.array_dims)
  size
}
pub impl @lib.Read for Column with read(reader : &@lib.Reader) {
	let msg =   Column::default()
  while not(reader |> @lib.is_eof()) {
    match (reader |> @lib.read_tag!()) {
      (1, _) => msg.name = reader |> @lib.read_string!()
      (3, _) => msg.not_null = reader |> @lib.read_bool!()
      (4, _) => msg.is_array = reader |> @lib.read_bool!()
      (5, _) => msg.comment = reader |> @lib.read_string!()
      (6, _) => msg.length = reader |> @lib.read_int32!()
      (7, _) => msg.is_named_param = reader |> @lib.read_bool!()
      (8, _) => msg.is_func_call = reader |> @lib.read_bool!()
      (9, _) => msg.scope = reader |> @lib.read_string!()
      (10, _) => msg.table = ((reader |> @lib.read_message!()) : Identifier)
      (11, _) => msg.table_alias = reader |> @lib.read_string!()
      (12, _) => msg.type = ((reader |> @lib.read_message!()) : Identifier)
      (13, _) => msg.is_sqlc_slice = reader |> @lib.read_bool!()
      (14, _) => msg.embed_table = ((reader |> @lib.read_message!()) : Identifier)
      (15, _) => msg.original_name = reader |> @lib.read_string!()
      (16, _) => msg.unsigned = reader |> @lib.read_bool!()
      (17, _) => msg.array_dims = reader |> @lib.read_int32!()
      (_, wire) => reader |> @lib.read_unknown!(wire)
    }
  }
  msg
}
pub impl @lib.Write for Column with write(self, writer) {
  writer |> @lib.write_varint(10UL);writer |> @lib.write_string(self.name)
  writer |> @lib.write_varint(24UL);writer |> @lib.write_bool(self.not_null)
  writer |> @lib.write_varint(32UL);writer |> @lib.write_bool(self.is_array)
  writer |> @lib.write_varint(42UL);writer |> @lib.write_string(self.comment)
  writer |> @lib.write_varint(48UL);writer |> @lib.write_int32(self.length)
  writer |> @lib.write_varint(56UL);writer |> @lib.write_bool(self.is_named_param)
  writer |> @lib.write_varint(64UL);writer |> @lib.write_bool(self.is_func_call)
  writer |> @lib.write_varint(74UL);writer |> @lib.write_string(self.scope)
  writer |> @lib.write_varint(82UL);writer |> @lib.write_uint32(@lib.size_of(self.table)); @lib.Write::write(self.table, writer)
  writer |> @lib.write_varint(90UL);writer |> @lib.write_string(self.table_alias)
  writer |> @lib.write_varint(98UL);writer |> @lib.write_uint32(@lib.size_of(self.type)); @lib.Write::write(self.type, writer)
  writer |> @lib.write_varint(104UL);writer |> @lib.write_bool(self.is_sqlc_slice)
  writer |> @lib.write_varint(114UL);writer |> @lib.write_uint32(@lib.size_of(self.embed_table)); @lib.Write::write(self.embed_table, writer)
  writer |> @lib.write_varint(122UL);writer |> @lib.write_string(self.original_name)
  writer |> @lib.write_varint(128UL);writer |> @lib.write_bool(self.unsigned)
  writer |> @lib.write_varint(136UL);writer |> @lib.write_int32(self.array_dims)
}
pub(all) struct Query {
  mut text : String
  mut name : String
  mut cmd : String
  mut columns : Array[Column]
  mut parameters : Array[Parameter]
  mut comments : Array[String]
  mut filename : String
  mut insert_into_table : Identifier
} derive(Default, Eq, Show)
impl @lib.Sized for Query with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @lib.size_of(self.text); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.name); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.cmd); @lib.size_of(size) + size }
  size += self.columns.iter().map(@lib.size_of).map(fn { s => 1U + @lib.size_of(s) + s }).fold(init=0U, UInt::op_add)
  size += self.parameters.iter().map(@lib.size_of).map(fn { s => 1U + @lib.size_of(s) + s }).fold(init=0U, UInt::op_add)
  size += self.comments.iter().map(@lib.size_of).map(fn { s => 1U + @lib.size_of(s) + s }).fold(init=0U, UInt::op_add)
  size += 1U + { let size = @lib.size_of(self.filename); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.insert_into_table); @lib.size_of(size) + size }
  size
}
pub impl @lib.Read for Query with read(reader : &@lib.Reader) {
	let msg =   Query::default()
  while not(reader |> @lib.is_eof()) {
    match (reader |> @lib.read_tag!()) {
      (1, _) => msg.text = reader |> @lib.read_string!()
      (2, _) => msg.name = reader |> @lib.read_string!()
      (3, _) => msg.cmd = reader |> @lib.read_string!()
      (4, _) => msg.columns.push(((reader |> @lib.read_message!()) : Column))
      (5, _) => msg.parameters.push(((reader |> @lib.read_message!()) : Parameter))
      (6, _) => msg.comments.push(reader |> @lib.read_string!())
      (7, _) => msg.filename = reader |> @lib.read_string!()
      (8, _) => msg.insert_into_table = ((reader |> @lib.read_message!()) : Identifier)
      (_, wire) => reader |> @lib.read_unknown!(wire)
    }
  }
  msg
}
pub impl @lib.Write for Query with write(self, writer) {
  writer |> @lib.write_varint(10UL);writer |> @lib.write_string(self.text)
  writer |> @lib.write_varint(18UL);writer |> @lib.write_string(self.name)
  writer |> @lib.write_varint(26UL);writer |> @lib.write_string(self.cmd)
  self.columns.iter().each(fn(v) {
    writer |> @lib.write_varint(34UL)
    writer |> @lib.write_uint32(@lib.size_of(v)); @lib.Write::write(v, writer)
  })
  self.parameters.iter().each(fn(v) {
    writer |> @lib.write_varint(42UL)
    writer |> @lib.write_uint32(@lib.size_of(v)); @lib.Write::write(v, writer)
  })
  self.comments.iter().each(fn(v) {
    writer |> @lib.write_varint(50UL)
    writer |> @lib.write_string(v)
  })
  writer |> @lib.write_varint(58UL);writer |> @lib.write_string(self.filename)
  writer |> @lib.write_varint(66UL);writer |> @lib.write_uint32(@lib.size_of(self.insert_into_table)); @lib.Write::write(self.insert_into_table, writer)
}
pub(all) struct Parameter {
  mut number : Int
  mut column : Column
} derive(Default, Eq, Show)
impl @lib.Sized for Parameter with size_of(self) {
  let mut size = 0U
  size += 1U + @lib.size_of(self.number)
  size += 1U + { let size = @lib.size_of(self.column); @lib.size_of(size) + size }
  size
}
pub impl @lib.Read for Parameter with read(reader : &@lib.Reader) {
	let msg =   Parameter::default()
  while not(reader |> @lib.is_eof()) {
    match (reader |> @lib.read_tag!()) {
      (1, _) => msg.number = reader |> @lib.read_int32!()
      (2, _) => msg.column = ((reader |> @lib.read_message!()) : Column)
      (_, wire) => reader |> @lib.read_unknown!(wire)
    }
  }
  msg
}
pub impl @lib.Write for Parameter with write(self, writer) {
  writer |> @lib.write_varint(8UL);writer |> @lib.write_int32(self.number)
  writer |> @lib.write_varint(18UL);writer |> @lib.write_uint32(@lib.size_of(self.column)); @lib.Write::write(self.column, writer)
}
pub(all) struct GenerateRequest {
  mut settings : Settings
  mut catalog : Catalog
  mut queries : Array[Query]
  mut sqlc_version : String
  mut plugin_options : Bytes
  mut global_options : Bytes
} derive(Default, Eq, Show)
impl @lib.Sized for GenerateRequest with size_of(self) {
  let mut size = 0U
  size += 1U + { let size = @lib.size_of(self.settings); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.catalog); @lib.size_of(size) + size }
  size += self.queries.iter().map(@lib.size_of).map(fn { s => 1U + @lib.size_of(s) + s }).fold(init=0U, UInt::op_add)
  size += 1U + { let size = @lib.size_of(self.sqlc_version); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.plugin_options); @lib.size_of(size) + size }
  size += 1U + { let size = @lib.size_of(self.global_options); @lib.size_of(size) + size }
  size
}
pub impl @lib.Read for GenerateRequest with read(reader : &@lib.Reader) {
	let msg =   GenerateRequest::default()
  while not(reader |> @lib.is_eof()) {
    match (reader |> @lib.read_tag!()) {
      (1, _) => msg.settings = ((reader |> @lib.read_message!()) : Settings)
      (2, _) => msg.catalog = ((reader |> @lib.read_message!()) : Catalog)
      (3, _) => msg.queries.push(((reader |> @lib.read_message!()) : Query))
      (4, _) => msg.sqlc_version = reader |> @lib.read_string!()
      (5, _) => msg.plugin_options = reader |> @lib.read_bytes!()
      (6, _) => msg.global_options = reader |> @lib.read_bytes!()
      (_, wire) => reader |> @lib.read_unknown!(wire)
    }
  }
  msg
}
pub impl @lib.Write for GenerateRequest with write(self, writer) {
  writer |> @lib.write_varint(10UL);writer |> @lib.write_uint32(@lib.size_of(self.settings)); @lib.Write::write(self.settings, writer)
  writer |> @lib.write_varint(18UL);writer |> @lib.write_uint32(@lib.size_of(self.catalog)); @lib.Write::write(self.catalog, writer)
  self.queries.iter().each(fn(v) {
    writer |> @lib.write_varint(26UL)
    writer |> @lib.write_uint32(@lib.size_of(v)); @lib.Write::write(v, writer)
  })
  writer |> @lib.write_varint(34UL);writer |> @lib.write_string(self.sqlc_version)
  writer |> @lib.write_varint(42UL);writer |> @lib.write_bytes(self.plugin_options)
  writer |> @lib.write_varint(50UL);writer |> @lib.write_bytes(self.global_options)
}
pub(all) struct GenerateResponse {
  mut files : Array[File]
} derive(Default, Eq, Show)
impl @lib.Sized for GenerateResponse with size_of(self) {
  let mut size = 0U
  size += self.files.iter().map(@lib.size_of).map(fn { s => 1U + @lib.size_of(s) + s }).fold(init=0U, UInt::op_add)
  size
}
pub impl @lib.Read for GenerateResponse with read(reader : &@lib.Reader) {
	let msg =   GenerateResponse::default()
  while not(reader |> @lib.is_eof()) {
    match (reader |> @lib.read_tag!()) {
      (1, _) => msg.files.push(((reader |> @lib.read_message!()) : File))
      (_, wire) => reader |> @lib.read_unknown!(wire)
    }
  }
  msg
}
pub impl @lib.Write for GenerateResponse with write(self, writer) {
  self.files.iter().each(fn(v) {
    writer |> @lib.write_varint(10UL)
    writer |> @lib.write_uint32(@lib.size_of(v)); @lib.Write::write(v, writer)
  })
}
