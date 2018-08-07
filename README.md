# Auto deploy Vitrolib and VIVO
Shell scripts to deploy application to debian9.

Download Debian9 from https://www.debian.org/distrib/. Install a clean new server with a sudo account and only a sshd server. Login to the server and execute the following commands:
For vitrolib:
```
wget https://github.com/tofkamp/autodeploy/raw/master/deployVitrolib.sh
chmod +x deployVitrolib.sh
sudo ./deployVitrolib.sh
```
For VIVO:
```
wget https://github.com/tofkamp/autodeploy/raw/master/deployVIVO-1.10.0.sh
chmod +x deployVIVO-1.10.0.sh
sudo ./deployVIVO-1.10.0.sh
```
