#include <stdio.h>

// Note: The MIPs assembly cannot be converted directly to C because the lack of access to registers.
// however, this prototype attemps to be as close to the original MIPs code.
int register_file[7] = { 0 };

// count_letter:
void count_letter(char c) {
    if(c < 'a') {
        c += 32;
    }
    if(c == 'k') register_file[0]++;
    else if(c == 'n') register_file[1]++;
    else if(c == 'i') register_file[2]++;
    else if(c == 'g') register_file[3]++;
    else if(c == 'h') register_file[4]++;
    else if(c == 't') register_file[5]++;
    else if(c == 's') register_file[6]++;
}

// print_output:
void print_output(int histogram_mode) {
    if(histogram_mode == 0) {
        printf("%c: %d\n", 'K', register_file[0]);
        printf("%c: %d\n", 'N', register_file[1]);
        printf("%c: %d\n", 'I', register_file[2]);
        printf("%c: %d\n", 'G', register_file[3]);
        printf("%c: %d\n", 'H', register_file[4]);
        printf("%c: %d\n", 'T', register_file[5]);
        printf("%c: %d\n", 'S', register_file[6]);
    } else {
        printf("%c: ", 'K');
        for(int i = 0; i < register_file[0]; i++) putchar('#');
        printf("\n%c: ", 'N');
        for(int i = 0; i < register_file[1]; i++) putchar('#');
        printf("\n%c: ", 'I');
        for(int i = 0; i < register_file[2]; i++) putchar('#');
        printf("\n%c: ", 'G');
        for(int i = 0; i < register_file[3]; i++) putchar('#');
        printf("\n%c: ", 'H');
        for(int i = 0; i < register_file[4]; i++) putchar('#');
        printf("\n%c: ", 'T');
        for(int i = 0; i < register_file[5]; i++) putchar('#');
        printf("\n%c: ", 'S');
        for(int i = 0; i < register_file[6]; i++) putchar('#');
        putchar('\n');
    }
}

int main() {
    // const char* sample_text = "Lorem, ipsum.";
    // const char* sample_text = "Lorem ipsum dolor sit.";
    // const char* sample_text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit.";
    // const char* sample_text = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum maxime magni nostrum soluta est dolores ad?";
    // const char* sample_text = "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Modi quas, voluptatum laudantium incidunt voluptatibus blanditiis provident vitae voluptate exercitationem recusandae ullam distinctio libero sit quos delectus vero nostrum ex cupiditate ipsa atque.";

    // const char* sample_text = "!@#$%%^&*()_+135790-=";
    // const char* sample_text = "KNIGHTS ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const char* sample_text = "knights abcdefghijklmnopqrstuvwxyz";

    const char* address = sample_text;
    char c = *address;
    while(c != '\0') {
        count_letter(c);
        address = address + 1;
        c = *address;
    }

    print_output(0);
    print_output(1);
}