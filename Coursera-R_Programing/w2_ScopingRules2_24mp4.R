# Lexical Scoping

# Lexical scoping in R means that the values of free variables are searched for in the environmet in which the function was defined.
    # What is an environment? An environment is a collection of (symbol, value) pairs, i.e. x is a symbol and 3.14 might be its value.
    # Every environment has a parent environment; it is possible for an environment to have multiple “children”
    # the only environment without a parent is the empty environment
    # A function + an environment = a closure or function closure.

make.power <- function(n) {
    pow <- function(x) {
        x^n
    }
    pow
}

cube <- make.power(3)
cube(3)
square <- make.power(2)
square(3)

ls(environment(make.power))
ls(environment(cube))

y <- 10
f <- function(x) {
    y <- 2
    y^2 + g(x)
}
g <- function(x) {
    x*y
}

f(3)

g <- function(x) {
    a <- 3
    x+a+y
    }
g(2)


