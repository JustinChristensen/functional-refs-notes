BINDIR := bin
SRCDIR := src
PROGRAM := $(BINDIR)/frefs
PROGRAM_SRCS := $(SRCDIR)/Main.hs

all: $(PROGRAM)

run: $(PROGRAM)
	@./$(PROGRAM)

$(BINDIR):
	mkdir -p $@

$(PROGRAM): $(PROGRAM_SRCS) | $(BINDIR)
	ghc -i$(SRCDIR) -o $@ $(GHC_FLAGS) $^

clean:
	rm -rf $(BINDIR) *.hi *.o

.PHONY: all clean run
