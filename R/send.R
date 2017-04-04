send <- function(cli, end_point, body = NULL) {
      response <- httr::POST(
                  url = paste0(cli@base_url, end_point),
                  httr::authenticate(cli@user, cli@token),
                  httr::add_headers(get_headers(cli)),
                  body = body)
      return(response)
      Sys.sleep(1/50)  #prevent running more than 50 per second
}


get_headers <- function(cli) {
      headers = c(
            Accept = "application/json",
            "Content-Type" = "application/json"
      )
}

