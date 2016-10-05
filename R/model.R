require(data.table)
require(logging)
require(RSQLite)

con <- RSQLite::dbConnect(RSQLite::SQLite(), "wot.sqlite")
tanks.xp <- as.data.table(RSQLite::dbReadTable(con, "tanks_xp"))
RSQLite::dbDisconnect(con)

X <- dcast(tanks.xp, account_id ~ tank_id, value.var = "xp", fun.aggregate = sum)

library(randomForest)

in.train <- sample(1:nrow(X), 0.99 * nrow(X))
training <- X[in.train, !c("account_id"), with = F]
names(training) <- paste("tank", names(training), sep = "_")
testing <- X[-in.train, !c("account_id"), with = F]
names(testing) <- paste("tank", names(testing), sep = "_")

model <- randomForest(as.formula("tank_1 ~ ."), data = training, ntree = 11)
res <- data.frame(y = testing$tank_1, y_pred = predict(model, testing))
