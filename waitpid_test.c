#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

main()
{
    pid_t pc,pr;
    pc=fork();
    if(pc<0)
        printf("Error occured on forking.\n");
    else if(pc==0)
    {
        sleep(4);
        exit(0);
    }

do
{
    pr=waitpid(pc,NULL,WNOHANG);
    if(pr==0)
    {
        printf("No child exited\n");
        sleep(1);
    }

}while(pr==0);

if(pr==pc)
    printf("successfully release child %d\n",pr);
else
    printf("some error occured\n");

    
}
