#!/bin/sh
echo "=> Starting Telegraf ..."
exec /bin/telegraf -config /config/telegraf.conf
