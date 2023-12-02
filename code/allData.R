allData <- function(files, sheets, vars, lookup) {
  raw <- map2(files, sheets, function(x,y) read_excel(path=x, sheet=y))
  processed <- map(raw, function(x) getData(x, vars, lookup))
  result <- list_rbind(processed)
  return(result)
}
