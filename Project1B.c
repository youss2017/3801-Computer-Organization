#include <stdio.h>

int main() {
    int f_ten, g_ten;
    // Prompt user
    printf("f_ten = ");
    scanf("%d", &f_ten);
    putchar('\n');

    printf("g_ten = ");
    scanf("%d", &g_ten);
    putchar('\n');

    int h1 = f_ten + 2;
    int h2 = g_ten - 2;
    int h_quotient = 0;
    int h_remainder = 0;
    while (h1 > 0) {
        h1 = h1 - h2;
        h_quotient++;
    } 

    if (h1 < 0) {
        h_quotient = h_quotient - 1;
        h_remainder = h1 + h2;
    }

    printf("h_quotient = %d\n\n", h_quotient);
    printf("h_remainder = %d\n\n", h_remainder);

    // (f_ten-25) MOD h_remainder
    int i1 = f_ten - 25;
    int i_remainder = 0;
    while (i1 > 0) {
        i1 = i1 - h_remainder;
    }
    if (i1 < 0) {
        i_remainder = i1 + h_remainder;
    }
    printf("i_mod = %d", i_remainder);

    return 0;
}
