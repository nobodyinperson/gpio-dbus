% gpio-dbus-service(1) | gpio-dbus-service manpage

NAME
====

**gpio-dbus-service** - provide DBus access to the raspberry pi's GPIO.


SYNOPSIS
========

**gpio-dbus-service** - start the GPIO DBus service


SYSTEMD
=======

There is also a **systemd** unit, called **gpio-dbus.service**.
You may as well start **gpio-dbus-service** via

sudo systemctl start gpio-dbus


FILES
=====

| File                         | purpose                                   |
|------------------------------|-------------------------------------------|
| /etc/gpio-dbus/service.conf  | **gpio-dbus-service** configuration file  |


AUTHOR
======

Yann Büchau <yann.buechau@web.de>


SEE ALSO
========

the package manpage **gpio-dbus(1)**


