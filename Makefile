# Makefile, versao 1
# Sistemas Operativos, DEI/IST/ULisboa 2020-21

CC   = gcc
LD   = gcc
CFLAGS =-Wall -std=gnu99 -I../
LDFLAGS=-lm

# A phony target is one that is not really the name of a file
# https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
.PHONY: all clean run

all: tecnicofs

tecnicofs: fs/state.o fs/operations.o sync.o mutex.o main.o
	$(LD) $(CFLAGS) $(LDFLAGS) -o tecnicofs fs/state.o fs/operations.o sync.o mutex.o main.o -lpthread

fs/state.o: fs/state.c fs/state.h tecnicofs-api-constants.h
	$(CC) $(CFLAGS) -o fs/state.o -c fs/state.c

fs/operations.o: fs/operations.c fs/operations.h fs/state.h tecnicofs-api-constants.h
	$(CC) $(CFLAGS) -o fs/operations.o -c fs/operations.c

sync.o: sync.c sync.h
	$(CC) $(CFLAGS) -o sync.o -c sync.c

mutex.o: mutex.c mutex.h 
	$(CC) $(CFLAGS) -o mutex.o -c mutex.c

main.o: main.c sync.h mutex.h fs/operations.h fs/state.h tecnicofs-api-constants.h
	$(CC) $(CFLAGS) -o main.o -c main.c

clean:
	@echo Cleaning...
	rm -f fs/*.o *.o tecnicofs otest.txt out1.txt out2.txt out3.txt out4.txt

run: tecnicofs
	./tecnicofs itest.txt otest.txt 8 mutex

run1: tecnicofs
	./tecnicofs inputs/test1.txt out1.txt 3 mutex

run2: tecnicofs
	./tecnicofs inputs/test2.txt out2.txt 1 nosync

run3: tecnicofs
	./tecnicofs inputs/test3.txt out3.txt 2 rwlock

run4: tecnicofs
	./tecnicofs inputs/test4.txt out4.txt 4 rwlock	