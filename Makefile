# NOTE: All indented lines are indented with a tab character.

.PHONY: clean
CFLAGS= -ansi -pedantic -O0 -Wall -Werror -no-pie
DFLAGS = -g

all: hw3 hw4crc

hw3: hw3.o crc.o
	gcc -g -o hw3 $(CFLAGS) $(DFLAGS) hw3.o crc.o
	
hw3.o: hw3.c
	gcc -c -g -o hw3.o $(CFLAGS) $(DFLAGS) hw3.c

crc.o: crc.c
	gcc -c -g -o crc.o $(CFLAGS) $(DFLAGS) crc.c


#########################################################################
#  Modify the 'clean' and 'zip' target to include your own source files #
#########################################################################

clean:
	rm -f *.o hw3 hw4crc

zip:
	zip ${USER}.zip Makefile hw3.c crc.c hw4crc.s


#####################################################
#  Add your additional Make targets below this line #
#####################################################

# Assignment 4
hw4crc: hw3.o hw4crc.o
	gcc -g -o hw4crc $(CFLAGS) $(DFLAGS) hw3.o hw4crc.o

hw4crc.o: hw4crc.s
	as --64 -o hw4crc.o hw4crc.s


