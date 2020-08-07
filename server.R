

class(crypto_df$trade_date)
  
  
  function(input,output,sessionInfo){
  
  output$plt0=renderPlot(
    
    create_all_plot(input$assets,input$stock_assets,input$INF,input$GLD,input$start_date,input$end_date)
    
  )
    
    
  output$plt1=renderPlot(

    #create_plot(crypto_df,'BTC',as.Date('2017-01-01'),as.Date('2020-01-01'))

    #create_plot(crypto_df,input$Crypto,as.Date('2017-01-01'),as.Date('2020-01-01'))
    if (length(input$assets)>0) create_plot(crypto_df,input$assets,input$start_date,input$end_date)
    
  )
  
  
  output$plt2=renderPlot(
    
    #create_plot(crypto_df,'BTC',as.Date('2017-01-01'),as.Date('2020-01-01'))
    
    #create_plot(crypto_df,input$Crypto,as.Date('2017-01-01'),as.Date('2020-01-01'))
    if(length(input$stock_assets)) create_plot(STOCK,input$stock_assets,input$start_date,input$end_date)
  )
  
  
  output$plt3 = renderPlot(
    if(input$GLD) create_gold_plot(Gold,input$start_date,input$end_date)
  )
  
  
 output$plt4=renderPlot(
   if (input$INF) create_inflation_plot(Fiat,input$start_date,input$end_date)
 )
 

  
  
  output$Ret1 <- renderPrint({
    # if 
    cat('profit: ',Ret(crypto_df,input$Crypto,input$start_date,input$end_date),'%',sep='')
  })
  
  
  
  # output$plt5=renderPlot(
  #   
  #   create_plot(Fiat,input$start_date,input$end_date)
  #   
  # )
  
  
  # output$Ret1=  renderInfoBox({
  #   infoBox(
  #     1,caption='abc'
  #    # Ret(crypto_df,input$Crypto,input$start_date,input$end_date)
  #   )
  # })
   
  }
