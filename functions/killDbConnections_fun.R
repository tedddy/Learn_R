# use this function kill all open connections at once
killDbConnections <- function () { 
    all_cons <- dbListConnections(MySQL()) 
    print(all_cons) 
    for(con in all_cons) dbDisconnect(con) 
    print(paste(length(all_cons), " connections killed.")) 
}

killDbConnections()