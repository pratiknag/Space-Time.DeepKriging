library(GpGp)

setwd("/Users/nagp/Desktop/Time_series /Space-Time.DeepKriging/") ### Change this to the local directory

df_loc = read.csv("synthetic_ds/LOC_50000_univariate_spacetime_matern_stationary_1", header = F, sep = ",")
df_val = read.csv("synthetic_ds/Z1_50000_univariate_spacetime_matern_stationary_1", header = F)

df_loc$z = df_val$V1

s_ = ((df_loc$V3/1000))

mu = 2 * sin(15*(s_ - 0.9)) * cos(-37*(s_ - 0.9)^4) + (s_ - 0.9)/2

df_loc$mu = mu
df_loc$nonstat_z = df_loc$z + df_loc$mu



#### experiments with GpGp


rand_index = sample(1:dim(df_loc)[1], 45000)
train = df_loc[rand_index,]
test = df_loc[-rand_index,]

fitted_model = fit_model(train$z,cbind(train$V1,train$V2,train$V3),
                         m_seq = c(10, 30),
                         covfun_name = "matern_spacetime")

preds = predictions(fitted_model,
                    locs_pred = cbind(test$V1,test$V2,test$V3),
                    y_obs = train$z,
                    locs_obs = cbind(train$V1,train$V2,train$V3),
                    X_pred = matrix(rep(1,5000),nrow=5000),
                    X_obs = matrix(rep(1,45000),nrow=45000))

preds = preds + test$mu
### mse loss

mse = mean((test$nonstat_z - preds)^2)
print(mse)


## t=250 interpolations with GpGp
time.point = 250

x <- seq(0,1, length.out = 100)
y <- seq(0,1, length.out = 100)
d1 <- expand.grid(x = x, y = y)
X = d1$x              # X, Y co-ordinates getting generated here
Y = d1$y
t = rep(time.point, 10000)
preds250_GpGp = predictions(fitted_model,
                            locs_pred = cbind(X,Y,t),
                            y_obs = train$z,
                            locs_obs = cbind(train$V1,train$V2,train$V3),
                            X_pred = matrix(rep(1,10000),nrow=10000),
                            X_obs = matrix(rep(1,45000),nrow=45000))
tr = ((t/1000))

mu = 2 * sin(15*(tr - 0.9)) * cos(-37*(tr - 0.9)^4) + (tr - 0.9)/2
preds250_GpGp = preds250_GpGp + mu

df_GP = data.frame(x=X,y=Y,pred_250=preds250_GpGp)


## Forecasting

rand_index = c(1:45000)
train = df_loc[rand_index,]
test = df_loc[-rand_index,]

fitted_model = fit_model(train$z,cbind(train$V1,train$V2,train$V3),
                         m_seq = c(10, 30),
                         covfun_name = "matern_spacetime")

preds = predictions(fitted_model,
                    locs_pred = cbind(test$V1,test$V2,test$V3),
                    y_obs = train$z,
                    locs_obs = cbind(train$V1,train$V2,train$V3),
                    X_pred = matrix(rep(1,5000),nrow=5000),
                    X_obs = matrix(rep(1,45000),nrow=45000))

preds = preds + test$mu
### mse loss

mse = mean((test$nonstat_z - preds)^2)
print(mse)

## Plotting GpGp interpolations on regular grid
p <- ggplot() + geom_point(data = df_GP, aes(x = x, y = y,
                                             color = pred_250),size = 5, alpha = 0.8,
                           show.legend = FALSE) + 
  scale_color_viridis(name=NULL) + ggtitle("GpGp") +
  theme(legend.key.size = unit(1.5, 'cm'), legend.key.height = unit(1, 'cm'), 
        legend.key.width = unit(2, 'cm'),
        legend.text=element_text(size=rel(1.9)), legend.position = "bottom",
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_blank(),axis.text.y=element_blank(),
        plot.title = element_text(size=35,face="bold"))
p