
Make everybody able to rwx all files, but prevent deleting files not owned (1777 instead of 0777)

```bash
chmod 1777 /MRI_hackaton 
setfacl -d -m u::rwx,g::rwx,o::rwx /MRI_hackaton
```



