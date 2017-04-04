#' Create a client connection to the Zendesk API to retreive a Zendesk ticket
#'
#' Get a Zendesk ticket from API call by passing Zendesk ticket number
#'
#' @param ticket a unique string to identify specific Zendesk ticket to get from API
#' @param cli the Zendesk client [created from ::client]
#'
#' @return object with three attributes:
#'     content - json response from API parsed into named list
#'     headers - headers passed with API request for ticket
#'     response - API response to request
#'
#' @examples
#' get_ticket('123455')
#'
#' @export
#'
get_ticket <- function(ticket, cli = client()) {
      end_point <- paste('/tickets/',ticket,'.json', sep = "")

      response <- get(
            cli = cli,
            end_point = end_point
      )

      # parse json response into named list
      parsed <- jsonlite::fromJSON(httr::content(response, "text"), simplifyVector = FALSE)

      # check status of api call
      if (httr::status_code(response) != 200){
            stop(
                  sprintf('Zendesk API request failed [%s]',
                          httr::status_code(response)
                  ),
                  call. = FALSE
            )
      }

      print('Zendesk API request successful!')

      # Create object for function responses
      structure(
            list(
                  content = parsed,
                  response = response,
                  headers = httr::headers(response)
            ),
            class = 'get_ticket'
      )
}

