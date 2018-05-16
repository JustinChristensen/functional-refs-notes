PROGRAM := frefs

all: $(PROGRAM)

run: $(PROGRAM)
	@./$(PROGRAM)

$(PROGRAM): Main.hs
	ghc -o $@ $^

clean:
	rm -rf $(PROGRAM) *.hi *.o

.PHONY: all clean run
