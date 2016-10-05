require(data.table)
require(httr)
require(jsonlite)
require(logging)
require(RSQLite)

app.id <- "a0b5d158684b7a16dc2d577a1aac3ae0"

getStarting <- function(depth) {
  if(depth > 1) {
    to.paste <- getStarting(depth - 1)
    unlist(lapply(letters, function(x) paste0(x, to.paste)))
  } else {
    letters
  }
}

startings <- getStarting(3)
startings <- startings[1:500]

getUsers <- function(startings, limit = 100) {
  response <- GET(sprintf("https://api.worldoftanks.ru/wot/account/list/?application_id=%s&search=%s&limit=", app.id, startings, limit))
  parsed <- content(response, type="application/json")$data
  res <- data.table(matrix(unlist(parsed), nrow=length(parsed), byrow = T))
  names(res) <- names(parsed[[1]])
  class(res$account_id) <- "integer"
  res
}

getUsersBattles <- function(user) {
  response <- GET(sprintf("https://api.worldoftanks.ru/wot/account/info/?application_id=%s&account_id=%s&fields=statistics.all.battles", app.id, user))
  Sys.sleep(0.1)
  content(response, type="application/json")$data[[toString(user)]]$statistics$all$battles
}

getUsersWithBattles <- function(startings) {
  users <- tryCatch({
    users <- getUsers(startings)
    users <- users[, .(nickname = nickname, battles = getUsersBattles(account_id)), by = account_id]
    users <- users[battles >= 10000]
    loginfo(paste0("Found ", nrow(users), " users starting with '", startings, "'"))
    users
  }, error = function(e) {
    loginfo(paste0("Error on '", startings, "' : ", e))
    data.table(account_id = integer(), battles = integer())
  })
  users
}

getTankStat <- function(user) {
  res <- tryCatch({
    response <- GET(sprintf("https://api.worldoftanks.ru/wot/tanks/stats/?application_id=%s&account_id=%s&fields=tank_id,all.battle_avg_xp", app.id, user))
    parsed <- content(response, type="application/json")$data[[toString(user)]]
    res <- Reduce(
      rbind,
      lapply(parsed, function(l) {
        data.table(tank_id = l$tank_id, xp = l$all$battle_avg_xp)
      })
    )
    if (nrow(res) < 40) {
      stop("User has less than 40 tanks.")
    } 
    loginfo(paste0("User ", user, " played at ", nrow(res), " tanks"))
    res
  }, error = function(e) {
    loginfo(paste0("Error on user ", user, " : ", e))
    data.table(tank_id = integer(), xp = integer())
  })
  Sys.sleep(0.1)
  res
}

startings.dt <- data.table(start = startings)
users <- startings.dt[, getUsersWithBattles(start), by = start]
usersTanks <- users[, getTankStat(account_id), by = account_id]

dbInit <- function(db.name = "wot.sqlite") {
  con <- RSQLite::dbConnect(RSQLite::SQLite(), db.name)
  RSQLite::dbGetQuery(
    con,
    "create table users (
    account_id integer primary key,
    nickname varchar(24),
    battles integer
    )"
    )
  RSQLite::dbGetQuery(
    con,
    "create table tanks_xp (
    account_id integer,
    tank_id integer,
    xp integer,
    primary key(account_id, tank_id)
    )"
  )
  RSQLite::dbDisconnect(con)
}

dbInit()
con <- RSQLite::dbConnect(RSQLite::SQLite(), "wot.sqlite")
RSQLite::dbWriteTable(con, "users", users[,.(account_id, nickname, battles)], append = T)
RSQLite::dbWriteTable(con, "tanks_xp", usersTanks, append = T)
RSQLite::dbDisconnect(con)