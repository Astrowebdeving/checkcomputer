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
sleep(0.1)
os.system(f"./secondshelltest.sh")
os.system(f"echo Outputting memory usage processes")
os.system(f"./memoryshell.sh")
#subprocess.run(["./", "newshelltest.sh"])
 
os.system("echo Total CPU Usage is:")
#os.system("mpstat")
#os.system("""top -bn2 | grep "Cpu(s)" | \
#           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
#           awk '{print 100 - $1"%"}'
#""")
os.system("""top -bn2 | grep "Cpu(s)" | awk '{print $2+$4}' | cat | awk 'NR>1 {print $1}'""")
os.system("echo Total RAM usage is:")

os.system("free -h | awk '{print $3}' | tr -d 'fre, ' | sed 's/ //g' | awk 'NR<3 {print $1}'")
os.system("echo Total Disk Space Usage is:")
os.system("df -m | awk '{sum+=$5;} END{print sum;}'")

print('My rank is', worker, ". The size is", size, ". The IP is", ip)

