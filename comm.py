from mpi4py import MPI
import socket
from collections import Counter
from time import sleep
import os
import time
import subprocess

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
os.system("./allinfile.sh")
#endtime = time.process_time()
#os.system('date +"%T.%N"')
result = subprocess.run(['date', '+"%T.%N"'], capture_output=True, text=True)
completion_time = result.stdout.strip()
print(completion_time)
bash_command = f'export {'timeend'}="{completion_time}"'
with open(os.getenv('HOME') + '/.bashrc', 'a') as bashrc:
     bashrc.write(f'\n{bash_command}\n')
