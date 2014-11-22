# Lexical Scoping

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
