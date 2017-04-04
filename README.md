# RZendesk
Wrapper function for accessing Sittercity Zendesk API

## Setup

### 1) install and Load Library Locally
Add library to your local project
```R
devtools::install_github("tmoeller/RZendesk")
library(RZendesk)
```

### 2) Setup Environmental Variables
```
ZENDESK_USER= 'valid Zendesk username'/token
ZENDESK_TOKEN= 'Zendesk API token'
ZENDESK_URL= https://your_organization.zendesk.com/api/v2

```

#### Configuring project-only environmental variables for RStudio
To setup local environmental variables just for a given R package, you can create an .Renviron file for storing the above variables. To create a new .Renviron file, open a new text file in RStudio and save as '.Renviron'


## Usage

### Get a Ticket from Zendesk API
```R
# call get_ticket and pass Zendesk ticket number as string
get_ticket(ticket = '12345678')
```

#### The get_ticket function will return an object with three attributes:
```R
# save ticket in variable
ticket <- get_ticket(ticket = '12345678')

# view content of ticket (json response parsed as named list)
ticket$content

# view headers passed for API call
ticket$headers

# view response from API call for ticket
ticket$response
```


### Post a new ticket through Zendesk API
```R
# call post_ticket and pass parameters to create new ticket
post_ticket(
      requester_name = 'fake_name',
      requester_email = 'fake_email',
      body = 'comment in body of ticket',
      subject = 'subject of ticket'
)
```
#### Additional parameters will be added later
