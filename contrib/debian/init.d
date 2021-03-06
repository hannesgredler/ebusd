#!/bin/sh

### BEGIN INIT INFO
# Provides:        ebusd
# Required-Start:  $network $remote_fs $syslog
# Required-Stop:   $network $remote_fs $syslog
# Default-Start:   2 3 4 5
# Default-Stop: 
# Short-Description: Start EBUS daemon
### END INIT INFO

PATH=/sbin:/bin:/usr/sbin:/usr/bin

. /lib/lsb/init-functions

DAEMON=/usr/local/bin/ebusd
PIDFILE=/var/run/ebusd.pid

test -x $DAEMON || exit 5

case $1 in
	start)
		log_daemon_msg "Starting EBUS server" "ebusd"
  		start-stop-daemon --start --quiet --oknodo --pidfile $PIDFILE --startas $DAEMON -- -P $PIDFILE
		status=$?
		log_end_msg $status
  		;;
	stop)
		log_daemon_msg "Stopping EBUS server" "ebusd"
  		start-stop-daemon --stop --quiet --oknodo --pidfile $PIDFILE
		log_end_msg $?
		rm -f $PIDFILE
  		;;
	restart|force-reload)
		$0 stop && sleep 2 && $0 start
  		;;
	status)
		status_of_proc $DAEMON "EBUS server"
		;;
	*)
		echo "Usage: $0 {start|stop|restart|force-reload|status}"
		exit 2
		;;
esac
