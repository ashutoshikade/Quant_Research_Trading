# FUNCTIONS

# example 1
    plus_two <- function(q) {
        q+2
    }
    plus_two(4)
    plus_two("hi")
    
# example 2
    two_x_three_y <- function(x, y=5) {
        #defensive programming
        if(is.data.frame(x)) stop("No dataframes allowed!")
        
        # create new variables LOCAL to the function
        a <- 2
        b <- 3
        
        # return something to the user
        return(a*x + b*y)
    }
    
    #example of defensive programming in the correlation function
    cor
    
    # how the x and y arguments work
    two_x_three_y(x=2, y=1)
    two_x_three_y(4)
    two_x_three_y(x=data.frame(1:10), y=10)
    
    x <- 4
    two_x_three_y(x=x, y=1)
    
    y # error!
    b # error!

# example 3
    rm(list=ls()) # removes/deletes global vars from the memory
    
    x_plus_y <- function(x=1, y=1) {
        stopifnot(is.numeric(x), is.numeric(y))
        
        # last calculation returned even without "return()"
        x + y
    }
    
    x_plus_y(3, 4)
    x_plus_y()
    
    x <- 10
    y <- 10
    x_plus_y()    # 2, not 20!
    x_plus_y(x,y) # 20!

# example 4
    rm(list=ls())
    
    # using global variables inside of functions is **bad** practice!
    e3 <- function() x + 10
    
    # this is because changing the global value changes the function's result
    x <- 5
    e3() # uses the parent scope of the current local scope if a value is not provided
    
    x <- 15
    e3()

# example 5
    mm <- matrix(1:100, 10, 10)
    
    # usually we use an existing function with apply, like mean
    apply(mm, 1, mean)
    
    # but we can also use our own functions
    myfun <- function(x) mean(x) + 1000
    apply(mm, 1, myfun)
    
    # or you can use an anonymous function
    # e.g., how many numbers are multiples of 3 per row
    apply(mm, 1, function(x) sum(x%%3 == 0) )
    apply(mm, 1, \(x) sum(x%%3 == 0) ) # \ is alias for function()
    


# CONTROL STATEMENTS
    
    # if, else, and ifelse
    if(1:10 == 2) {
        print("Yes")
    } else {
        print("No")
    }
    
    ifelse(1:10 == 2, "yes", "no")
    
    # with assignment
    x <- if(any(1:10 == 2)) {
                sum(1:10==2) # sum of the list of booleans
            } else {
                "none"
            }
    x
    
    if(any(1:10 == 2)) {
        x <- sum(1:10==2)
    } else {
        x <- "none"
    }
    x
    
    y <- ifelse(1:10 == 2, "is 2", "not two")
    y
    
    
    # loops
    for (i in 1:5) {
        print(paste("My number is", i))
    }
    i
    
    for (i in 1:5) {
        paste("My number is", i)
    }
    
    for (i in 1:3) print(i+2)
    
    
    x <- letters[1:4]
    for (i in x) {
        print(i)
    }
    i
    
    
    result_list <- vector(mode="list", length=10)
    for (i in seq(result_list)) {
        result_list[i] <- i*100
    }
    unlist(result_list)

    res1 <- res2 <- vector(length=10) # something like zipping
    x <- letters[1:5]
    y <- LETTERS[1:5]
    
## PRACTICE QUESTIONS
    
    #1. This function should replace NAs with zeros. Finish it by replacing the ...'s
    na_to_zero <- function(vec_with_nas) {
        stopifnot(is.vector(vec_with_nas))
        fixed_vec <- ifelse(is.na(vec_with_nas), 0, vec_with_nas)
        return(fixed_vec)
    }
    x <- vector(mode="list", length=5)
    x[[1]] <- NA
    na_to_zero(x)
    
    
    
    
    #2. Write a function that takes in this dataframe (example_df) and calculates the  
    #   correlation between the first column and every other column using a loop.
    set.seed(234)
    example_df <- mapply(function (x) sample(1:(x*10), 10, T), 1:5)
    example_df
    cols <- colnames(example_df)
    for (i in 1:dim(example_df)[2]) {
      print(cor(example_df[,1], example_df[,i]))
    }
    
    #3. Use an apply function and an anonymous function to calculate sum(x^2 - 10) 
    #   for each vector in the following list
    testlist <- list(
        x1 = 1:10,
        x2 = 11:20,
        x3 = 21:30
    )
    
    testmatrix <- data.frame(testlist)
    testmatrix
    apply(testmatrix, 2, function(x) sum(x ** 2 - 10))
    
    
    
    
        
    
