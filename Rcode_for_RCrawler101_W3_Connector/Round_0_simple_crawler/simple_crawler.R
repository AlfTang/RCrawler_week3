saveHTML <- function(response, filename='output.html'){
  f<-file(filename)
  writeLines(result, f)
  close(f)
}


##########################
# Connector
##########################
library(httr)
res <- httr::GET('https://www.ptt.cc/bbs/R_Language/index.html')
result <- content(res, 'text')
saveHTML(result)


##########################
# Parser
##########################
library(XML)
result <- xpathSApply(content(res), '//div[@class="title"]//text()', xmlValue)
print(result)