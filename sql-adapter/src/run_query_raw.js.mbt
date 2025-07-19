///|
async fn run_query_raw(
  adapter : JsAdapter,
  ctx : JsRunQueryContext,
  str : Bytes
) -> Bytes raise RunQueryError {
  let result = try? suspend((onOk, onErr) => run_query_raw_js(
      adapter,
      ctx,
      str,
      onOk,
      err => onErr(Failure(err.to_string())),
    ))
  result
  .map_err(err => RunQueryError::InternalDelegatedRunQueryError(err.to_string()))
  .unwrap_or_error()
}

///|
extern "js" fn prepare_context_js(
  self : JsAdapter,
  connect : String,
  res : (JsRunQueryContext) -> Unit,
  rej : (Error) -> Unit
) -> Unit =
  #|(adapter, connect, res, rej) => adapter.prepareContext(connect).then(res).catch(rej)

///|
#external
type JsAdapter

///|
#external
type JsError

///|
impl Show for JsError with output(self, logger) {
  logger.write_string(self.to_string_js())
}

///|
extern "js" fn JsError::to_string_js(self : JsError) -> String =
  #| (self) => self.toString()

///|
async fn JsAdapter::prepare_context(
  self : JsAdapter,
  connect : String
) -> JsRunQueryContext raise Error {
  suspend((ok, err) => self.prepare_context_js(connect, ok, err))
}

///|
fn JsAdapter::global() -> JsAdapter {
  get_global_JsAdapter()
}

///|
extern "js" fn set_JsAdapter_to_global(adapter : JsAdapter) -> Unit =
  #|(adapter) => globalThis.__sql_adapter_JsAdapter = adapter

///|
extern "js" fn get_global_JsAdapter() -> JsAdapter =
  #| () => {
  #|   let adapter = globalThis.__sql_adapter_JsAdapter
  #|   if (adapter === undefined) {
  #|     throw Error('forget call setup_JsAdapter')
  #|   }
  #|   return adapter
  #|  }

///|
pub fn setup_JsAdapter(adapter : JsAdapter) -> Unit {
  set_JsAdapter_to_global(adapter)
}

///|
#external
type JsRunQueryContext

///|
impl RunQueryContext for JsRunQueryContext with describe(_) -> String {
  return "JsRunQueryContext"
}

///|
impl RunQueryContext for JsRunQueryContext with run_query_raw(self, str : Bytes) -> Bytes raise RunQueryError {
  let adapter = JsAdapter::global()
  run_query_raw(adapter, self, str)
}

///|
extern "js" fn run_query_raw_js(
  adapter : JsAdapter,
  ctx : JsRunQueryContext,
  bytes : Bytes,
  res : (Bytes) -> Unit,
  rej : (JsError) -> Unit
) -> Unit =
  #|(adapter, ctx, bytes, res, rej) => adapter.runQuery(ctx, bytes).then(res).catch(rej)
