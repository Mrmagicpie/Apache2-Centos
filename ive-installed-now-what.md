<h1 align="center">You've installed, now what?</h1>

## Thank you!

First off, I want to thank you for using my help. It means a lot to me that this project isn't a waste.

## How do I use this thing??

Really, you need to learn yourself. That's how I did it, that's how you should too. I made these scripts to help people get started.


### How do I add more sites?

If its on the same domain look at your ``/etc/httpd/conf.d/(domain).conf``, and you should be able to figure out how to add a site. If you can't, check out [this](https://centos-apache.mrmagicpie.xyz/examples/conf).

If you want the easy way, check out [this](https://centos-apache.mrmagicpie.xyz/scripts/add-site.sh) script to easily add a new domain.

### Oh, no, the server didn't start!

Please run
```
systemctl status apache2
```
please then inspect the output. If it says something about SSL, then your SSL certificates are probably not configured properly. Check ``/ssl`` for your SSL certificates. You will probably have to re-enter your SSL. 

### Where are my files?

Common files:
- SSL - ``/ssl``
- Apache2 Configuration - ``/etc/httpd``
- Website files - ``/var/www``
- Default Apache2 logs - ``/var/log``

As prompted in the install script(if you used one), your website files will be in ``/var/www/(domain)/website``, you must upload your files there for it to be accessable on the web. 

### Useful commands

Certain commands must be ran as root(sudo), and some commands will show different outputs if not ran with elevated privileges! For all purposes, run these commands with elevated privileges.

``systemctl restart apache2`` - Restart Apache2

``systemctl status apache2`` - Check the status of Apache2

``systemctl start apache2`` - Start Apache2, you can also use the *restart* command for this

``systemctl stop apache2`` - Stop Apache2

# More coming soon!
