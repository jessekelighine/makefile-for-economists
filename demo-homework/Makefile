# Example Makefile

# This speficies targets that are not real files, but "phony".  These phony
# targets are code word for specific actions.  Phony targets such as `all` and
# `clean` are very common. The target `all` often represent the main target;
# the target `clean` often represent the action to remove all generated
# targets.
.PHONY: all clean

# If `make` is run without any arguments, then `all` will be run.  In this case,
# `all` depends on `homework.zip`.
all: homework.zip

# If `make clean` is run, then all the generated targets and side effects are
# removed according to the following commands.
clean:
	rm -rf regression-table.txt
	rm -rf diagram.pdf
	rm -rf homework.{zip,aux,log,pdf}

# File homework.zip depends on homework.pdf. Whenever homework.pdf is changed,
# homework.zip is re-zip to include the changes
homework.zip: homework.pdf code-1.R code-2.R
	zip homework.zip homework.pdf code-1.R code-2.R

# Here the main LaTeX file is compiled. File homework.pdf depends on the `.tex`
# file and also the regression output and figure included in the `.tex` file.
homework.pdf: homework.tex regression-table.txt diagram.pdf
	pdflatex homework.tex
	pdflatex homework.tex

regression-table.txt: code-1.R data.csv
	Rscript code-1.R

# `diagram.pdf` file depends on `code-2.R` and `data.csv`, whenever `code-2.R`
# or `data.csv` is changed or `diagram.pdf` does not exist, then run the
# command `Rscript code-2.R`.
diagram.pdf: code-2.R data.csv
	Rscript code-2.R
