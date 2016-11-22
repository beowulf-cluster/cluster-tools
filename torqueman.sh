#!/bin/bash

start_torque(){

	/etc/init.d/torque-server start
	/etc/init.d/torque-scheduler start
	/etc/init.d/torque-mom start
}

stop_torque(){

	/etc/init.d/torque-mom stop
	/etc/init.d/torque-scheduler stop
	/etc/init.d/torque-server stop
}

case $1 in
   "start")
	echo -e "Iniciando Torque Server\n"
	start_torque
   ;;
   "stop")
	echo -e "Parando Torque Server\n"
	stop_torque
    ;;
    "restart")
	echo -e "Reiniciando Torque Server:\n"
	
	echo "Parando Serviços:"
	stop_torque

	echo "Iniciando Serviços:"
	start_torque
    ;;
   *)
	echo "Usage: start|stop|restart";
	exit 1;
esac

