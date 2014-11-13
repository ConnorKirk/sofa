#' Delete a database.
#'
#' @export
#' @import httr
#' @param dbname Database name
#' @param endpoint One of localhost, cloudant, or iriscouch. For local work
#'    use the default localhost. For cloudant or iriscouch you will need accounts
#'    with those database services.
#' @param port The port to use. Only applicable if using endpoint="localhost".
#' @param username Your cloudant or iriscouch username
#' @param pwd Your cloudant or iriscouch password
#' @param ... Curl args passed on to \code{\link[httr]{GET}}
#' @examples \donttest{
#' # local databasees
#' ## create database first, then delete
#' createdb('newdb')
#' deletedb('newdb')
#'
#' ## with curl info while doing request
#' library('httr')
#' createdb('newdb')
#' deletedb('newdb', config=verbose())
#' }

deletedb <- function(dbname, endpoint="localhost", port=5984, username=NULL, pwd=NULL, ...)
{
  endpoint <- match.arg(endpoint,choices=c("localhost","cloudant","iriscouch"))

  if(endpoint=="localhost"){
    sofa_DELETE(sprintf("http://127.0.0.1:%s/%s", port, dbname), ...)
  } else
    if(endpoint=="cloudant"){
      auth <- get_pwd(username,pwd,"cloudant")
      url <- sprintf('https://%s:%s@%s.cloudant.com/%s', auth[[1]], auth[[2]], auth[[1]], dbname)
      sofa_DELETE(url, content_type_json(), ...)
    } else
    {
      auth <- get_pwd(username,pwd,"iriscouch")
      url <- sprintf('https://%s.iriscouch.com/%s', auth[[1]], dbname)
      sofa_DELETE(url, content_type_json(), ...)
    }
}