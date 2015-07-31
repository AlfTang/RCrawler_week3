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
# Windows User Attention !
# url <- sprintf('http://buy.yungching.com.tw/region/%s-_c/pricereduction_filter/' , 
#                URLencode(iconv("台北市", 'big5', 'utf8')))
url <- 'http://buy.yungching.com.tw/region/台北市-_c/pricereduction_filter/'
response.before <- httr:: GET(URLencode(url))
result <- content(response.before, 'text')
saveHTML(result)


##########################################################
# Connector (Sucess version)
#   Set request headers with user-agent
##########################################################
header <- httr::add_headers("User-Agent"="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36")
# Windows User Attention !
# url <- sprintf('http://buy.yungching.com.tw/region/%s-_c/pricereduction_filter/' , 
#                URLencode(iconv("台北市", 'big5', 'utf8')))
url <- 'http://buy.yungching.com.tw/region/台北市-_c/pricereduction_filter/'
response.after <- httr:: GET(URLencode(url), header)
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

result <- xpathSApply(content(response.after), "//a[@class='item-title ga_click_trace']/h3/text()", xmlValue)
print(result)