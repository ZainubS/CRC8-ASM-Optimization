#define _DEFAULT_SOURCE
#define TRIALS 1000000L

#include <stdio.h>
#include <string.h>
#include <sys/time.h>

void crcInit(void);
char crcFast(char* message, long nBytes);

int main(int argc, char*argv[])
{
  unsigned char retval = 0;
  long i = 0;
  struct timeval time_start;
  struct timeval time_end;
  struct timeval time_duration;
  float time_per_iteration = 0;

  if (argc != 2)
  {
    printf("\n");
    printf("Insufficient number of arguments provided.\n");
    printf("Example: %s message\n", argv[0]);
    printf("(Note, if your message has spaces in it, you may need to surround it in \"quotes\"!)\n");
    printf("\n");
    printf("\n");
    printf("Exiting.\n\n");
    return 1;
  }

  printf("\n\nProcessing...\n");
  
  gettimeofday(&time_start, NULL);
  
  for (i = 0; i < TRIALS; i++) 
  {
      crcInit();
      retval = crcFast(argv[1], strlen(argv[1]));
  }
  
  gettimeofday(&time_end, NULL);  

  timersub(&time_end, &time_start, &time_duration);
  time_per_iteration = (((float) time_duration.tv_sec * 1000000) + (float) time_duration.tv_usec) / i;

  printf("\n");
  printf("Results\n");
  printf("=======\n\n");
  printf("Message:  \"%s\"\n", argv[1]);
  printf("CRC:  %X\n", retval);
  printf("Iterations run:  %ld\n", i);
  printf("Total execution time:  %ld seconds %ld usec.\n", time_duration.tv_sec, time_duration.tv_usec);
  printf("Time per iteration:  %f usec.\n\n", time_per_iteration);

  return 0;
}
