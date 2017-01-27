# Description #

This repository should hold packages and config files for running Debian on the Dell Precision (15) 5510.

Prebuilt packages can be found in the [builds](builds) directory.

My notes for the instal can be found at the following address:
http://craighesling.blogspot.com/2016/02/new-dell-precision-15-5510.html

The "tlp" file is the /etc/default/tlp file I currently use.

# Packages #

* power-management-dep
  This depends on packages I used to manage power on the Precision 5510

* firmware-iwlwifi-8260
  This is a package that bundles the latest bleeding-edge firmware for
  the Intel 8260 Wireless card, which is found in the Precision 5510.
  I hope that these firmwares can remedy some issues experienced by
  users of this wireless chipset.

# Installing TLP #

* Install dependency package `power-management-dep_1.0_all.deb`

  ```bash
  sudo dpkg -i builds/power-management-dep_1.0_all.deb
  sudo apt-get install -f
  ```
* Setup TLP

  You can use my `tlp` config file in this repository.
  Overwrite `/etc/default/tlp` with the `tlp` file in the repository.

* Install latest wifi chipset firmware `firmware-iwlwifi-8260_1.0_all.deb`
  ```bash
  sudo dpkg -i builds/firmware-iwlwifi-8260_1.0_all.deb
  ```
