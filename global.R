
library(shiny)
library(ggplot2)
library(dplyr)

STOCK=read.csv('Stocks.csv')
STOCK$trade_date=as.Date(STOCK$trade_date)

Gold=read.csv('GOLD.csv')
Gold$trade_date=as.Date(Gold$trade_date)

Gold2=Gold
Gold2$ticker='Gold'

Fiat=read.csv('Fiat.csv')
Fiat$Date=as.Date(Fiat$Date)

crypto_df=read.csv('crypto_df_clean.csv')
crypto_df$trade_date=as.Date(crypto_df$trade_date)

create_all_plot=function(assets,stock_assets,INF,GLD,start_date,end_date){
  date_cond = (crypto_df$trade_date>=beg_date & crypto_df$trade_date<=end_date)
  asset_cond = (crypto_df$ticker %in% assets) 
  df1=crypto_df[date_cond & asset_cond,c('trade_date','ticker','price_usd')]
  
  date_cond = (STOCK$trade_date>=beg_date & STOCK$trade_date<=end_date)
  asset_cond = (STOCK$ticker %in% stock_assets) 
  df2=STOCK[date_cond & asset_cond,c('trade_date','ticker','price_usd')]
  
  date_cond = (Gold2$trade_date>=beg_date & Gold2$trade_date<=end_date)
  asset_cond = (Gold2$ticker %in% GLD) 
  df3=Gold2[date_cond & asset_cond,c('trade_date','ticker','price_usd')]
  
  
  df=rbind(df1,df2,df3)
  
  plt = ggplot(df,aes(x=trade_date,y=price_usd)) + 
    geom_line(aes(color=ticker) )
  
  return(plt)
}

select_data_to_plot=function(df,ticker,beg_date,end_date){
  
  reduce_df= df[df$ticker==ticker,c('trade_date','price_usd')]
  reduce_df=reduce_df[reduce_df$trade_date>=beg_date & reduce_df$trade_date<=end_date,]
  
  return(reduce_df)
}

create_plot=function(df,assets,beg_date,end_date){
  
  date_cond = (df$trade_date>=beg_date & df$trade_date<=end_date)
  asset_cond = (df$ticker %in% assets) 
  reduce_df=df[date_cond & asset_cond,]
  
  #plt=plot(reduce_df$trade_date,reduce_df$price_usd, type='l')
  
  plt = ggplot(reduce_df,aes(x=trade_date,y=price_usd)) + 
    geom_line(aes(color=ticker) )
  
  
  
  return(plt)
}

Ret=function(df,ticker,beg_date,end_date){
  
  reduce_df=select_data_to_plot(df,ticker,beg_date,end_date)
  
  #r=max(reduce_df$trade_date)-reduce_df$price_usd
  beg_date_price=reduce_df %>% filter(.,trade_date==beg_date) %>% select(.,price_usd) 
  beg_date_price=beg_date_price$price_usd
  end_date_price=reduce_df %>% filter(.,trade_date==end_date) %>% select(.,price_usd) 
  end_date_price=end_date_price$price_usd
  Profit=round((end_date_price - beg_date_price)/beg_date_price*100,2)
  return (Profit)
  #return((end_date_price - beg_date_price)/beg_date_price*100)
}


select_data_to_plot22=function(df,beg_date,end_date){
  
  #reduce_df= df[df$ticker==ticker,c('trade_date','price_usd')]
  #Reduce_df=Fiat
  reduce_df=Fiat[Fiat$Date>=beg_date & Fiat$Date<=end_date,]
  
  return(reduce_df)
}

create_inflation_plot=function(df,beg_date,end_date){
  
  reduce_df=select_data_to_plot22(df,beg_date,end_date)
  
  #plt=plot(reduce_df$Date,reduce_df$Inflation.Rate, type='l')
  
  plt=ggplot(reduce_df,aes(x=reduce_df$Date,y=reduce_df$Inflation.Rate)) + 
    geom_line()
  return(plt)
}




create_gold_plot=function(df,beg_date,end_date){
  

  reduce_df=df[df$trade_date>=beg_date & df$trade_date<=end_date,]

  
  plt=ggplot(reduce_df,aes(x=trade_date,y=price_usd)) +
    geom_line()
  
  return(plt)
} 

