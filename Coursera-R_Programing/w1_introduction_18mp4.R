# If the symbol X is greater than three, then you set y equal to 10. If it's not greater than 3 then you set y equal to zero.

x <- 1

if(x < 3) {
  y <- 10
} else {
  y <- 0
}

y <- if(x < 3) {
  11
} else {
  0
}

for (i in 1:10) {
  print (i)
}

x <- c("a","b","c","d")
for (i in 1:4) {
  print (x[i]) # print ()
}

for (i in seq_along(x)) {
  print(x[i])
}

for (letter in x){
  print(letter)
}

x <- matrix (1:6,2,3)
x
for (i in seq_len(nrow(x))) {
  for (j in seq_len(ncol(x))) {
    print(x[i,j])
  }
}