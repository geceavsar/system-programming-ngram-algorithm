/*
System Programming
Group Project I
Farid Huseynov
150160904
Ekin Celebi
150160152
Gizem Ece Avsar
040140303
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int ngram(char* str_1, int size_1, char* str_2, int size_2, int n);
int calculateSize(char* myStr){
    int size = 0;
    while(myStr[size] != '\0'){
        size++;
    }
    return size;
}
int main(){
    int n;
    char str_1[80];
    char str_2[80];
    int size_1;
    int size_2;
    int result;

    FILE * filep = fopen("input_tab.txt", "r");
    if (filep == NULL){   
        printf("Error! Could not open file\n"); 
        exit(-1);
    }
    while (!feof(filep)){
        fscanf(filep, "%d\t%s\t%s", &n, str_1, str_2);
        size_1 = calculateSize(str_1);
        size_2 = calculateSize(str_2);
        
        //printf("%d\n", size_1);
        
        result = ngram(str_1,size_1,str_2,size_2,n);
        printf("%d\n",result);
    }

    return 0;
}
