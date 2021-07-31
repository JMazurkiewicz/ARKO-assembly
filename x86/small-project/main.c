#include "dcompl.h"
#include <stdio.h>
#include <string.h>

int main(int argc, char* argv[]) {

        if(argc < 3) {
                printf("Error");
                return 0;
        }

        char* const text = argv[1];
        const int digit = argv[2][0] - '0';

        if(digit < 0 || digit > 9) {
                printf("Invalid input: %d\n", digit);
        } else {

                char* const result = dcompl(text, digit);
                printf("%s\n", result);

        }

}
