PROGRAM := frefs
BINDIR := bin

all: $(PROGRAM)

$(BINDIR):
	mkdir -p $(BINDIR)

$(BINDIR)/$(PROGRAM): Main.hs | $(BINDIR)
	ghc -o $@ $^

clean:
	rm -r $(BINDIR)

.PHONY: all clean
