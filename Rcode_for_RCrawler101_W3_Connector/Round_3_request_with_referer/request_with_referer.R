saveJPEG <- function(response, filename='output.jpg'){
  plot(0:1, 0:1, type = "n")
  rasterImage(response, 0, 0, 1, 1)
  print(reponse)
}

##########################################################
# Connector (Fail version)
#   reqeust with cookie
##########################################################
library(httr)
cookie <- set_cookies(
  ' PHPSESSID'='15244387_dc9353b9f969b83f657db3a5f4eda801'
)## cookie need to be changed everytime you run this file

response.before <- httr::GET("http://i3.pixiv.net/img23/img/scaji/2362526.jpg", cookie, timeout(15))
result <- content(response.before)
saveJPEG(result)

print(response.before$status)


##########################################################
# Connector (Sucess version)
#   reqeust with Cookie & Referer
##########################################################
header <- add_headers(
  "Referer"="http://www.pixiv.net/member_illust.php?mode=medium&illust_id=2362526"
)
response.after <- httr::GET("http://i3.pixiv.net/img23/img/scaji/2362526.jpg", cookie, header, timeout(30))
result <- content(response.after)
saveJPEG(result)

print(response.after$status)
