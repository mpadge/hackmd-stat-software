SFILE = script

BFILE = bayesian
EFILE = eda
GFILE = general
RFILE = regression
TFILE = time-series
UFILE = unsupervised-demos
MFILE = ml

DEMO = TRUE

all: bayes eda gen reg ts ul ml

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

cpm: $(MFILE).Rmd
	cp $(MFILE).Rmd ../../ropensci-stats/statistical-software-review/standards/.

clean:
	rm -rf *.html *.png README_cache 
