dashboardPage(
  dashboardHeader(title = "Dairy Production"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("How to Use", tabName = "tab_1"),
      menuItem("Base Time Series", tabName = "tab_2", icon = icon("dashboard")),
      menuItem("Further Analysis", tabName = "tab_3", icon = icon("th")),
      menuItem("Simple Forecasting", tabName = "tab_4", icon = icon("th")),
      menuItem("Exponential Smoothing", tabName = "tab_5", icon = icon("th")),
      menuItem("ARIMA Modeling", tabName = "tab_6", icon = icon("th")),
      menuItem("Surprise", tabName = "tab_7")
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
                  h4("- The 'Even Further Analysis' tab will present you with a seasonal naive model of your selected dairy product")
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
          box(plotOutput('MANUAL')),
          box(plotOutput('AUTO'))
        )
),

tabItem(tabName = "tab_7",
        fluidRow(
          box(img(src="Cow.gif", height = 500, width = 600))
        )
        )
                 
)
)
)

