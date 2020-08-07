library(shiny)



fluidPage(
  titlePanel('currency and stocks'),
  
  sidebarLayout(
    
  sidebarPanel(
    
    # selectizeInput('Crypto',
    #                'ticker',
    #                choices=unique(crypto_df$ticker)
    #               ),
    
    
    checkboxGroupInput("assets",
                       "Cryptos",
                       choices=unique(crypto_df$ticker),
                       selected =unique(crypto_df$ticker)[1]),
    
    checkboxGroupInput("stock_assets",
                       "Stocks",
                       choices=unique(STOCK$ticker),
                       selected =unique(STOCK$ticker)[3]),
    
    h4('Others'),
    
    checkboxInput("INF", "Inflation", FALSE),
    
    checkboxInput("GLD", "Gold", FALSE),
    
    checkboxInput("DEBT", "Debt", FALSE),
    
   dateInput('start_date',
             'From',
             min(crypto_df$trade_date)
             ),
   dateInput('end_date',
             'To',
             max(crypto_df$trade_date)
   )
    
  ),  
  
  mainPanel( 
    
    tabsetPanel( position = "below",
    tabPanel("all", plotOutput("plt0") ,verbatimTextOutput("Ret0") ),
    tabPanel("crypto", plotOutput("plt1") ,verbatimTextOutput("Ret1") ),
    tabPanel("stock", plotOutput("plt2")),
    tabPanel("gold", plotOutput("plt3")) ,
    tabPanel("Inflation", plotOutput("plt4"))
    #plotOutput('plt')
    
  )  
    
  ) 
  
  )
  
)