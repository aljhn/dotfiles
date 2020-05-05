#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main(){
	FILE* file;
	char batteryString[4];
	int battery;

	char statusString[20];

	while(1){
		file = fopen("/sys/class/power_supply/BAT1/capacity", "r");
		fgets(batteryString, 4, file);
		fclose(file);
		sscanf(batteryString, "%d", &battery);
		if(battery < 20){
			system("i3 workspace 10");
		}
		sleep(60);

		file = fopen("/sys/class/power_supply/BAT1/status", "r");
		fgets(statusString, 20, file);
		fclose(file);
		if(strcmp(statusString, "Charging\n") == 0){
			return 0;
		}
	}
	return 0;
}
