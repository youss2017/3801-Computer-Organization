#include <stdio.h>

// Note: The MIPs assembly cannot be converted directly to C because the lack of access to registers.
// however, this prototype attemps to be as close to the original MIPs code.

static const char* character_set = "knights";
int counter_array[7] = { 0 };

// count_letter:
void count_letter(char c) {
    if(c < 'a') {
        c += 32;
    }
    const char* address = character_set;
    char test_character = *address;
    while(test_character != '\0') {
        // valid_charset_letter:
        if(test_character == c) {
            counter_array[(int)(address - character_set)] += 1;
            break;
        }
        address = address + 1;
        test_character = *address;
    }
}

// print_output:
void print_output(int histogram_mode) {
    if(histogram_mode == 0) {
        for(int i = 0; i < 7; i++) {
            printf("%c: %d\n", character_set[i] - 32, counter_array[i]);
        }
    } else {
        for(int i = 0; i < 7; i++) {
            printf("%c: ", character_set[i] - 32);
            int value = counter_array[i];
            for(int j = 0; j < value; j++) {
                putchar('#');
            }
            putchar('\n');
        }
    }
}

int main() {
    // const char* sample_text = "Lorem, ipsum.";
    // const char* sample_text = "Lorem ipsum dolor sit.";
    // const char* sample_text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit.";
     const char* sample_text = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum maxime magni nostrum soluta est dolores ad?";
    // const char* sample_text = "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Modi quas, voluptatum laudantium incidunt voluptatibus blanditiis provident vitae voluptate exercitationem recusandae ullam distinctio libero sit quos delectus vero nostrum ex cupiditate ipsa atque.";

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