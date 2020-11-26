FILE=standards
SFILE=script

all: knith #open

knitr:
	Rscript $(SFILE).R $(FILE).Rmd

knith: $(FILE).Rmd
	echo "rmarkdown::render('$(FILE).Rmd',output_file='$(FILE).html')" | R --no-save -q

open: $(FILE).html
	xdg-open $(FILE).html &

clean:
	rm -rf *.html *.png
