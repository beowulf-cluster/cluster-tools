# Fai Installation Guide

This is a step by step Fai installantion for a testing environment. You can change some steps to your needs.

This setup was tested using VirtualBox whithin Ubuntu 16.04. The environment is a standalone Debian System with basic system and SSH Server installed.

## Some considerations :shipit:

- This setup is intended to setup a Beowulf Cluster. The fai server will be installed in the `font-end` machine
- The Fai server hostname will be `faiserver`
- We will be using the network: `192.168.0.0/24` as our internal network
- The `faiserver`'s IP Addres will be: `192.168.0.1` and also our gateway **and** our `DHCP server`
- We will use the `demohost`sample inside fai's preinstalled configuration space

## The recipe :page_facing_up:

1. Use the script `basic_setup.sh` inside this folder.  It is **highly recommended** to use this since it uses the lastest version of FAI server available. The dfficial Debian package is kinda outdated and the author has automated the fai config space already. Comments inside the script.

2. Check your `/etc/hosts` and your `/etc/hostname` files. They **must** be configured for `fai-setup` and for booting via network using PXE

Some configuration examples:
```bash
#/etc/hostname
faiserver
```

```bash
#/etc/hosts
127.0.0.1	localhost
127.0.1.1	localhost

# Fai Server:
192.168.0.1   faiserver

# Your PXE Clients:
192.168.0.100    demohost
```
If your system points `127.0.*1*.1` to `faiserver`, change it or `#comment` this line.

3. Run `fai-setup -v` and check if everythind went well.

4. Check your `nfs`server entries to match your Fai server's IP Address:

```bash
#/etc/exports
/srv/nfs4  192.168.0.1/24(fsid=0,async,ro,no_subtree_check)
/srv/fai/config 192.168.0.1/24(async,ro,no_subtree_check)
/srv/fai/nfsroot 192.168.0.1/24(async,ro,no_subtree_check,no_root_squash)
```

Restart your nfs server:

`service nfs-kerner-server restart`

5. Configure your `dhcp server`:

Luckly, Thomas wrote an example locate in:

"/usr/share/doc/fai-doc/examples/etc/dhcpd.conf"

Copy it:
```bash
# as root, man

# Backups always are a good idea:
mv /etc/dhcp/dhcpd.conf /etc/dhcp/bak.dhcpd.conf 

# Copy Thomas' sample
cp /usr/share/doc/fai-doc/examples/etc/dhcpd.conf /etc/dhcp/
```

Changing it to our example, it will look like this:

```bash
# dhcpd.conf for a fai installation server
# replace faiserver with the name of your install server

deny unknown-clients;
option dhcp-max-message-size 2048;
use-host-decl-names on;
#always-reply-rfc1048 on;

subnet 192.168.0.0 netmask 255.255.255.0 {
   option routers 192.168.0.1;
   option domain-name "fai";
   option domain-name-servers 192.168.0.1, 8.8.8.8, 8.8.4.4;
   option time-servers faiserver;
   option ntp-servers faiserver;
   server-name faiserver;
   next-server faiserver;
   filename "fai/pxelinux.0";
}

# generate a lot of entries with:
# perl -e 'for (1..10) {printf "host client%02s {hardware ethernet XXX:$_;fixed-address client%02s;}\n",$_,$_;}'
# then replace XXX with the hardware addresses of your clients

# Change here to your client's mac address
host demohost {hardware ethernet aa:bb:cc:dd:ee:ff ; fixed-address demohost;}

```
### Important notes :shipit:

- I've set up the directive `option domain-name-servers` including Google's DNS Servers. You can use other **valid** ones. In the moment of this tutorial, I didn't figured out why the clients can't reach the Internet only with the gateway itself as a DNS.

- the last line can be added manually or using the  command:

`dhcp-edit demohost aa:bb:cc:dd:ee:ff`
	
6. Check the DHCP Server listening interface:

```bash
# File /etc/default/isc-dhcp-server

# In newer Debian Based distributions the notation is something like: enpXSY

INTERFACESv4="ethx"
INTERFACESv6=""
```

and restart your server:

`# /etc/init.d/isc-dhcp-server restart`

Every time you add new hosts, **don't forget** to restart the DHCP Server.

7. Enable NAT for your Internal Network

Check out the `enable_nat.sh`included in this folder.

8. Run `fai-monitor`and boot your clients

9. Play the waiting game :video_game: