# The Tidyverse

install.packages("tidyverse") # <-- you only ever need to do this once
library(tidyverse)

# tibbles
data(mtcars)
mtcars
mtcars[ , "wt"]

mtcars <- as_tibble(mtcars)
str(mtcars)
mtcars
mtcars[ , "wt"]

# the "pipe" (cmd + shift + m) %>% 
sapply(mtcars, mean)
mtcars %>% sapply(mean)

# R now has a "native" pipe |> 
mtcars |> sapply(mean)

# the 5 verbs and group_by
    
    data(mtcars)
    mtcars$carname <- rownames(mtcars)
    mtcars <- as_tibble(mtcars)

    #1. filter() selects rows
    filter(mtcars, wt<3)
    mtcars |> filter(wt<3)
    
    #2. arrange() orders by row
    mtcars |> arrange(desc(cyl), wt)

    #3. select() chooses columns
    mtcars |> select(mpg, disp)
    mtcars |> select(mpg:disp)
    mtcars |> select(-(mpg:disp))

    #4. mutate() creates new columns
    mtcars |> mutate(ismerc = grepl("Merc", carname))

    #5. summarize() with group_by() does aggregations
    mtcars |> group_by(cyl) |> summarise(avgwt=mean(wt), carcount=n())
    
    #put these together
    newtibble <- 
        mtcars |> 
            mutate(ismerc = grepl("Merc", carname)) |> 
            group_by(cyl, ismerc) |> 
            summarize(avgwt = mean(wt), ncars=n()) |> 
            arrange(desc(ncars))
    newtibble
    
# reshaping data from wide to long
    
    data(iris)
    iris
    pivot_longer(data = iris, 
                 cols = Sepal.Length:Petal.Width, 
                 names_to = "measurement_name", 
                 values_to = "measurement_value")
    
    
    
## PRACTICE QUESTIONS
    
    # use the flights data to answer these questions
    install.packages("nycflights13")
    data(flights, package="nycflights13")
    
    #1. Convert the flights data.frame to a tibble.
    class(flights)
    dtb <- as_tibble(flights)
    
    
    #2. What is the average airtime per destination?
    dtb |> group_by(dest) |> summarise(at=mean(air_time, na.rm=T))
    
    
    #3. Calculate the monthly average departure delay and arrival delay by NY airport ("origin")
    dtb |> filter(origin == "JFK") |> summarise(avg_dep_delay=mean(dep_delay, na.rm=T), avg_arrival_delay=mean(arr_delay, na.rm=T))
    # above answer is wrong, we have to find MONTHLY origin wise so groupby instead of filter
    # 
    
    #4. Add the variable "tdf" to the data.table, where "tdf" is the total number of daily flights.
    #   That is, "tdf" is a count of the number of flights that departed each day
    #   As a check, Jan 1, 2013 had 842 flights that day (you should get the same number for Jan 1)
    dtb |> group_by(year, month, day) |> summarize(numflights = n())
    
    
    #5. Delete the variable time_hour from the data.table
    dtb <- dtb |> select(-time_hour)
    
    
