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
response.before <- httr::GET('http://www.pixiv.net/')
result <- content(response.before, 'text')
saveHTML(result)


##########################################################
# Connector (Sucess version)
#   set valid cookies to request header
##########################################################

cookie <- set_cookies(
  ' PHPSESSID'='15244387_dc9353b9f969b83f657db3a5f4eda801'
)## cookie need to be changed everytime you run this file

response.after <- httr::GET('http://www.pixiv.net/', cookie)
result <- content(response.after, 'text')
saveHTML(result)


##########################################################
#   Try another target web page
##########################################################
response.after <- httr::GET('http://spotlight.pics/zh-tw/a/573', cookie)
result <- content(response.after, 'text')
saveHTML(result)

##########################################################
#   Seems with different language
#   How can I change the language setting? => try Headers!
##########################################################
header <- add_headers("Accept-Language"="zh-TW,zh;q=0.8,en-US;q=0.6,en;q=0.4")
response.after <- httr::GET('http://spotlight.pics/zh-tw/a/573', cookie, header)
result <- content(response.after, 'text')
saveHTML(result)


