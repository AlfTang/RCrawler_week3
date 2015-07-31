
#########################################################################
# Download csv
#########################################################################
download.file("http://www.twse.com.tw/ch/trading/exchange/BFIAMU/BFIAMU2.php?input_date=104/07/29&type=csv", destfile = "twse.csv")


#########################################################################
# Download zip
#########################################################################
download.file("http://www.taifex.com.tw/eng/eng3/hisdata_fut/2014_fut.zip", destfile="future_history_data.zip")
unzip("data/future_history_data.zip", exdir="data/")
