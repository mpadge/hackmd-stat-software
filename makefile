SFILE = script
RFILE = unsupervised

all: runscript

runscript: $(SFILE).R
	Rscript $(SFILE).R $(RFILE)

clean:
	rm -rf *.html *.png README_cache 
