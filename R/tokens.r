get_token_file_name <- function() {
	Sys.getenv("CANVASCOREAPI_TOKEN_FN", normalizePath('~/.canvasapicore.rds', mustWork = FALSE))
}
save_token_to_user_dir <- function(token, domain) {
	fn <- get_token_file_name()
	if (file.exists(fn)) {
		stop(stringr::str_glue("The file {fn} exists already. Manually delete that file before running this command."))
	}
	invisible(saveRDS(list(token = token, domain = domain), file = fn))
}

#' Token management
#'
#' @return A canvas token
#' @rdname tokens
#' @export
#'
get_token <- function() {
	token <- Sys.getenv("CANVAS_API_TOKEN", "")
	if (stringr::str_length(token) == 0L) {
		fn <- get_token_file_name()
		if (!file.exists(fn)) {
			stop(stringr::str_glue("Unable to find a cached token at {fn}. Did you previously call XXX?"))
		}
		token <- readRDS(fn)
		Sys.setenv(CANVAS_API_TOKEN = token$token)
		Sys.setenv(CANVAS_DOMAIN = token$domain)
	}
	cnvs::cnvs_token()
}
#' @rdname tokens
#' @export
#' 
new_token <- function(token, domain) {
	Sys.setenv(CANVAS_API_TOKEN = "")
	save_token_to_user_dir(token, domain)
	invisible(get_token())
}
#' @rdname tokens
#' @export
#' 
get_domain <- function() {
	get_token()
	cnvs::cnvs_domain()
}

#' @rdname tokens
#' @export
#' 
load_token_and_domain <- function() {
	get_token()
	invisible(NULL)
}

