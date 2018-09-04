#!/bin/sh

# TODO: dynamic params
exec /usr/bin/dbus-daemon --session --print-address=2 2> ${SESSION_BUS_ADDRESS_FILE}.in
