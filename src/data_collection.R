library(DBI)

# See https://github.com/r-lib/keyring?tab=readme-ov-file#readme and
# ?keyring::key_set for securely managing credentials

db_user <- keyring::key_list("ds4owd-DB")[1,2]
db_pwd <- keyring::key_get("ds4owd-DB", db_user)

# open database connection
con <- dbConnect(
  RPostgres::Postgres(),
  host = "id-hdb-psgr-ct39.ethz.ch",
  port = 5432,
  user = db_user,
  password = db_pwd,
  dbname = "openwashdata"
)

# check table names
#dbListTables(con)

# check field names of a specific table
#dbListFields(con, "publishing_metadata")

# get tables in R environment

pre_survey <- dbGetQuery(con, "SELECT * FROM presurvey")

post_survey <- dbGetQuery(con, "SELECT * FROM postsurvey")

course_participation <- dbGetQuery(con, "SELECT * FROM course_participation")

positcloud_usage <- dbGetQuery(con, "SELECT * FROM pscloud")

published_datasets <- dbGetQuery(con, "SELECT * FROM publishing_metadata")

visits_country <- dbGetQuery(con, 'SELECT * FROM "ds4owd-001_country_data"')

visits_ts <- dbGetQuery(con, 'SELECT * FROM "ds4owd-001_timeseries_data"')

location <- dbGetQuery(con, "SELECT * FROM locations")

# close database connection
dbDisconnect(con)
