# About Virtian
**Virtian** is a web user interface for virtual servers (based on KVM) management. It is designed primarily for Debian Linux 9.x, but it might work on other Linux distributions.

**Current version:** 0.01

## Screenshots



## Download



## Features

- Virtual server management
- Storage pools and volumes management
- Network management
- Server resources monitoring

## Installation

**Warning** - The following procedure is designed for clean installation of your server only. Do not install it on working environment, otherwise you might lose some of your data !!!

1. Download and install the latest version of Debian 9.x netinst ISO file from here: https://www.debian.org/CD/netinst/
2. Log in as **root** and run:

```sh
apt-get -y install git
git clone https://github.com/softsun-cz/virtian.git
cd virtian
chmod +x ./install.sh
./install.sh
reboot
```

3. Access Virtian web user interface via web browser on **https://[YOUR-SERVER-IP]**
4. Create the exception for https certificate
5. Log in with password **"admin123"**

## Settings

You can set some basic properties (password, web template path, installation ISO path etc.) by editing **/var/www/settings.php** file.

## License

This software is developed as open source under [**MIT License**](./LICENSE).

## Contact info
**Web page:** https://virtian.org

**E-mail:** info@virtian.org
