#include <stdio.h>
#include <stdlib.h>

int main(){
    int u_input;
    int i;
    double fiboa = 1;
    double fibob = 1; 
    double fiboc = 1;

    printf("Simple C program to calculate Fibonacci numbers. \n");
    printf("How many iterations of Fibonacci numbers to display: ");
    scanf("%d", &u_input);
    
    for (i=1; i<=u_input; i++){
        fiboc = fiboa + fibob;
        fibob = fiboa;
        fiboa = fiboc;
        printf("%.0lf \n", fiboc);
    }
}