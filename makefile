SFILE = script
RFILE = unsupervised
DEMO = FALSE

all: runscript

runscript: $(SFILE).R
	Rscript $(SFILE).R $(RFILE) $(DEMO)

clean:
	rm -rf *.html *.png README_cache 
