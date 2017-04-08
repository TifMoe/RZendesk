#' Create a client connection to the Zendesk API
#'
#' Allows user to post a new ticket to the Zendesk API on behalf of a customer
#'
#' @param requester_name a string to identify customer who should be listed as ticket requester (optional, if NULL the email will pull in corresponding name)
#' @param requester_email a string to identify customer who should be listed as ticket requester
#' @param body a character string that is passed to the body of the Zendesk ticket
#' @param subject the subject of your Zendesk ticket
#' @param group an integer to indicate the group_id for your new ticket (optional, can be set to NULL)
#' @param tags a list of character strings to set as the ticket tags for your new ticket (optional, can be set to NULL)
#' @param public an optional logical value to indicate if the ticket comment should be public (TRUE) or privet (FALSE), default value FALSE
#' @param cli the Zendesk client [created from ::client]
#'
#' @return Zendesk ticket number for successfully created ticket
#'
#' @examples
#' post_ticket(
#'   requester_name = 'fake_name',
#'   requester_email = 'fake_email',
#'   body = 'comment in body of ticket',
#'   subject = 'subject of ticket',
#'   group = 1234567,
#'   tags = list(),
#'   public = FALSE
#' )
#'
#' @export
#'
post_ticket <- function(requester_name, requester_email, body, subject, group, tags = list(), public, cli = client()) {
      end_point <- '/tickets.json'
      
      response <- send(
            cli = cli,
            end_point = end_point,
            body = prepare_data(requester_name, requester_email, body, subject, group, tags, public)
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


prepare_data <- function(requester_name, requester_email, body, subject, group, tags, public) {
      
      # If 'public' indicator is missing, default to FALSE
      if(missing(public)){
            public = FALSE
      } else {
            public = public
      }
      
      
      data <- list(ticket = list(
            requester = list(name = requester_name, email = requester_email),
            subject = subject,
            comment = list(body = get_comment(body),
                           public = public),
            group_id = as.integer(group),
            tags = tags
      ))
      return( rjson::toJSON(data) )
}



get_comment <- function(body){
      comment = paste('This member was flagged for:', body, sep = " ")
      return(comment)
}


