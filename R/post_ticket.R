#' Create a client connection to the Zendesk API
#'
#' Allows user to post a new ticket to the Zendesk API on behalf of a customer
#'
#' @param requester_name a string to identify customer who should be listed as ticket requester, with the ticket pointing to their account
#' @param requester_email a string to identify customer who should be listed as ticket requester
#' @param body a character string that is passed to the body of the Zendesk ticket
#' @param subject the subject of your Zendesk ticket
#' @param cli the Zendesk client [created from ::client]
#'
#' @return Zendesk ticket number for successfully created ticket
#'
#' @examples
#' post_ticket(
#'   requester_name = 'fake_name',
#'   requester_email = 'fake_email',
#'   body = 'comment in body of ticket',
#'   subject = 'subject of ticket'
#' )
#'
#' @export
#'
post_ticket <- function(requester_name, requester_email, body, subject, cli = client()) {
      end_point <- '/tickets.json'

      response <- send(
            cli = cli,
            end_point = end_point,
            body = prepare_data(requester_name, requester_email, body, subject)
      )

      # check status and log id
      if (httr::status_code(response) == 201){
            print('Ticket successfully created!')
            print(response)
            ticket <- httr::content(response)
            return(ticket$ticket$id)
      } else {
            print(paste('Please investigate error, status code:',httr::status_code(response),sep = " "))
            print(response)
      }
}


prepare_data <- function(requester_name, requester_email, body, subject) {
      data <- list(ticket = list(
            requester = list(name = requester_name, email = requester_email),
            subject = subject,
            comment = list(body = get_comment(body))
      ))
      return( rjson::toJSON(data) )
}



get_comment <- function(body){
      comment = paste('This member was flagged for:', body, sep = " ")
      return(comment)
}


