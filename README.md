# Genealogy Visualizer

## Developed for the Language Processing class

Work developed for the Language Processing class. Using Lex and Yacc, this program parses a specific type of ontology (example files) representing a genealogy, producing a DOT file with the necessary information to represent said genealogy in a graph, which can be visualized with GraphViz.

Can be executed with:
 - make build
 - ./genealogy < one_of_the_example_files.txt
 - make graph                                         (generates graph.jpg)
 - feh graph.jpg                                      (I use feh, but you can replace feh with the program you use to visualize images)
