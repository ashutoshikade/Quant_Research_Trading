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

# subset of rows and cols (just put row and col subsetting together)
    df1[1:3, c("col2", "col3")]
    df1[c("col2", "col3")][1:3, ]
    df1[1:3, 2:3]

    colnamevec <- c("col2", "col3")
    df1[1:3, colnamevec]

    df1[df1$col2 < 50, ]

# create a new column
    df1$newcol <- df1$col1 + df1$col2
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
    sort(df1$col1). # returns the sorted series
    order(df1$col1) # returns the indices of the sorted series

    df1[order(df1$col1), ]
    df1 <- df1[order(df1$col1), ]

# reorder columns
    new_ord <- sort(names(df1), decreasing = TRUE)
    df1 <- df1[ , new_ord]
    df1

# summarizing (collapsing / aggregating) a dataframe
    set.seed(9898)
    df <- data.frame(
        ints = sample(1:100, 100, T),
        lets = sample(letters, 100, T),
        caps = sample(LETTERS, 100, T),
        stringsAsFactors = TRUE
    )
    
    str(df)
    summary(df)
    
    # aggregate -- args take lists
    aggregate(df$ints, by=df["lets"], mean)
    aggregate(df$ints, by=df[, c("lets", "caps")], length)
    
    # aggregate -- args take a formula
    aggregate(ints ~ lets, data=df, mean)
    aggregate(ints ~ lets + caps, data=df, length)
 

## PRACTICE QUESTIONS

    # load the "mtcars" dataset like this:
    data(mtcars)
    
    #1. Are any variables factors?
    
    
    
    #2. calculate the average miles per gallon of cars in the mtcars dataset
    
    
    
    #3. how many cars (ie, observations or rows) have each number of cylinders? (use "table")
    
    
    
    #4. make a new variable called "carname".  Populate that column with the rownames of the mtcars dataframe
    
    
    
    #5. create a dummy (0/1) variable to indicate which cars are Mercedes:
          # hint: use grepl("Merc", ...) where you fill in the ...
          # aside: the name grep comes from a command line tool 
          #        g/re/p (globally search for a regular expression and print matching lines)
          #        the "l" in grepl is because this R function returns logical values 
    
    
    
    #6. calculate the correlation between the miles per gallon and the weight of the Mercedes cars
    
    
    
    #7. [add aggregate question]
    
    
    
## ADDITIONAL PRACTICE QUESTIONS
    
    # use the flights data to answer these questions
    install.packages("nycflights13")
    data(flights, package="nycflights13")
    
    #1. What is the average airtime per destination?
    
    
    
    #2. Calculate the monthly average departure delay and arrival delay by NY airport ("origin")
    
    
    
    #3. Add the variable "tdf" to the data.frame, where "tdf" is the total number of daily flights.
    #   That is, "tdf" is a count of the number of flights that departed each day
    #   As a check, Jan 1, 2013 had 842 flights that day (you should get the same number for Jan 1)
    #   (this may require a "merge" which we have not yet discussed)
    
    
    #4. Delete the variable time_hour from the data.frame


