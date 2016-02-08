The [Datadog Agent](https://github.com/DataDog/dd-agent) faithfully collects events and metrics and brings them to Datadog on your behalf so that you can do something useful with your monitoring and performance data.

This package installs the [Datadog Agent](https://github.com/DataDog/dd-agent), customized for installation on a FreeBSD machine.

### Installation

To install:
`sudo make install clean`

### After Installation
1. After installed, edit /etc/rc.conf to enable the supervisord and datadog services.
   
   ```
   supervisord_enable="YES"
   datadog_enable="YES"
   ```
2. Edit /usr/local/etc/datadog.conf to include your API Key.
3. Start the supervisord and datadog services.
   
   ```
   sudo service supervisord start
   sudo service datadog start
   ```


