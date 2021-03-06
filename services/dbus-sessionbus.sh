#!/bin/sh
# D-Bus session bus daemon startup/shutdown script
#
# Copyright (C) 2004-2006 Nokia Corporation. All rights reserved.
#
# Contact: Gabriel Schulhof <gabriel.schulhof@nokia.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 2 as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
# 02110-1301 USA

# TODO: to not hardcode this path?
PROG=/etc/osso-af-init/dbus-wrapper.sh
#PROG=/usr/bin/dbus-daemon
SVC="D-BUS session bus daemon"

case "$1" in
start)
  . $LAUNCHWRAPPER_NICE_KILL start "$SVC" $PROG
  # XXX: This sleep is hacky, we should perhaps just use a fifo in the
  # dbus-wrapper, so that the cat will block instead
  sleep 5
  if [ -r ${SESSION_BUS_ADDRESS_FILE}.in ]; then
    TMP=`cat ${SESSION_BUS_ADDRESS_FILE}.in`
    echo "export DBUS_SESSION_BUS_ADDRESS=$TMP" > $SESSION_BUS_ADDRESS_FILE
    rm -f ${SESSION_BUS_ADDRESS_FILE}.in
  fi
  ;;
stop)
  # giving parameter also here so that dsmetool works...
  . $LAUNCHWRAPPER_NICE_KILL stop "$SVC" $PROG
  ;;
*)
  echo "Usage: $0 {start|stop}"
  exit 1
  ;;
esac
