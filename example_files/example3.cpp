#include <iostream>

// Global variables
int globalInt = 42;
float globalFloat = 3.14;
char globalChar = 'A';
int anotherGlob;

int main() {
    int sum = 0;
    // Print the values of the global variables
    for(int i= 0; i<globalInt; i++){
        sum = sum + 1;
    }

    // Change the values of the global variables
    globalInt = 24;
    globalFloat = 2.71;
    globalChar = 'B';
    anotherGlob = 50;

    for(int i= 0; i<anotherGlob; i++){
        sum = sum + 1;
    }

    return 0;
}