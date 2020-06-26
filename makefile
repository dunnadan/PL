CC = gcc
LEX = flex
CFLAGS = -Wall -lm
SCANNER = genealogy.c
OUTPUT = genealogy
GLIB = `pkg-config --cflags --libs glib-2.0`

build:
	$(LEX) -o $(SCANNER) genealogy.l
	yacc -v -d -t genealogy.y
	$(CC) y.tab.c $(CFLAGS) $(GLIB) -o $(OUTPUT)

clean:
	rm -f y.* $(OUTPUT) $(SCANNER)
