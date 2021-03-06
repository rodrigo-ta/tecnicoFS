# Makefile, versao 1
# Sistemas Operativos, DEI/IST/ULisboa 2020-21

CC   = gcc
LD   = gcc
CFLAGS =-Wall -std=gnu99 -I../
LDFLAGS=-lm

# A phony target is one that is not really the name of a file
# https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
.PHONY: all clean run

all: tecnicofs-server

tecnicofs-server: fs/state.o fs/operations.o locks/rwlock.o locks/mutex.o locks/conditions.o tecnicofs-server.o
	$(LD) $(CFLAGS) $(LDFLAGS) -g -o tecnicofs-server fs/state.o fs/operations.o locks/rwlock.o locks/mutex.o locks/conditions.o tecnicofs-server.o -lpthread

fs/state.o: fs/state.c fs/state.h ../tecnicofs-api-constants.h
	$(CC) $(CFLAGS) -o fs/state.o -c fs/state.c

fs/operations.o: fs/operations.c fs/operations.h fs/state.h ../tecnicofs-api-constants.h
	$(CC) $(CFLAGS) -o fs/operations.o -c fs/operations.c

locks/rwlock.o: locks/rwlock.c locks/rwlock.h
	$(CC) $(CFLAGS) -o locks/rwlock.o -c locks/rwlock.c

locks/mutex.o: locks/mutex.c locks/mutex.h 
	$(CC) $(CFLAGS) -o locks/mutex.o -c locks/mutex.c

locks/conditions.o: locks/conditions.c locks/conditions.h 
	$(CC) $(CFLAGS) -o locks/conditions.o -c locks/conditions.c

tecnicofs-server.o: tecnicofs-server.c locks/rwlock.h locks/mutex.h locks/conditions.h fs/operations.h fs/state.h ../tecnicofs-api-constants.h
	$(CC) $(CFLAGS) -o tecnicofs-server.o -c tecnicofs-server.c

clean:
	@echo Cleaning...
	rm -f fs/*.o locks/*.o *.o tecnicofs-server

run: tecnicofs-server
	./tecnicofs-server 4 serversocket
