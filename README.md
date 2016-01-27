Alpine+Runit+Telegraf
=====================

A base image that uses Alpine with Runit and starts the Telegraf agent to collect metrics. You will typically add other services to the
runit /etc/service directory (with a subdirectory with an executable file named 'run'), and modify EXTRA_PLUGINS to monitor that service.

Environment Variables
=====================

The build phase will substitute the env variables INFLUX_HOSTS and INFLUX_DB in telegraf.conf for the Influx database URL(s) and database, respectively.
In order to allow cluster URLs, you MUST include the quotes in your hosts, like

```
ENV INFLUX_HOSTS \"http://influxdb:8086\"
ENV INFLUX_HOSTS \"http://influxdb1:8086\",\"http://influxdb2:8086\"
```

The default INFLUX_DB is *telegraf*.

The build phase will also add whatever is in the EXTRA_PLUGINS environment variable to the configuration file in case you have other services to monitor.


