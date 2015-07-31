saveHTML <- function(response, filename='output.html'){
  f<-file(filename)
  writeLines(result, f)
  close(f)
}

##########################################################
# Connector (Fail version)
#   Use what we learn in the past
#   Naive GET !
##########################################################
library(httr)
response.before <- httr:: GET(URLencode('http://buy.yungching.com.tw/region/台北市-_c/pricereduction_filter/'))
result <- content(response.before, 'text')
saveHTML(result)


##########################################################
# Connector (Sucess version)
#   Set request headers with user-agent
##########################################################
header <- httr::add_headers("User-Agent"="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36")
response.after <- httr:: GET(URLencode('http://buy.yungching.com.tw/region/台北市-_c/pricereduction_filter/'), header)
result <- content(response.after , 'text')
saveHTML(result)

##########################################################
#   Compare header with and without user-agent included  
##########################################################

print(response.before$request$header)
print(response.after$request$header)



##########################################################
# Parser
##########################################################
library(XML)
xml <- htmlParse(response.after)
xml["//a[@class='item-title ga_click_trace']//text()"]