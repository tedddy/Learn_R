# 6.1 Lists

Lst <- list(name="Fred",wife="Mary",no.children=3,child.ages=c(4,7,9))

length(Lst)

Lst[[1]]

Lst[[4]][1]
  
Lst$name

Lst$child.ages

Lst[["name"]]

x <- "name"; Lst[[x]]

# 6.2 Constructing and modifying Lists

# Lst <- list(name_1=object_1, ..., name_m=object_m)

# Lst[5] <- list(matrix=Mat)

# 6.2.1 Concatenating lists

# list.ABC <- c(list.A, list.B, list.C)

# 6.3 Data frames

# A data frame is a list with class "data.frame". There are ristrictions on lists that may be made into data frames, namely
  # The components must be vectors (n, c, or logical), factors, numerric matrices, lists, or other data frames.
  # Matrices, lists, and data frames provide as many variables to the new data frame as they have columns, elements, or variables, respectively.
  # Numeric vectors, logicals and factors are included as is, and by default character vectors are                 coerced to be factors, whose levels are the unique values apprearing in the vector. 
  #Vector structures appearing as variables of the data frame must all have the same length, and matrix structures must all have the same row size. 

# A data frame may for many purpose be regarded as a matrix with columns possibly of differing modes and attributes. It may be displayed in matrix form, and its rows and columns extracted using matrix indexing conventions.

# accountants <- data.frame(home=statef, loot=incomes, shot=incomef)

# A list whose components confirm to the restrictions of a data frame may be coerced into a data frame using the function as.data.frame()

# 6.3.2 attach() and detach() index of difficult: 3

?attach() # The database is attached to the R search path. This means that the database is searched by R when evaluating a variable, so objects in the database can be accessed by simply giving their names.

attach(Lst)

detach(Lst)

# Examples !!! Add the following block in a empty file, and save it to myfuns.R.

# require(utils)
# 
# summary(women$height)   # refers to variable 'height' in the data frame
# attach(women)
# summary(height)         # The same variable now available by name
# height <- height*2.54   # Don't do this. It creates a new variable
# # in the user's workspace
# find("height")
# summary(height)         # The new variable in the workspace
# rm(height)
# summary(height)         # The original variable.
# height <<- height*25.4  # Change the copy in the attached environment
# find("height")
# summary(height)         # The changed copy
# detach("women")
# summary(women$height)   # unchanged

## Not run: ## create an environment on the search path and populate it
sys.source("myfuns.R", envir = attach(NULL, name = "myfuns"))

## End(Not run)
