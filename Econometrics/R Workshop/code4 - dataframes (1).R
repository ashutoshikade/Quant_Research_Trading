# Data Frame (like an Excel spreadsheet)
    # make a list, convert to dataframe
    set.seed(1234)
    mylist <- list(
        col1 = 1:10,
        col2 = round(runif(n=10, min=25, max=75), 2),
        col3 = sample(x=letters[23:26], size=10, replace=TRUE)
    )

    mylist

    df1 <- as.data.frame(mylist)
    df1

    # exact same dataframe, but this time directly
    set.seed(1234)
    df2 <- data.frame(
        col1 = 1:10,
        col2 = round(runif(10, 25, 75), 2),
        col3 = sample(letters[23:26], 10, replace=T),
        stringsAsFactors = T
    )
    df2

# dataframe basics
    length(df1)
    ncol(df1)
    nrow(df1)
    dim(df1)
    names(df1)
    colnames(df1)
    rownames(df1)
    head(df1)
    tail(df1)
    str(df1)
    summary(df1)
    View(df1) # <-- new window! notice the capital "V"

# Factors -- "categorical" variables
    
    df2$col3 <- as.factor(df2$col3)
    
    df2
    str(df2)
    
    model.matrix( ~ 0 + df2$col3)
    model.matrix( ~ df2$col3)

    levels(df1$col3)

    as.integer(df1$col3)

    table(df1$col3)

    # the old days!
    df3 <- data.frame(
        col1 = 1:10,
        col2 = round(runif(10, 25, 75), 2),
        col3 = sample(letters[1:4], 10, replace=T),
        stringsAsFactors = TRUE       # <-- default was true, is now false
    )
    str(df3)

# subset - extract columns like they're list elements
    # dollar sign
    df1$col1

    # double brackets
    df1[[2]]
    class(df1[[2]])
    df1[["col2"]]
    df1[[col2]] # error -- what is the object 'col2'? it doesn't exist

    # single brackets (returns a data.frame!)
    df1["col3"]
    class(df1["col3"])

    lapply(df1[ , c("col1", "col2")], mean)
    sapply(df1[ , c("col1", "col2")], sum)

# extract subset of rows (like rows of a matrix)
    df1[df1$col2 < 50, "col1"]
    df1[df1$col2 < 50, ]
    
# subset of rows and cols (just put row and col subsetting together)
    df1[1:3, c("col2", "col3")]
    df1[c("col2", "col3")][1:3, ]
    df1[1:3, 2:3]

    colnamevec <- c("col2", "col3")
    df1[1:3, colnamevec]

# create a new column
    df1$newcol <- df1$col1*7 + df1$col2
    df1$newcol
    df1

    # same name overwrites the column
    df1$newcol <- df1$newcol * 2
    df1
    
    # assigning null to a column deletes it
    df1$newcol <- NULL
    df1

    # replace just some values
    df1[df1$col1<5, "col1"] <- 96:99
    df1

# sort the dataframe
    df1$col1
    sort(df1$col1)
    order(df1$col1)

    df1[order(df1$col1), ]
    df1 <- df1[order(df1$col1), ]
    df1
    
# reorder columns
    new_ord <- sort(names(df1), decreasing = TRUE)
    df1 <- df1[ , new_ord]
    df1

# summarizing (collapsing / aggregating) a dataframe
    set.seed(9898)
    df <- data.frame(
        ints = sample(1:100, 100, T),
        lets = sample(letters[1:10], 100, T),
        caps = sample(LETTERS[1:10], 100, T),
        stringsAsFactors = TRUE
    )
    
    str(df)
    summary(df)
    
    # aggregate -- args take lists
    ?aggregate
    aggregate(df$ints, by=df["lets"], mean)
    
    # aggregate -- args take a formula
    aggregate(ints ~ lets, data=df, mean)
    
    # aggregate -- multiple subsetting criteria
    aggregate(df$ints, by=df[, c("lets", "caps")], length)
    aggregate(ints ~ lets + caps, data=df, length)
    
    # table() does counts, but doesn't return a data.frame
    table(df$lets)
    class(table(df$lets))
    
    table(df$lets, df$caps)
    
    
# Combining dataframes
    
    df1 <- data.frame(
        aa = 1:4,
        bb = c("a", "b", "c", "d"),
        cc = LETTERS[1:4]
    )
    
    df2 <- data.frame(
        aa = 2:5,
        bb = c("w", "x", "y", "z"),
        cc = LETTERS[23:26]
    )
    
    df1
    df2
    
    # stack on top, must have same colnames
    rbind(df1, df2)
    
    # align side-by-side, not usually what you want to do
    names(df2)[2:3] <- c("pp", "qq")
    df2
    cbind(df1, df2)
    
    # merge (aka "join")
    merge(df1, df2, by="aa")          # inner join
    merge(df1, df2, by="aa", all.x=T) # left join
    merge(df1, df2, by="aa", all.y=T) # right join
    merge(df1, df2, by="aa", all=T)   # outer join
    

# getting data in and out of R
    
    # write a data.frame to a .csv file
    # write.csv(data_frame_name, file="/path/to/file/filename.csv")
    
    write.csv(df1, "df1.csv")
    write.csv(df1, "df1.csv", row.names=F)
    
    # data in (from .csv file to an R data.frame object)
    # my_df <- read.csv("path/to/file/filename.csv")
    
    new_df <- read.csv("df1.csv")
    
    
    # save one or more objects into a RData file
    save(obj1, obj2, file="path/to/file/filename.RData")
    
    # read those R objects back in (they will already be named)
    load("path/to/file/filename.RData") 
    
    
    
## PRACTICE QUESTIONS

    # load the "mtcars" dataset like this:
    data(mtcars)
    mtcars
    
    
    #1. Are any variables factors?
    YES
    
    
    
    #2. calculate the average miles per gallon of cars in the mtcars dataset
    df1 <- data.frame(mtcars)
    df1
    mean(df1[["mpg"]])
    
    
    #3. how many cars (ie, observations or rows) have each number of cylinders? (use "table")
    df1
    table(df1$cyl)
    
    
    #4. make a new variable called "carname".  Populate that column with the rownames of the mtcars dataframe
    df1$carname <- rownames(df1)
    df1
    
    
    #5. create a dummy (0/1) variable to indicate which cars are Mercedes:
          # hint: use grepl("Merc", ...) where you fill in the ...
          # aside: the name grep comes from a command line tool 
          #        g/re/p (Globally search for a Regular Expression and Print matching lines)
          #        the "l" in grepl is because this R function returns Logical values 
    df1$isamerc <- as.numeric(grepl("Merc", df1$carname))
    df1
    names(df1)
    
    #6. calculate the correlation between the miles per gallon and the weight of the Mercedes cars
    df2 <- df1[df1["isamerc"] == 1]
    cor(df1[df1["isamerc"] == 1, ]$mpg, df1[df1["isamerc"] == 1, ]$wt)
    
    
    #7. What is the mpg of Mercedes cars?  What is the average mpg of non-Mercedes cars? 
    #   Use aggregate() to find your answer.
    df2
    
    
    
## ADDITIONAL PRACTICE QUESTIONS
    
    # use the flights data to answer these questions
    install.packages("nycflights13")
    data(flights, package="nycflights13")
    
    # for info on the data, see it's help file:  ?nycflights13::flights
    
    
    #1. What is the average airtime per destination?
    
    
    
    #2. Calculate the monthly average departure delay and arrival delay by NY airport ("origin")
    
    
    
    #3. Add the variable "tdf" to the data.frame, where "tdf" is the total number of daily flights.
    #   That is, "tdf" is a count of the number of flights that departed each day
    #   As a check, Jan 1, 2013 had 842 flights that day (you should get the same number for Jan 1)
    #   Hint: this may require a merge
    
    
    #4. Delete the variable time_hour from the data.frame

    
