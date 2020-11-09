#ifndef FS_H
#define FS_H
#include "state.h"
#include "../locks/rwlock.h"
#include <pthread.h>
#include <unistd.h>
#include <stdlib.h>

#define TRYWRITE 0
#define WRITE 1
#define READ 2
#define MAXSLEEPTIME 1

void init_fs();
void destroy_fs();
int exit_and_unlock(Locks*);
int is_dir_empty(DirEntry*);
int exit_create_with_message(char*, char*, char*, Locks*, char*);
int create(char*, type);
int verify_source_parent(Locks*, char*, char*, char*);
int verify_destination_parent(Locks*, char*, char*, char*);
int move(char*, char*);
int delete(char*);
int lookup(char*);
int lookup_node(char*, Locks*, int);
void print_tecnicofs_tree(FILE*);

#endif /* FS_H */
