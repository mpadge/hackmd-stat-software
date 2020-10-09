SFILE = script

BFILE = standards/bayesian
EFILE = standards/eda
GFILE = standards/general
RFILE = standards/regression
TFILE = standards/time-series
UFILE = standards/unsupervised-demos
MFILE = standards/ml

COPYDEST = ../../ropensci-stats/statistical-software-review-book/standards/.

DEMO = FALSE

#all: bayes eda gen reg ts ul ml
all: ml

bayes: rbayes cpb
eda: reda cpe
gen: rgen cpg
reg: rreg cpr
ts: rts cpt
ul: rul cpu
ml: rml cpm

render: rbayes reda rgen rreg rts rul rml

rbayes: $(SFILE).R
	Rscript $(SFILE).R $(BFILE) $(DEMO)

reda: $(SFILE).R
	Rscript $(SFILE).R $(EFILE) $(DEMO)

rgen: $(SFILE).R
	Rscript $(SFILE).R $(GFILE) $(DEMO)

rreg: $(SFILE).R
	Rscript $(SFILE).R $(RFILE) $(DEMO)

rts: $(SFILE).R
	Rscript $(SFILE).R $(TFILE) $(DEMO)

rul: $(SFILE).R
	Rscript $(SFILE).R $(UFILE) $(DEMO)

rml: $(SFILE).R
	Rscript $(SFILE).R $(MFILE) $(DEMO)


copy: cpb cpe cpg cpr cpt cpu

cpb: $(BFILE).Rmd
	cp $(BFILE).Rmd $(COPYDEST)

cpe: $(EFILE).Rmd
	cp $(EFILE).Rmd $(COPYDEST)

cpg: $(GFILE).Rmd
	cp $(GFILE).Rmd $(COPYDEST)

cpr: $(RFILE).Rmd
	cp $(RFILE).Rmd $(COPYDEST)

cpt: $(TFILE).Rmd
	cp $(TFILE).Rmd $(COPYDEST)

cpu: $(UFILE).Rmd
	cp $(UFILE).Rmd $(COPYDEST)

cpm: $(MFILE).Rmd
	cp $(MFILE).Rmd $(COPYDEST)

clean:
	rm -rf *.html *.png README_cache 
