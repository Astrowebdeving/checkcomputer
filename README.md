# checkcomputer
##Program setup and environment:



#In order to run this program, it is necessary to first set up an openssh server and have libopenmpi installed on all the servers. Enable passwordless SSH through rsa keys with the same username on all servers and store them in the authorization_keys file. It is necessary to keep the permissions not overly high in the ssh directory, all the files in it, and the home directory in order for passwordless SSH to work. Afterwards, setup the NFS server to enable file sharing so that all the files run on the different servers can be accessed on the head machine. All the workers should use NFS common system and the NFS server is on the head machine. Mount the head machine on a directory on the worker machines.  



#The code runs on the manager and worker nodes. If you do not want to run on the manager machine, make sure to create an exception using an if statement referencing rank 0 as the manager node will be rank 0 in mpi. 

