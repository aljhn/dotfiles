#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(){
	while(1){
		FILE* file = fopen("/sys/class/power_supply/BAT1/capacity", "r");
		char string[4];
		fgets(string, 4, file);
		fclose(file);
		int battery;
		sscanf(string, "%d", &battery);
		printf("%d\n", battery);
		if(battery < 20){
			system("i3 workspace 10");
		}
		sleep(60);
	}
	return 0;
}
