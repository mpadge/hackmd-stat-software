SFILE = script

BFILE = bayesian
EFILE = eda
GFILE = general
RFILE = regression
TFILE = time-series
UFILE = unsupervised

DEMO = FALSE

all: bayes

bayes: $(SFILE).R
	Rscript $(SFILE).R $(BFILE) $(DEMO)

eda: $(SFILE).R
	Rscript $(SFILE).R $(EFILE) $(DEMO)

gen: $(SFILE).R
	Rscript $(SFILE).R $(GFILE) $(DEMO)

reg: $(SFILE).R
	Rscript $(SFILE).R $(RFILE) $(DEMO)

ts: $(SFILE).R
	Rscript $(SFILE).R $(TFILE) $(DEMO)

ul: $(SFILE).R
	Rscript $(SFILE).R $(UFILE) $(DEMO)

clean:
	rm -rf *.html *.png README_cache 
