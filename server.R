function(input, output){
  
  # df.true <- eventReactive(input$update,{
  #   
  # })
  # 
  # observeEvent(input$update, {
  #   if(df.forecast() %>% nrow == 0){
  #     showModal(modalDialog(
  #       title = "",
  #       "К сожалению, для указанной тренировочной выборки в данный момент нет данных.",
  #       easyClose = TRUE
  #     ))
  #   }
  #   
  # })
  # 
  # 
  # 
  # df.forecast <- eventReactive(input$update,{
  #   
  #   out <- out_true %>%
  #     dplyr::filter(model %in% input$model,
  #            
  #            startdt == input$startdt,
  #            enddt == input$enddt,
  #            h == input$h)
  #   
  #   
  #   if(input$optlag){
  #     optlag <- scoredf_raw %>%
  #       dplyr::filter(type == 'train',
  #              model %in% input$model,
  #              h == input$h,
  #              startdt == input$startdt,
  #              enddt == input$enddt
  #       ) %>%
  #       group_by(model) %>%
  #       dplyr::filter(rmse == min(rmse)) %>%
  #       dplyr::filter(lag == min(lag)) %>%
  #       ungroup %>%
  #       select(model, lag) %>%
  #       unique
  #     
  #     
  #     out %<>%
  #       split(.$model) %>%
  #       map_dfr(function(x){
  #         x %>%
  #           dplyr::filter(lag == optlag$lag[which(optlag$model ==
  #                                            (x$model %>% first))])
  #       })
  #     
  #     
  #     
  #   } else {
  #     
  #     out  %<>%
  #       dplyr::filter(lag == input$lag)
  #     
  #   }
  #   if(nrow(out) != 0){
  #     
  #     out %>%
  #       dplyr::filter(date >= c(ifelse(input$onlytrain,
  #                               enddt %>%
  #                                  as.Date %>%
  #                                  as.yearqtr %>%
  #                                  add(1/4) %>%
  #                                  as.yearqtr %>%
  #                                 as.Date,
  #                               date %>% min)))
  #   } else {
  #     data.frame()
  #   }
  # })
  # 
  # 
  # 
  # datebreaks <- eventReactive(input$update,{
  #   ifelse(input$onlytrain,
  #          '1 year',
  #          '5 years')
  # }
  # )
  # 
  # vlinealpha <- eventReactive(input$update,{
  #   ifelse(input$onlytrain,
  #          0,
  #          1)
  # }
  # )
  # 
  # limits <- eventReactive(input$update,{
  #   
  #   
  #   x <- c(df.forecast()$date %>% min,
  #          df.forecast()$date %>% max)
  #   ytrue_cut <- ytrue %>%
  #     diff.xts(lag = 4, log=TRUE) %>%
  #     .[paste0(x[1], '/', x[2])] %>%
  #     as.numeric
  #   
  #   
  #   y <- c(min(df.forecast()$pred, ytrue_cut),
  #          max(df.forecast()$pred, ytrue_cut))
  #   list(x = x, y = y)
  # }
  # )
  # 
  # 
  # 
  # 
  # 
  # output$forecast <- renderPlot({
  #   if(df.forecast() %>% nrow != 0){
  #     
  #     
  #     
  #     g_legend<-function(a.gplot){
  #       tmp <- ggplot_gtable(ggplot_build(a.gplot))
  #       leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  #       legend <- tmp$grobs[[leg]]
  #       return(legend)}
  #     
  #     p1 <- ggplot() + geom_line(data = NULL,
  #                                aes(x = ytrue %>%
  #                                      time %>%
  #                                      as.Date,
  #                                    y = ytrue %>%
  #                                      as.numeric %>%
  #                                      diff.xts(lag = 4, log=TRUE),
  #                                    color='Исходный ряд',
  #                                    linetype = 'Исходный ряд',
  #                                    size = 'Исходный ряд'))+
  #       geom_rect(aes(xmin=(df.forecast()$enddt %>% min + 100) %>% as.yearqtr %>% as.Date,
  #                     xmax=(df.forecast()$enddt %>% min + 366*2) %>% as.yearqtr %>% as.Date,
  #                     ymin=-Inf, ymax=Inf,
  #                     fill="Тестовая выборка"),
  #                 alpha=0.2)+
  #       
  #       scale_fill_manual(values = 'black')+
  #       
  #       scale_color_manual(values = 'black')+
  #       scale_linetype_manual(values = 'dotted')+
  #       scale_size_manual(values = 1)+
  #       guides(colour = guide_legend(""),
  #              size = guide_legend(""),
  #              linetype = guide_legend(""),
  #              fill = guide_legend(" "))+
  #       theme(legend.position="right",
  #             legend.justification="left",
  #             legend.margin=ggplot2::margin(0,0,0,0),
  #             legend.box.margin=ggplot2::margin(10,10,10,10))
  #     
  #     p2 <- ggplot() +
  #       geom_line(data = df.forecast(),
  #                 aes(x = date,
  #                     y = pred,
  #                     color = model), size = 1) +
  #       scale_color_discrete(name = "Модель")+
  #       theme(legend.position="right",
  #             legend.justification="left",
  #             legend.margin=ggplot2::margin(0,0,0,0),
  #             legend.box.margin=ggplot2::margin(10,10,10,10))
  #     
  #     
  #     
  #     
  #     
  #     
  #     p <- ggplot() +
  #       geom_line(data = df.forecast(),
  #                 aes(x = date,
  #                     y = pred,
  #                     color = model), size = 1) +
  #       geom_line(data = NULL,
  #                 aes(x = ytrue %>%
  #                       time %>%
  #                       as.Date,
  #                     y = ytrue %>%
  #                       as.numeric %>%
  #                       diff.xts(lag = 4, log=TRUE)
  #                 ),
  #                 color='black',
  #                 size = 1, linetype="dotted")+
  #       scale_color_discrete(guide="none")+
  #       
  #       
  #       scale_x_date(date_breaks = datebreaks(),
  #                    labels=date_format("%Y"),
  #                    limits = limits()$x)+
  #       scale_y_continuous(limits = limits()$y)+
  #       
  #       
  #       geom_vline(aes(xintercept  = as.Date(df.forecast()$enddt %>% min)),
  #                  color = "red",linetype="dashed", alpha = vlinealpha())+
  #       geom_rect(aes(xmin=(df.forecast()$enddt %>% min + 100) %>% as.yearqtr %>% as.Date,
  #                     xmax=(df.forecast()$enddt %>% min +366*3) %>% as.yearqtr %>% as.Date,
  #                     ymin=-Inf, ymax=Inf),
  #                 fill="black", alpha=0.2)+
  #       
  #       labs(title = "",
  #            y = "Изменение инвестиций (log)",
  #            x = "Дата")+
  #       theme_minimal()
  #     
  #     
  #     
  #     
  #     grid.arrange(p,
  #                  arrangeGrob(g_legend(p2),g_legend(p1), nrow=2),
  #                  ncol=2,widths=c(7,1))
  #     
  #     
  #   }
  #   
  #   
  #   
  #   
  #   
  # })
  # 
  # 
  # 
  # df.score <- eventReactive(input$update,{
  #   
  #   
  #   
  #   scoredf <- switch(input$scoretype,
  #                     'absolute' = scoredf_raw,
  #                     'relate' = scoredf)
  #   scoredf %<>% 
  #     dplyr::filter(type == 'test',
  #            model %in% input$model,
  #            h == input$h,
  #            startdt == input$startdt,
  #            enddt == input$enddt
  #     )
  #   if(input$optlag) {
  #     scoredf %<>%
  #       inner_join(optlag,
  #                  by = c('startdt', 'enddt', 'h', 'model', 'lag'))
  #   } else{
  #     scoredf %<>%
  #       dplyr::filter(lag == input$lag) %>% print
  #   }
  #   scoredf %>%
  #     select(model, rmse) 
  #   
  # })
  # 
  # output$score <- renderDataTable({
  #   datatable(df.score(),
  #             colnames = c('Модель', 'RMSFE'),
  #             rownames = FALSE,
  #             options = list(dom = 'tip', 
  #                            
  #                            order = list(list(1, 'asc'))
  #             )) %>%
  #     formatRound(columns=c(2), digits=3)
  # })
  
  
  image.size <- function(){
    if(input$model_type_hair == 'divide'){
      width = 3.5*length(input$startdt_hair) 
    } else {
      width = 3.5
    }
    
    
    if(input$startdt_type_hair == 'divide'){
      height = 2.5*length(input$model_hair)
      
    } else {
      height = 2.5
    }
    
    
    c(width = width, 
      height=height)
  }
   #  eventReactive(input$update,{
   #  
   #  
   # }) 
   # 
  df.hair <- function(){
    
    out_hair %>%
      dplyr::filter(model %in% input$model_hair) %>%
      print %>%
    dplyr::filter(
             startdt %in%  (input$startdt_hair %>% as.Date),
             h >= input$h_hair[1] %>% as.integer,
             h <= input$h_hair[2] %>% as.integer
             ) 
  }
  
  df.true <- function(){
    out_hair %>%
      
      filter(model %in% input$model_hair) %>%
      dplyr::filter(
        startdt %in%  (input$startdt_hair %>% as.Date),
        h ==0 %>% as.integer
      ) %>%
     print %>%
      na.omit 
  }
  # реализует gif через animate
  hairplot <- function(static_direct = FALSE){
    df <- df.hair()
    df_true <- df.true()
    
    
    {(df %>%
        ggplot()+
        
        geom_line(data = df_true
                  ,mapping = aes(x = date,
                                 y = true),
                  color='grey',
                  size = 2,
                  linetype = 'solid',
                  alpha = 0.5)
    )} %>%
      # два facet
      hair.model.forecast() %>%
      # оформление
      hair.theme() %>%
      
      
      # если динамический, то через gganimate
      (function(x){
        
        if(input$play == 'stat'| static_direct){
          x
        } else {
          x+ 
            transition_reveal(giftime) +
            ease_aes('linear')
        }
      })
    
    
    
  }
  
  hair.model.forecast <- function(x) {if(input$startdt_type_hair == 'divide' & input$model_type_hair == 'divide')
  {x +
      geom_line(aes(x = date,
                    y = pred,
                    group = forecastdate),
                linetype = 'dashed',
                color = 'cornflowerblue',
                alpha = 0.8,
                size = 0.8)+
      facet_grid(model~startdt)
  } 
    else if(input$startdt_type_hair == 'divide' & input$model_type_hair == 'together'){x +
        geom_line(aes(x = date, y = pred,
                      group = interaction(forecastdate, model),
                      color = model),
                  linetype = 'dashed',
                  alpha = 0.8,
                  size = 0.8)+
        facet_grid(.~startdt)
      } 
    else if(input$startdt_type_hair == 'divide' & input$model_type_hair == 'mean')
    {x+
        stat_summary(aes(x = date, y = pred, group = forecastdate),
                     geom = 'line',
                     linetype = 'dashed',
                     color = 'cornflowerblue',
                     alpha = 0.8,
                     size = 0.8,
                     fun.y=mean)+
        facet_grid(.~startdt)
      
    }
    else if(input$startdt_type_hair == 'together' & input$model_type_hair == 'divide'){
      x+ geom_line(aes(x = date, y = pred,
                       group = interaction(forecastdate, startdt),
                       linetype = as.factor(startdt)),
                   alpha = 0.8,
                   color = 'cornflowerblue',
                   size = 0.8)+
        facet_grid(model~.)+
        scale_linetype_manual(name="Type",values=c(2,3), guide="none")
    }
    else if(input$startdt_type_hair == 'together' & input$model_type_hair == 'together'){
      x+ geom_line(aes(x = date, y = pred,
                       group = interaction(forecastdate, startdt, model),
                       color = model,
                       linetype = as.factor(startdt)),
                   alpha = 0.8,
                   size = 0.8)+
        scale_linetype_manual(name="Type",values=c(2,3), guide="none")
    }
    else if(input$startdt_type_hair == 'together' & input$model_type_hair == 'mean'){
      x+
        stat_summary(aes(x = date, y = pred, 
                         group = interaction(forecastdate, startdt),
                         linetype = as.factor(startdt)),
                     geom = 'line',
                     alpha = 0.8,
                     size = 0.8,
                     color = 'cornflowerblue',
                     fun.y=mean)+
        scale_linetype_manual(name="Type",values=c(2,3), guide="none")
    }
    else if(input$startdt_type_hair == 'mean' & input$model_type_hair == 'divide'){
      x+
        stat_summary(aes(x = date, y = pred, group = forecastdate),
                     geom = 'line',
                     linetype = 'dashed',
                     color = 'cornflowerblue',
                     alpha = 0.8,
                     size = 0.8,
                     fun.y=mean)+
        facet_grid(model~.)
    }
    else if(input$startdt_type_hair == 'mean' & input$model_type_hair == 'together'){
      x+
        stat_summary(aes(x = date, y = pred, 
                         group = interaction(forecastdate, model), color = model),
                     geom = 'line',
                     linetype = 'dashed',
                     alpha = 0.8,
                     size = 0.8,
                     fun.y=mean)
    }
    else if(input$startdt_type_hair == 'mean' & input$model_type_hair == 'mean'){
      x+
        stat_summary(aes(x = date, y = pred, 
                         group = interaction(forecastdate)),
                     color = 'cornflowerblue',
                     geom = 'line',
                     linetype = 'dashed',
                     alpha = 0.8,
                     size = 0.8,
                     fun.y=mean)
    }
  }
  hair.theme <- function(x){
    df <- df.hair()
    df_true <- df.true()
    x+
      
      labs(title = "",
           y = "Изменение инвестиций (log)",
           x = "Дата")+
      scale_size_manual(values = 1) +
      guides(colour = guide_legend(""),
             size = guide_legend(""),
             linetype = guide_legend(""),
             fill = guide_legend(" "))+
      theme_minimal()+
      theme(legend.position = "none") +
      scale_x_date(limits = c(df_true %>% pull(date) %>% as.Date %>% min,
                              df %>% pull(date) %>% as.Date %>% max)) +
      scale_y_continuous(limits = c(min(df %>% pull(pred) %>% as.numeric %>% na.omit %>% min,
                                        df_true %>% pull(true) %>% as.numeric %>% na.omit %>% min),
                                    max(df %>% pull(pred) %>% as.numeric %>% na.omit %>% max,
                                        df_true %>% pull(true) %>% as.numeric %>% na.omit %>% max)))
    
  }
  
  # реализует gif для функции saveFIG в виде отдельных фреймов для использования цикла по ним
  hair.frameplot <- function(i){
    df <- df.hair() %>% filter(giftime <= i)
    df_true <- df.true()
    
    {(df %>%
        ggplot()+
        
        geom_line(data = df_true 
                  ,mapping = aes(x = date,
                                 y = true),
                  color='grey',
                  size = 2,
                  linetype = 'solid',
                  alpha = 0.5)
    )} %>%
      # два facet
      hair.model.forecast() %>%
      # оформление
      hair.theme()
      
  }
  
  #set up function to loop through the draw.a.plot() function
  loop.animate <- function() {
    frames <- df.hair() %>%
      pull(giftime) %>%
      unique %>%
      sort()
    lapply(frames, function(i) {
      hair.frameplot(i) %>% print
    })
  }
  
  
  hairimage <- eventReactive(input$update_hair,{
    if(input$play == 'dinamic'){
      outfile <- tempfile(fileext='.gif')
    } else {
      outfile <- tempfile(fileext='.png')
    }
    
    p <- hairplot()
    
    
    sizes <- image.size()
    #sizes['width'] = 400
    #sizes['height'] = 400
    
    
    
    if(input$play == 'dinamic'){
      anim_save("outfile.gif", animate(p)) 
      
      list(src = "outfile.gif",
           contentType = 'image/gif',
           width=sizes['width'],
           height=sizes['height']
           # alt = "This is alternate text"
      )
    } else {
      
      
      # Generate a png
      png(outfile,
          width=sizes['width'], height=sizes['height'],
          # width     = 3.25,
          # height    = 3.25,
          units     = "in",
          res       = 180,
          pointsize = 2,
          type = "cairo")
      print(p)
      dev.off()
      
      # Return a list
      list(src = outfile,
           alt = "This is alternate text")
    }
  })
  
  
  output$hair <- renderImage({
    hairimage()
    
    
  }, deleteFile = TRUE)
  
  output$downloadgif = downloadHandler(
    filename = 'forecast.gif',
    content  = function(file) {
      outfile <- tempfile(fileext='.gif')
      sizes <- image.size()
      saveGIF(
        loop.animate(),
        movie.name = 'forecast.gif',
        interval = 0.1,
        clean = TRUE,
        ani.width=sizes['width'],
        ani.height=sizes['height'])
      
      file.rename('forecast.gif', file)
    })
  
  
  output$downloadpng <- downloadHandler(
    filename = 'forecast.png',
    content = function(file) {
      sizes <- image.size()
      png(file, width=sizes['width'], height=sizes['height'])
      hairplot(static_direct = TRUE) %>% print
      dev.off()
      
    }
  )
  
}
  

