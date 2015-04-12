rpn:
	bison rpn.y
	gcc -O -lm -o rpn rpn.tab.c
normal:
	bison normal.y
	gcc -O -lm -o normal normal.tab.c
clean:
	rm -rf ./rpn ./rpn.tab.c ./normal ./normal.tab.c
