/*
Farid Huseynov
150160904
System Programming
Group Project I
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int n_gram(char* str_1, int size_1, char* str_2, int size_2, int n);
int calculateSize(char* myStr){
    int size = 0;
    while(myStr[size] != NULL){
        size++;
    }
    return size;
}
int main(){
    int n;
    char str_1[10];
    char str_2[10];
    int size_1;
    int size_2;

    FILE * filep = fopen("input.txt", "r");
    if (filep == NULL){   
        printf("Error! Could not open file\n"); 
        exit(-1);
    }
    while (!feof(filep)){
        fscanf(filep, "%d %s %s", &n, str_1, str_2);
        size_1 = calculateSize(str_1);
        size_2 = calculateSize(str_2);
        
        printf("%d\n", size_1);
    }

    return 0;
}