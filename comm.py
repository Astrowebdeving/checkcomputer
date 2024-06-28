from mpi4py import MPI
import socket
from collections import Counter
from time import sleep
import os

comm = MPI.COMM_WORLD
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(("8.8.8.8", 80))
ip = s.getsockname()[0]
print(ip)
s.close()
size = comm.Get_size()
worker = comm.Get_rank()

if worker == 0:
    data = [x+1 for x in range(size)]

os.system(f"echo Outputting Disk Space Usage")
os.system(f"./newshelltest.sh")
os.system(f"echo Outputting CPU processes and usage")
os.system(f"./secondshelltest.sh")
os.system(f"echo Outputting memory usage processes")
os.system(f"./memoryshell.sh")
#subprocess.run(["./", "newshelltest.sh"])
os.system("./allinfind.sh")
f = open("allinfile.txt", "r")
contents = f.read()
print('My rank is', worker, ". The size is", size, ". The IP is", ip, ". ", contents)
f.close()
 




