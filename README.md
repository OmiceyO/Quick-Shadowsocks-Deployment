What is Shadowsocks? 
- https://en.wikipedia.org/wiki/Shadowsocks

# Quick-Shadowsocks-Deployment
Quick Shadowsocks deployment for Linux servers, specifically Ubuntu 20.04 & 22.04   
Step-by-Step video guide: https://www.youtube.com/watch?v=xPM4elJtxCs

1) Get yourself an Ubuntu 20.04 or 22.04 server from a VPS provider (Linode, DigitalOcean, etc.) which costs about 5$ a month.
- https://www.linode.com
- https://www.digitalocean.com
- There are more VPS providers out there, feel free to check them out.
2) SSH into your server:
- If you are on Windows use PowerShell/CMD or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/)
- On Linux, macOS or Windows 11, just use ssh directly from the terminal like so -> `ssh root@YOUR SERVER's IP`
3) Update the server and install Snap with ->   
```
curl https://raw.githubusercontent.com/OmiceyO/Quick-Shadowsocks-Deployment/main/ubuntu-20.04-setup.sh | bash
```
- On 22.04 press ENTER at any prompt that shows up until it asks you to manualy reboot. Then press CTRL+C and type in "reboot".
4) Your server just rebooted, keep calm and SSH into it again then proceed to step 5.
5) Install Shadowsocks with ->   
```
curl https://raw.githubusercontent.com/OmiceyO/Quick-Shadowsocks-Deployment/main/ubuntu-20.04-ss.sh | bash
```
6) Change the default password by editing this file ->
```
nano /var/snap/shadowsocks-libev/common/etc/shadowsocks-libev/config.json
```
7) After you input your new password, press ***CONTROL + O*** then ***ENTER*** to save, and later ***CONTROL+X*** to exit.
8) Reboot the server again after changing your password -> `reboot`
9) You are done, get yourself a client from the releases section.
- For Windows : https://github.com/shadowsocks/shadowsocks-windows
- For macOS : https://github.com/shadowsocks/ShadowsocksX-NG
- For Android : https://github.com/shadowsocks/shadowsocks-android
