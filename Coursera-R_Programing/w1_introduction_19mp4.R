z <- 5

while (z > 3 & z < 10) {
  print(z)
  coin <- rbinom(1, 1, 0.5)
  if (coin == 1) { ## random walk
    z  <-  z + 1
  } else {
    z  <-  z - 1
  }
}

x0 <- 1
tol = 1e-8

repeat {
  x1 <- computEstimate()
  if ((x1-x0) < tol) {
    break
  } else {
    x0 <- x1
  }
}