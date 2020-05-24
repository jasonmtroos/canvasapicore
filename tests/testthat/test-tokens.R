setup({
	Sys.setenv(CANVAS_API_TOKEN = "")
	Sys.setenv(CANVAS_DOMAIN = "")
	tmp <- tempfile(fileext = '.rds')
	Sys.setenv(CANVASCOREAPI_TOKEN_FN = tmp)
})
test_that("setting and getting tokens works", {
	fake_token <- "fake_token"
	fake_domain <- "fake_domain"
	token <- new_token(token = fake_token, domain = fake_domain)
	testthat::expect_identical(fake_token, token)
	testthat::expect_error(new_token(token = fake_token, domain = fake_domain))
	testthat::expect_identical(fake_token, get_token())
	testthat::expect_identical(fake_domain, get_domain())
	testthat::expect_identical(fake_token, Sys.getenv("CANVAS_API_TOKEN"))
	testthat::expect_identical(fake_domain, Sys.getenv("CANVAS_DOMAIN"))
	testthat::expect_null(load_token_and_domain())
})
