INPUT = DB9_Cable_DMM_BCM.tex DB9_Cable_DMM_NPCT.tex DCCT_App_User_Guide.tex DMM7510_EPICS_IOC_Guide.tex ICT_App_User_Guide.tex

PDF  = $(INPUT:.tex=.pdf)
ALL  = $(PDF)

all: $(ALL)

%.pdf: %.tex
	pdflatex -dSubsetFonts=true -dEmbedAllFonts=true $^
	pdflatex -dSubsetFonts=true -dEmbedAllFonts=true $^

.PHONY: clean realclean mrproper distclean

clean :
	rm -f *.eps *.dat *.log *.out *.aux *.dvi *.ps *.toc version.tex

realclean: clean
	rm -f *.pdf

mrproper: realclean

distclean: realclean
