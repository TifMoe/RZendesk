get <- function(cli, end_point) {
      response <- httr::GET(
            url = paste0(cli@base_url, end_point),
            httr::authenticate(cli@user, cli@token))

      return(response)
      Sys.sleep(1/50)  #prevent running more than 50 per second
}


