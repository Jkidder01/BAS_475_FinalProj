dashboardPage(
  dashboardHeader(title = "Dairy Production"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("How to Use", tabName = "tab_1"),
      menuItem("Base Time Series", tabName = "tab_2", icon = icon("dashboard")),
      menuItem("Further Analysis", tabName = "tab_3", icon = icon("th")),
      menuItem("Simple Forecasting", tabName = "tab_4", icon = icon("th")),
      menuItem("Exponential Smoothing", tabName = "tab_5", icon = icon("th")),
      menuItem("Manual ARIMA Modeling", tabName = "tab_6", icon = icon("th")),
      menuItem("Automatic ARIMA Modeling", tabName = "tab_7", icon = icon("th")),
      menuItem("Surprise", tabName = "tab_8")
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "tab_1",
              fluidPage(
                titlePanel("How to Use the Following ShinyApp"),
                mainPanel(
                  h4("The following ShinyApp will allow you to analyze the time-ordered dataset Milk"),
                  h4("- Upon navigating to the 'Base Time Series' tab you will be able to choose a dairy product of interest"),
                  h4("- Upon choosing your variable of interest a time series will be produced showing that particular products production since Jan1995"),
                  h4("- Upon navigating to the 'Further Analysis' tab you will be asked to choose your desired time-series analysis"),
                  h4("     --- Seasonality will produce a seasonal time series plot"),
                  h4("     --- AutoCorrelation will produce a lag plot of our dataset"),
                  h4("     --- Decomposition will break down our time series into its seasonal, trend, and irregular components"),
                  h4("The following tabs will show you a series of analyses pertaining to your desired product of interest;"),
                  h4("- Simple Forecasting will provide a Naive, Seasonal Naive, Mean and Drift Model of your desired product of interest"),
                  h4("- Exponential Smoothing will provide both a Holts and Holt-Winters forecast of your desired product of interest"),
                  h4("- Manual ARIMA Modeling will allow you to choose values of pdq() + PDQ() to perform an ARIMA forecast on your desired product of interest"),
                  h4("- Automatic ARIMA Modeling will provide you with the computer chosen ARIMA forecast of your desired product of interest")
                )
              )
      ),
      tabItem(tabName = "tab_2",
              fluidRow(
                box(
                  selectInput("Dairy", label = h3("Select Desired Dairy Product"), 
                              choices = c("Cotagecheese.Prod",
                                             "Icecream.Prod", "Milk.Prod"))
                ),
                
                box(plotOutput('MilkTS'))
)
      ),
      
      tabItem(tabName = "tab_3",
                 fluidRow(
                   
                   box(  selectInput("plot_type", label = h3("Select Desired Analysis"), 
                                     choices = list("Seasonality" = 1, "AutoCorrelation" = 2, "Decomposition" = 3), 
                                     selected = 1)
                         ),
                   
                   box(plotOutput('anaplot')),
                   
                   box(uiOutput('analysis')

                   
      )
)
      ),

tabItem(tabName = "tab_4",
        fluidRow(
          box(plotOutput('NAIVE')),
          box(plotOutput('SNAIVE')),
          box(plotOutput('MEAN')),
          box(plotOutput('DRIFT'))
        )
        ),

tabItem(tabName = "tab_5",
        fluidRow(
          box(plotOutput('HETS')),
          box(plotOutput('HWETS'))
        )
        ),

tabItem(tabName = "tab_6",
        fluidRow(
          box(
            selectInput("p", label = h3("Select Autoregression Value"),
                        choices = list("0" = 0, "1" = 1, "2" = 2),
                        selected = 1),
            selectInput("d", label = h3("Select Differencing Value"),
                        choices = list("0" = 0, "1" = 1, "2" = 2),
                        selected = 1),
            selectInput("q", label = h3("Select Moving Average Value"),
                        choices = list("0" = 0, "1" = 1, "2" = 2),
                        selected = 1),
            selectInput("ps", label = h3("Select Seasonal Autoregression Value"),
                        choices = list("0" = 0, "1" = 1, "2" = 2),
                        selected = 1),
            selectInput("ds", label = h3("Select Seasonal Differencing Value"),
                        choices = list("0" = 0, "1" = 1, "2" = 2),
                        selected = 1),
            selectInput("qs", label = h3("Select Seasonal Moving Average Value"),
                        choices = list("0" = 0, "1" = 1, "2" = 2),
                        selected = 1),
            
          ),
          box(plotOutput('MANUAL'))
        )
),

tabItem(tabName = "tab_7",
        fluidRow(
          box(plotOutput('AUTO')),
        )
        ),

tabItem(tabName = "tab_8",
        fluidRow(
          box(img(src="Cow.gif", height = 500, width = 600))
        )
        )
                 
)
)
)

