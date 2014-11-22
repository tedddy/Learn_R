# Argument Matching
# ?sd sd(x, na.rm = FALSE)

mydata <- rnorm(100)
sd(mydata)
sd(x = mydata)
sd(x = mydata, na.rm = FALSE)
sd(na.rm = FALSE, x = mydata)
sd(na.rm = FALSE, mydata)

# Argument Matching 2

args(lm) 

#function (formula, data, subset, weights, na.action, method = "qr", model = TRUE, x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE, contrasts = NULL, offset, ...) 

lm(data = mydata, y ~ x, model = FALSE, 1:100)

lm(y ~ x, mydata, 1:100, model = FALSE)

# 22mp4

myplot <- function(x, y, type = "l", ...) {
  plot(x, y, type = type, ...)
}

mean
# function (x, ...) 
# UseMethod("mean")

args(paste)
# function (..., sep = " ", collapse = NULL) 

args(cat)
# function (..., file = "", sep = " ", fill = FALSE, labels = NULL, append = FALSE)

