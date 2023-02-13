#include <stdio.h>

int main() {
    int sum = 0;
    int add = 1 + 2 + 3;
    int a = sum + 5;
    int b = 4 + add;
    int d = a + b;

    for(int i = 100; i>b; i--) {
        for(int i = 0; i<d; i++){
            sum = sum + 1;
        }
    }

    for(int i = 0; i<5; i++){
            if(i == 2){
                sum = sum + 1;
            }
            else {
                sum = sum + 2;
            }
    }

    printf("Loop: %d", sum);
}