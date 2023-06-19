# LaTeX

MAIN         := main
NAME         := presentation-chapter-5-J-SEN
TEX_FILES    := settings.sty
RUNCODE      := .runcode-
CODE_TARGETS := $(shell ls figures-R/*.R | xargs basename | sed 's/^/$(RUNCODE)/')
FIGURES_TIKZ := $(shell ls figures-tikz/*.tex | sed 's/tex$$/pdf/')

.PHONY: all clean

all: $(NAME).pdf

clean:
	latexmk -C
	rm -rf $(NAME).pdf
	rm -rf $(CODE_TARGETS)
	cd figures-tikz ; latexmk -C   ; cd ..
	cd figures-R    ; rm -rf *.pdf ; cd ..

$(NAME).pdf: $(MAIN).pdf
	cp $(MAIN).pdf $(NAME).pdf

$(MAIN).pdf: $(MAIN).tex $(TEX_FILES) $(CODE_TARGETS) $(FIGURES_TIKZ) figures/*
	latexmk -xelatex $<

figures-tikz/%.pdf: figures-tikz/%.tex
	latexmk -outdir=$(@D) -xelatex $(<F)

$(RUNCODE)%: figures-R/%
	cd $(<D) ; Rscript $(<F) ; cd ..
	touch $@
