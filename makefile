SFILE = script

BFILE = bayesian
EFILE = eda
GFILE = general
RFILE = regression
TFILE = time-series
UFILE = unsupervised

DEMO = FALSE

all: bayes eda gen reg ts ul

bayes: rbayes cpb
eda: reda cpe
gen: rgen cpg
reg: rreg cpr
ts: rts cpt
ul: rul cpu

render: rbayes reda rgen rreg rts rul

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

copy: cpb cpe cpg cpr cpt cpu

cpb: $(BFILE).Rmd
	cp $(BFILE).Rmd ../../ropensci-stats/statistical-software-review/standards/.

cpe: $(EFILE).Rmd
	cp $(EFILE).Rmd ../../ropensci-stats/statistical-software-review/standards/.

cpg: $(GFILE).Rmd
	cp $(GFILE).Rmd ../../ropensci-stats/statistical-software-review/standards/.

cpr: $(RFILE).Rmd
	cp $(RFILE).Rmd ../../ropensci-stats/statistical-software-review/standards/.

cpt: $(TFILE).Rmd
	cp $(TFILE).Rmd ../../ropensci-stats/statistical-software-review/standards/.

cpu: $(UFILE).Rmd
	cp $(UFILE).Rmd ../../ropensci-stats/statistical-software-review/standards/.

clean:
	rm -rf *.html *.png README_cache 
