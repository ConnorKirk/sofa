#' Start indexing a CouchDB database using Elasticsearch.
#'
#' @import httr
#' @inheritParams sofa_ping
#' @param dbname Database name. (charcter)
#' @details The function returns TRUE. Though note that this can result even 
#'    if the database does not exist in CouchDB. 
#' @examples \dontrun{
#' sofa_createdb(dbname='shitty2')
#' elastic_start(dbname="shitty2")
#' }
#' @export
elastic_start <- function(dbname, endpoint="http://localhost", port=9200)
{
  call_ <- paste(paste(endpoint, port, sep=":"), "/_river/", dbname, "/_meta", sep="")
  args <- paste0('{ "type" : "couchdb", "couchdb" : { "host" : "localhost", "port" : 5984, "db" : "', dbname, '", "filter" : null } }')    
  out <- content(PUT(url = call_, body=args))
  out[1] 
}