#!/bin/sh
# weather.sh
# shell script to prepend i3status with weather
line="[{'name':'load','markup':'pango','full_text':'<span background='#f59335'>  0.44 Load </span>'},{'name':'disk_info','instance':'/','markup':'pango','full_text':'<span background='#fec7cd'>  286.9 GiB Free </span>'},{'name':'disk_info','instance':'/home','markup':'pango','full_text':''},{'name':'ethernet','instance':'enp5s0','markup':'pango','full_text':'<span background='#88c0d0'>  192.168.2.71 </span>'},{'name':'wireless','instance':'wlp3s0','markup':'pango','full_text':'<span background='#b48ead'>  Scarlett 5G </span>'},{'name':'volume','instance':'default.Master.0','markup':'pango','full_text':'<span background='#ebcb8b'>  37% </span>'},{'name':'battery','instance':'/sys/class/power_supply/BAT0/uevent','markup':'pango','full_text':'<span background='#a3be8c'>  Charging 85.49% </span>'},{'name':'tztime','instance':'local','markup':'pango','full_text':'<span background='#81a1c1'>  Sun 5 Dec 10:39 </span>'}]"
while :
do
  read -r line
  weather=$(cat ~/.weather.cache)
  weather_json='"name":"weather","color":"#FFFFFF", "full_text":'
  weather_json+=$(echo -n "$weather" | python -c 'import json,sys; print json.dumps(sys.stdin.read())')
  weather_json+='},{'
  printf $weather_json
  # Inject our JSON into $line after the first [{
  # echo "$line" | sed "s/[{/[{$weather_json" || exit 1
  exit 1
done
