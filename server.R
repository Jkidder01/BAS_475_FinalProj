function(input,output,session){
  
  output$dairy_use <- renderPrint({ input$Dairy })  

  output$MilkTS <- renderPlot( {
    
        ggplot(Milk_ts, aes_string("Date",input$Dairy)) +
          geom_line()+
          labs(title = "Average Volume Produced")

    })
  
  
  output$plot_type <- renderPrint({ input$plot_type })

  
  observeEvent(input$plot_type, {
    if(input$plot_type == 1){
      output$anaplot <- renderPlot({gg_season(Milk_ts[,c("Date",input$Dairy)])})
  }
    if(input$plot_type == 2){
      output$anaplot <- renderPlot({gg_lag(Milk_ts[,c("Date",input$Dairy)])})
  }
    if(input$plot_type == 3){
      output$anaplot <- Milk_ts[,c("Date",input$Dairy)]%>%
        model(classical_decomposition(type = "multiplicative"))%>%
        components() %>%
        autoplot() %>%
        renderPlot()
  }
    })
  
  observeEvent(input$Dairy, {
    if(input$Dairy == "Cotagecheese.Prod"){
      output$analysis <- renderUI("Our cottage cheese production time series is the only one win which a negative trend is observed, alongside some apparent seasonality.
                                  Upon further analysis we see that there is a slight presence of seasonality, especially in the earlier years, of cottage cheese with it rising around May-June.
                                  However in recent years there is less of a discernable seasonality present with production levels rising and falling in differing intervals.
                                  Our AutoCorrelation chart shows that there is a strong correlation between previous months and this month's production level, regardless of the
                                  number of months you look back. Finally our decomposition chart corroborates much of what we said before, there is an apparent downward trend in
                                  cottage chees production, alongside some apparent seasonality.")
    }
    if(input$Dairy == "Icecream.Prod"){
      output$analysis <- renderUI("Upon first looking at the Icecream Production time series 
                                  the presence of a strong seasonality becomes immediately apparent, 
                                  and upon analyzing further we are able to see more clearly just what is occuring here.
                                  Our seasonality chart shows that production of Ice cream is consistently increasing during
                                  summer months while falling in the winter months. This is also corroberated when we analyze the AutoCorrelation chart.
                                  Our AutoCorrelation chart shows that the most influential months in predicting ice cream production
                                  are those one month prior (positively correlated) or six months prior (negatively correlated). This make sense, because if you're in a summer or winter season 
                                  you would expect last month's icecream productions to be a fairly reliable predictor of how much we should produce in the current month,
                                  while if you're in a particular season you would expect that six months ago (the opposite season) you would want to be producing the opposite 
                                  than what you had been since the seasons had since changed. Finally our decomposition chart helps reinforce this presence of a strong
                                  seasonal pattern, while also showing that there has been an overall upward trend in icecream production in recent years.")
    }
    if(input$Dairy == "Milk.Prod"){
      output$analysis <- renderUI("The milk production time series presents a very strong upward trend in production levels, with some fluctuations present 
                                  most likely due to seasonality. Upon further analysis we see from the seasonality chart the milk production appears to peak
                                  around March-May with it steadily falling off in the summer and winter months. This may be due in part to cows' consumption
                                  levels falling in the hot summer months making them less capable of producing milk. The autocorrelation chart shows that, when it comes to predicting
                                  a given month's production values, that looking back any number of months could help you to predict this month's production. This is probably because of the 
                                  consistent demand for milk regardless of season. Finally our decomposition chart shows the strong upward trend in milk production alongside the seasonal pattern
                                  we observed in our seasonality chart.")
    }
  })
  
  observeEvent(input$Dairy, {
    
    output$NAIVE <- renderPlot({
      
      forecast_data <- Milk_ts[, c('Date', input$Dairy)]
      
      fit <- forecast_data %>%
        model(NAIVE())
      
      fit %>%
        forecast() %>%
        autoplot(Milk_ts) +
        labs(title = "Naïve model")
    })
    
  })

observeEvent(input$Dairy, {
  
  output$SNAIVE <- renderPlot({
    
    forecast_data <- Milk_ts[, c('Date', input$Dairy)]
    
    fit <- forecast_data %>%
       model(SNAIVE())
    
    fit %>%
      forecast() %>%
      autoplot(Milk_ts) +
      labs(title = "Seasonal naïve model")
  })
  
})

observeEvent(input$Dairy, {
  
  output$MEAN <- renderPlot({
    
    forecast_data <- Milk_ts[, c('Date', input$Dairy)]
    
    fit <- forecast_data %>%
      model(MEAN())
    
    fit %>%
      forecast() %>%
      autoplot(Milk_ts) +
      labs(title = "Mean model")
  })
  
})

observeEvent(input$Dairy, {
  
  output$DRIFT <- renderPlot({
    
    forecast_data <- Milk_ts[, c('Date', input$Dairy)]
    
    fit <- forecast_data %>%
      model(RW(~trend()))
    
    fit %>%
      forecast() %>%
      autoplot(Milk_ts) +
      labs(title = "Drift model")
  })
  
})

observeEvent(input$Dairy, {
  
  output$HETS <- renderPlot({
    
    forecast_data <- Milk_ts[, c('Date', input$Dairy)]
    
    fit <- forecast_data %>%
      model(ETS(~ trend("A") + season("N")))
    
    fit %>%
      forecast(h='5 years')%>%
      autoplot(Milk_ts) +
      labs(title = "Holts smoothing model")
    
  })
  
})
  
observeEvent(input$Dairy, {
  
  output$HWETS <- renderPlot({
    
    forecast_data <- Milk_ts[, c('Date', input$Dairy)]
    
    fit <- forecast_data %>%
      model(ETS(~ trend("A") + season("M")))
    
    fit %>%
      forecast(h='5 years')%>%
      autoplot(Milk_ts) +
      labs(title = "Holts/Winters smoothing model")
    
  })
  
})

observeEvent(input$Dairy, {
  
  output$MANUAL <- renderPlot({
    
    forecast_data <- Milk_ts[, c('Date', input$Dairy)]
    
    fit <- forecast_data %>%
      model(ARIMA())
    
    fit %>%
      forecast(h='5 years')%>%
      autoplot(Milk_ts) +
      labs(title = "Manual ARIMA Model")
    
  })
  
})

observeEvent(input$Dairy, {
  
  output$AUTO <- renderPlot({
    
    forecast_data <- Milk_ts[, c('Date', input$Dairy)]
    
    fit <- forecast_data %>%
      model(ARIMA())
    
    fit %>%
      forecast(h='5 years')%>%
      autoplot(Milk_ts) +
      labs(title = "Automatic ARIMA Model")
    
  })
  
})

}

