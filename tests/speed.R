# speed - «Short one line description»
# SQLiteFL/tests/speed.R

# Copyright 2003-2009 FLR Team. Distributed under the GPL 2 or later
# Maintainer: Iago Mosqueira, Cefas
# $Id$

# Reference:
# Notes:

library(SQLiteFL)
db <- tempfile()

data(ple4)

res <- data.frame(iter=c(1, 5, 10, 25), save=NA, slot=NA)
# res <- data.frame(iter=c(1, 5, 10, 25, 50, 100, 250), save=NA, slot=NA)

for (i in res$iter)
{
  object <- propagate(ple4, i)
  res[res$iter==i, 'save'] <- system.time(sql4 <- sql(object, name='ple4', db=db))[3]
  res[res$iter==i, 'slot'] <- system.time(catch.n(sql4))[3]
}

# png(file='sqlspeed_with_index.png')
plot(res$iter, res$save, type='b', col='red', xlab="No. of iters", ylab="time (s)")
lines(res$iter, res$slot, type='b', col='blue')
legend(0.5, 1.4, c('storing', 'accesing'), col=c('red', 'blue'), lwd=1)
# dev.off()
# -----
unlink(db)
