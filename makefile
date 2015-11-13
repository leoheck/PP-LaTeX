
# Makefile considerando pdflatex no ubuntu 

MAINTEX = exemplo
WORKDIR = metafiles

export TEXINPUTS := .:..:$(shell pwd)/class:$(shell pwd)/document:$(WORKDIR):${TEXINPUTS}

# export BIBINPUTS := document
# export BSTINPUT := $(WORKDIR)
# export TEXMFOUTPUT := $(WORKDIR)

all: pre-compile compile pos-compile

pre-compile: 
	@ mkdir -p $(WORKDIR)


# biber vs bibtex?


# compile:
# 	mkdir -p $(WORKDIR)
# 	TEXINPUTS="document:" pdflatex -output-directory $(WORKDIR) document/$(MAINTEX)
# 	BIBINPUTS="document:" BSTINPUT="$(WORKDIR):" TEXMFOUTPUT="$(WORKDIR):" bibtex $(WORKDIR)/$(MAINTEX)
# 	TEXINPUTS="document:" pdflatex -output-directory $(WORKDIR) document/$(MAINTEX)
# 	TEXINPUTS="document:" pdflatex -output-directory $(WORKDIR) document/$(MAINTEX)


compile:
	@ pdflatex \
		-halt-on-error \
		-shell-escape \
		-output-directory=$(WORKDIR) \
		$(MAINTEX)
	@ cd $(WORKDIR); \
		cp -f ../class/ppgcc-alpha.bst .; \
		cp -f ../document/exemplo-bib.bib .; \
		bibtex $(MAINTEX)
	@ pdflatex -halt-on-error -shell-escape -output-directory=$(WORKDIR) $(MAINTEX)
	@ pdflatex -halt-on-error -shell-escape -output-directory=$(WORKDIR) $(MAINTEX)
	@ makeglossaries -d $(WORKDIR) $(MAINTEX)
	@ pdflatex -output-directory=$(WORKDIR) $(MAINTEX)

pos-compile:
	@ cp -f $(WORKDIR)/$(MAINTEX).pdf $(MAINTEX).pdf


clean:
	@ rm -rf $(WORKDIR)

cleanall: clean
	@ rm -f $(MAINTEX).pdf


show: $(MAINTEX).pdf
	@ gnome-open $(MAINTEX).pdf