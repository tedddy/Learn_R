require(xts)

data(sample_matrix)

class(sample_matrix)

str(sample_matrix)

matrix_xts <- as.xts(sample_matrix,dateformat='date')

str(matrix_xts)

df_xts <- as.xts(as.data.frame(sample_matrix), important='very implortant information')

str(df_xts)

View(df_xts)
