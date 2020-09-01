SFILE = script
#RFILE = unsupervised
RFILE = regression-demos
DEMO = TRUE

all: runscript

runscript: $(SFILE).R
	Rscript $(SFILE).R $(RFILE) $(DEMO)

clean:
	rm -rf *.html *.png README_cache 
