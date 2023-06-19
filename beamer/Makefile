# Latex Makefile

# You can define variables to make the Makefile more modular.
MAIN    = main
NAME    = makefile-beamer

# Here a shell command is executed to get the list of figures on which the
# final Beamer file depends.
FIGURES = $(shell ls figures/*.tex | sed 's/tex$$/pdf/')

.PHONY: all clean

all: $(NAME).pdf

clean:
	latexmk -C
	rm -rf $(NAME).pdf
	cd figures ; latexmk -C ; cd ..

$(NAME).pdf: $(MAIN).pdf
	cp $(MAIN).pdf $(NAME).pdf

$(MAIN).pdf: $(MAIN).tex $(FIGURES)
	latexmk -xelatex $(MAIN).tex

# Here `%` is an automatic match, so anything in the `figure` directory that
# ends with `.pdf` is matched, and it depends on exactly the corresponding file
# `figures/%.tex`.
#
# The symbol `$<` denotes the first dependency, in this case its the
# `figures/$.tex` file.
#
# The symbol `$@` denotes the target file, in this case its the `figures/%.pdf`
# file. The symbol `$(@D)` denotes the directory of the target file.
figures/%.pdf: figures/%.tex
	latexmk -outdir=$(@D) -xelatex $<
