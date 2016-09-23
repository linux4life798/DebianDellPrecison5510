This repository should hold packages and config files for running Debian on the Dell Precision (15) 5510.

My notes for the install can be found at the following address:
http://craighesling.blogspot.com/2016/02/new-dell-precision-15-5510.html

The "tlp" file is the /etc/default/tlp file I currently use.

# Installing TLP #

* Install dependency package `power-management-dep_1.0_all.deb`

  ```bash
  sudo dpkg -i power-management-dep_1.0_all.deb
  sudo apt-get install -f
  ```
* Setup TLP

  You can use my `tlp` config file in this repository.
  Overwrite `/etc/default/tlp` with the `tlp` file in the repository.
