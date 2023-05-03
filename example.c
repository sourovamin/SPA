#include <stdio.h>

int main() {
    int sum = 0;
    int add = 1 + 2 + 3;
    int a = sum + 5;
    int b = 4 + add;
    int c = a + b;

    for(int i = 100; i>b; i--) {
        for(int j = 0; j<c; j++){
            sum = sum + 1;
        }
    }

    for(int i = 0; i<10; i++){
        sum = sum + 1;
    }
}