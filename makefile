CC = gcc
LEX = flex
CFLAGS = -lm
SCANNER = genealogy.c
OUTPUT = genealogy
GLIB = `pkg-config --cflags --libs glib-2.0`

build:
	$(LEX) -o $(SCANNER) genealogy.l
	yacc -v -d -t genealogy.y
	$(CC) y.tab.c $(CFLAGS) $(GLIB) -o $(OUTPUT)

graph:
	dot genealogy.dot -Tjpg -o graph.jpg

clean:
	rm -f y.* $(OUTPUT) $(SCANNER) *.jpg *.dot
