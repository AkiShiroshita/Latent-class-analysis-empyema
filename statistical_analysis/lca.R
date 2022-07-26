
packages = c("devtools",
             "usethis",
             "here",
             "readr",
             "readxl",
             "tidyverse",
             "tidylog",
             "lubridate",
             "ggplot2",
             "tidylog",
             "ggplotgui",
             "ggthemes",
             "arsenal",
             "lavaan",
             "poLCA")
package.check <- lapply(packages, FUN = function(x){
  if (!require(x, character.only = TRUE)){
    install.packages(x, dependencies = TRUE)
    library(x, character.only = TRUE)
  }
})

getwd()
rm(list=ls())

df <- read_csv("input/analysis_data_update.csv", 
               locale = locale(encoding = "SHIFT-JIS"))

df %>% glimpse()

df <- df %>% filter(dev_place == 0)

f <- as.formula(cbind(cough, sputum, weight_loss, fever, chest_pain) ~ 1)
f <- as.formula(cbind(cough, sputum, weight_loss, fever, chest_pain) ~ dev_place)

lca1 <- poLCA(f, data = df, nclass = 1)
lca2 <- poLCA(f, data = df, nclass = 2)
lca3 <- poLCA(f, data = df, nclass = 3) #best
lca4 <- poLCA(f, data = df, nclass = 4)
lca5 <- poLCA(f, data = df, nclass = 5)

plot(lca3)

lca3$predcell
poLCA.predcell(lca3, )
