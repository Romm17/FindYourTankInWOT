require(data.table)
require(logging)
require(RSQLite)

#
# NW - class that implements Nadaraya and Watson formula:
# r(u, t) = r(u) + sum [u* from u* in U] {mean(r(u*, t) - r(t))}  
#

NW <- setClass(
  "NW",
  slots = c(
    dt = "data.table",
    avg.acc.xp = "data.table",
    tank.scaler = "data.table"
  )
)

setGeneric(name="fit",
           def=function(theObject)
           {
             standardGeneric("fit")
           }
)

setMethod(f="fit",
          signature="NW",
          definition=function(theObject)
          {
            theObject@avg.acc.xp <- theObject@dt[,.(account_avg_xp = mean(xp)), by = account_id]
            theObject@dt <- merge(theObject@dt, theObject@avg.acc.xp, by = "account_id")
            theObject@tank.scaler <- theObject@dt[,.(tank_scaler = mean(xp - account_avg_xp)), by = tank_id]
            theObject@dt <- merge(theObject@dt, theObject@tank.scaler, by = "tank_id")
            setcolorder(theObject@dt, c("account_id", "tank_id", "xp", "account_avg_xp", "tank_scaler"))
            theObject
          }
)

setGeneric(name="predictOne",
           def=function(theObject, acc_id, tank)
           {
             standardGeneric("predict")
           }
)

setMethod(f="predictOne",
          signature="NW",
          definition=function(theObject, acc_id, tank)
          {
            res <- theObject@avg.acc.xp[account_id == acc_id, ][head(1)]$account_avg_xp
            res <- res + theObject@tank.scaler[tank_id == tank, ][head(1)]$tank.scaler
            res
          }
)

setGeneric(name="predictAll",
           def=function(theObject, testing)
           {
             standardGeneric("predictAll")
           }
)

setMethod(f="predictAll",
          signature="NW",
          definition=function(theObject, testing)
          {
            testing <- merge(testing, theObject@avg.acc.xp, by = "account_id")
            testing <- merge(testing, theObject@tank.scaler, by = "tank_id", all.x = T)
            testing[is.na(testing)] <- 0
            testing$xp <- testing$account_avg_xp + testing$tank_scaler
            testing
          }
)

#
# Function to fill table with unpresent rows
#

fillMissingRows <- function(dt, tanks.xp, value = NA) {
  dt1 <- CJ(unique(tanks.xp$account_id), unique(tanks.xp$tank_id))
  names(dt1) <- c('account_id', 'tank_id')
  dt <- merge(dt1, dt, by = c('account_id', 'tank_id'), all.x = T)
  dt[is.na(dt$xp)]$xp <- value
  dt
}

#
# Loading data from db
#

con <- RSQLite::dbConnect(RSQLite::SQLite(), "wot.sqlite")
tanks.xp <- as.data.table(RSQLite::dbReadTable(con, "tanks_xp"))
RSQLite::dbDisconnect(con)

#
# Train test split
#
dt <- tanks.xp
in.train <- sample(1:nrow(dt), 0.9 * nrow(dt))
training <- dt[in.train, ]
testing <- dt[-in.train, ]

#
# Filling mean values instead of zeroes using NW class
#

dt <- fillMissingRows(training, tanks.xp)
tmp <- dt[!is.na(dt$xp)]
dt <- dt[is.na(dt$xp)]
dt$xp <- NULL

model <- NW(dt = tmp, avg.acc.xp = data.table(), tank.scaler = data.table())
model <- fit(model)
dt <- predictAll(model, dt)
training <- rbind(tmp, dt[,.(account_id, tank_id, xp)])

#
# Some technical details
#

training <- dcast(training, account_id ~ tank_id, value.var = "xp", fun.aggregate = sum)
names(training) <- c("account_id", paste("tank", names(training)[2:length(names(training))], sep = "_"))
testing <- fillMissingRows(testing, tanks.xp, 0)
testing <- dcast(testing, account_id ~ tank_id, value.var = "xp", fun.aggregate = sum)
names(testing) <- c("account_id", paste("tank", names(testing)[2:length(names(testing))], sep = "_"))

#
# SVD model
#

n.features <- 17
model <- svd(training[, !"account_id", with = F], nu = n.features, nv = n.features)
U <- model$u
D <- model$d[1:n.features]
V <- model$v
training1 <- U %*% diag(D) %*% t(V)
  
tr <- as.matrix(testing[, !"account_id", with = F])
ind <- tr > 0
rmse  <- sqrt(mean((tr[ind] - training1[ind]) ^ 2))
cat(sprintf('n_features = %3d; rmse = %3.2f\n', n.features, rmse))

user.features <- as.data.table(cbind(testing[, .(account_id)], U))
names(user.features) <- c("account_id", paste0("F", 1:n.features))

tank.features <- as.data.table(cbind(unique(tanks.xp[, .(tank_id)])[order(tank_id)], V))
names(tank.features) <- c("tank_id", paste0("F", 1:n.features))

d.vector <- cbind(data.table(d_id = 1), as.data.table(t(as.matrix(D))))
names(d.vector) <- c("d_id", paste0("F", 1:n.features))

#
# Output model
#
con <- RSQLite::dbConnect(RSQLite::SQLite(), "../java/model.sqlite")
RSQLite::dbWriteTable(con, "user_features", user.features)
RSQLite::dbWriteTable(con, "tank_features", tank.features)
RSQLite::dbWriteTable(con, "d_vector", d.vector)
RSQLite::dbDisconnect(con)

#
# Usage
#
as.matrix(user.features[account_id == 1592, !"account_id", with = F]) %*% diag(D) %*% t(as.matrix(tank.features[tank_id == 609, !"tank_id", with = F]))
