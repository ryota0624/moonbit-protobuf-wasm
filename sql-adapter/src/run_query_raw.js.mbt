///|
#external
type JsAdapter

///|
#external
priv type JsError

///|
impl Show for JsError with output(self, logger) {
  logger.write_string(self.to_string_js())
}

///|
extern "js" fn JsError::to_string_js(self : JsError) -> String =
  #| (self) => self.toString() + "\n" + self.stack

///|
async fn JsAdapter::prepare_context(
  self : JsAdapter,
  connect : String
) -> JsRunQueryContext raise Error {
  suspend((ok, err) => self.prepare_context_js(connect, ok, err))
}

///|
#external
priv type JsRunQueryContext

///|
impl RunQueryContext for JsRunQueryContext with run_query_raw(self, str : Bytes) -> Bytes raise RunQueryError {
  let result = try? suspend((onOk, onErr) => run_query_raw_js(self, str, onOk, err => onErr(
      Failure(err.to_string()),
    )))
  result
  .map_err(err => RunQueryError::InternalDelegatedRunQueryError(err.to_string()))
  .unwrap_or_error()
}

///|
/// /// This is a JavaScript interface for running queries.
/// interface JsAdapter {
///   prepareContext(connect: String): Promise<JsRunQueryContext>;
/// }
/// 
/// interface JsRunQueryContext {
///  runQuery(bytes: Bytes): Promise<Bytes>;
/// }

///|
extern "js" fn run_query_raw_js(
  ctx : JsRunQueryContext,
  bytes : Bytes,
  res : (Bytes) -> Unit,
  rej : (JsError) -> Unit
) -> Unit =
  #|(ctx, bytes, res, rej) => ctx.runQuery(bytes).then(res).catch(rej)

///|
extern "js" fn prepare_context_js(
  self : JsAdapter,
  connect : String,
  res : (JsRunQueryContext) -> Unit,
  rej : (Error) -> Unit
) -> Unit =
  #|(adapter, connect, res, rej) => adapter.prepareContext(connect).then(res).catch(rej)
