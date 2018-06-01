plotDT <- tempDT[obsDate == "2017-04-17"][matchDT, 
.(
nTweets = .N
), by = .(screenName)]

plotDT <- plotDT[order(nTweets)]
plotDT$screenName <- factor(plotDT$screenName,levels=plotDT$screenName)

doh <- ggplot(plotDT[!is.na(screenName)], aes(y = screenName, x = nTweets))

# Wind rose
doh + geom_bar(width = 1) + coord_polar()

plotDT <- tempDT[obsDate == "2017-04-17"][matchDT, 
.(
nTweets = .N
), by = .(screenName, obsDateTime5m, maxT)]

plotDT <- plotDT[order(plotDT$maxT,plotDT$obsDateTime5m)]
plotDT$screenName <- factor(plotDT$screenName,levels=plotDT$screenName)

# Race track plot
doh <- ggplot(plotDT, aes(x = screenName, y = obsDateTime5m, fill = nTweets))
doh + geom_tile(width = 0.9, position = "fill") + 
coord_polar(theta = "y") +
scale_fill_gradient(low="green", high = "red") +
scale_y_datetime(date_breaks = "2 hours", date_labels ="%d %b %H:%M")

