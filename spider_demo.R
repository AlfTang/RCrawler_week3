# 示範
if (!require(RCurl)) install.packages("RCurl")
if (!require(XML)) install.packages("XML")
library(RCurl)
library(XML)
# install RCurl, XML
extract = function(xml, Xpath){
  value = unlist(xml[Xpath]) 
  if (length(value) == 0) return(NA) 
  if (class(value) != "character" ) return(sapply(xml[Xpath], xmlValue))
  return(value) }
getPageData = function(url){
  html = getURL(url)
  xml = htmlParse(html)
  page_data= data.frame()
  page_data = data.frame(  title = extract(xml, Xpath ="//div[@class='title']/a/text()"),
                           author= extract(xml, Xpath ="//div[@class='author']//text()"),
                           href = paste("http://www.ptt.cc",extract(xml, Xpath ="//div[@class='title']/a//@href"), 
                                        sep=""),
                           date = extract(xml, Xpath ="//div[@class='date']"))
  page_data$push = sapply(1:nrow(page_data), 
                          function(x) extract(xml, Xpath = sprintf("//div[@class='r-ent'][%d]//span[@class='hl f2']",x)))
  return(page_data)
}
data = data.frame()
for (i in 1:12){
  url = sprintf("http://www.ptt.cc/bbs/R_Language/index%s.html", i )
  data = rbind(data, getPageData(url))
}
# View(data) # encoding error happens in windows platform..
fix(data) # this is okay for windows too.


############## which month ###########################
ptt_table = data
date = as.character(ptt_table$date)
m_d = as.numeric(unlist(strsplit(date, "/")))
m_d = matrix(m_d, length(m_d)/2 , 2 , byrow=TRUE)
colnames(m_d) = c("month", "day")
hist(m_d[,"month"], 
     breaks=c(2:11), 
     labels=TRUE,
     main="2013 PTT R_language 版", 
     xlab="月份", ylab="發文數",
     xaxt='n', ylim=c(0,70))

axis(side=1, at=c(1:11), labels=c(2:12))

############### who ###########################
authors = as.factor(ptt_table$author)
author_list = levels(authors)
count=sapply(1:length(author_list), 
             function(x) sum(authors %in% author_list[x]))
a_c = data.frame(author=author_list, count=count)
a_c = a_c[order(-count),]
print(a_c)   

############### 版友戰力 ##########################################################

user_ids = data.frame(id = as.character())
urls = data$href
for (url in urls){
  url = as.character(url)
  html = getURL(url)
  xml = htmlParse(html)
  page_ids = data.frame( id = extract(xml, Xpath = "//span[@class='f3 hl push-userid']/text()") )
  user_ids = rbind(user_ids, page_ids)
}

id_count = summary(user_ids$id)
View(id_count)
barplot(id_count[1:10], xlab="", main="PTT R_language 網友戰力")


############ 人肉搜尋XD #############################################################

human_search=function(url, id="EXILESPACER"){
  url = as.character(url)
  html = getURL(url)
  xml = htmlParse(html)
  id = extract(xml, Xpath = "//span[@class='f3 hl push-userid']/text()") 
  content = extract(xml, Xpath = "//span[@class='f3 push-content']//text()")
  my_push_each_page = content[id %in% id] 
  if (length(my_push_each_page) != 0){
    my_push_each_page = data.frame(content=my_push_each_page)
  } 
  return(my_push_each_page)
}

my_push = data.frame(content=as.character())
for (url in urls){
  my_push = rbind(my_push, human_search(url, "EXILESPACER"))
}

