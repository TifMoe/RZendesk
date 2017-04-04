#' An S4 class to represent a client connection
#'
#' @slot user the Zendesk user (for use with API tokens please add '/token' to the end of your username)
#' @slot token the user's Zendesk API token
#' @slot base_url the url for c
setClass(
      'ZendeskClient',
      representation(
            user='character',
            token='character',
            base_url='character'
      )
)


#' Create a client connection to the Zendesk API
#'
#' @export
#' @param url The base URL to the Zendesk API service
#' @param user The user to access Zendesk
#' @param token = The token to access Zendesk
#' @param debugging set to TRUE to increase stdout logging and provide additional debugging detail
#' @examples
#' client(url = 'https://organization.zendesk.com/api/v2',
#'     user = 'zendesk_user',
#'     token = 'zendesk_token')
#'
client <- function(url = Sys.getenv('ZENDESK_URL'), user = Sys.getenv('ZENDESK_USER'), token = Sys.getenv('ZENDESK_TOKEN'), debugging = FALSE) {
      client <- methods::new("ZendeskClient")
      client@user = user
      client@token = token
      client@base_url = url

      return(client)
}
