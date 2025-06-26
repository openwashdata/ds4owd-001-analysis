if(!require("countries")) install.packages("countries")

country_detect <- function(x, to = "name_en"){
  stopifnot(to %in% c("name_en", "ISO3"))
  x <- tolower(x)
  x <- stringr::str_replace(x, "england - ", "")
  x <- stringr::str_replace(x, "kampala", "uganda")
  cond <- str_detect(x, "/|,")
  x <- case_when(
    !cond                  ~ countries::country_name(x, to = to),
    cond & to == "name_en" ~ countries::country_name(x, to = to),
    cond & to == "ISO3"    ~ NA_character_
  ) |> 
    suppressMessages()
  return(x)
}
