transform:	lex.yy.c
	gcc -o transform lex.yy.c -lfl

lex.yy.c:	xmlc.l
	flex xmlc.l

clean:
	rm -rf lex.yy.c transform
