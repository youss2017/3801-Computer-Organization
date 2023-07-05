#include <stdio.h>

void print_binary(int v) {
    char str[32];
    for (int i = 0; i <= 31; i++) {
        str[(31 - i)] = v & (1 << i) ? '1' : '0';
    }
    printf("%.32s", str);
}

int main() {
    int A, B, C, D;
    printf("Enter 4 integers for A, B, C, D respectively:\n");
    putchar('\n');
    scanf("%d", &A);
    putchar('\n');
    scanf("%d", &B);
    putchar('\n');
    scanf("%d", &C);
    putchar('\n');
    scanf("%d", &D);
    putchar('\n');

    // Compute 5*B
    int f1 = 0;
    for (int i = 5; i > 0; i--) {
        f1 = f1 + B;
    }
    // Compute 5*B*D
    int f2 = 0;
    for (int i = D; i > 0; i--) {
        f2 = f2 + f1;
    }
    // Compute 5*B*D+A
    int f = f2 + A;

    printf("f_ten = %d\n\n", f);
    printf("f_two = ");
    print_binary(f);
    puts("\n");

    // D*D
    int g1 = 0;
    for (int i = D; i > 0; i--) {
        g1 = g1 + D;
    }

    // Compute C*A
    int g2 = 0;
    for (int i = A; i > 0; i--) {
        g2 = g2 + C;
    }

    // Compute D*D-C*A
    int g = g1 - g2;
    printf("g_ten = %d\n\n", g);
    printf("g_two = ");
    print_binary(g);
    puts("\n\n");
    
    return 0;
}