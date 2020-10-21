SFILE = script

COPYDEST = ../../ropensci-stats/statistical-software-review-book/standards/.

DEMO = FALSE

all: render copy

render:
	for F in standards/*.Rmd ; \
	do \
		Rscript $(SFILE).R $$F FALSE ; \
	done

demos:
	for F in category-demos/*.Rmd ; \
	do \
		Rscript $(SFILE).R $$F TRUE ; \
	done

copy:
	for F in standards/*.Rmd ; \
	do \
		cp $$F $(COPYDEST) ; \
	done

clean:
	rm -rf *.html *.png README_cache 
