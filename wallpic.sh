#!/bin/sh
filepath=$(dirname $(readlink -f $0))'/'

iniconf=${filepath}wallpic.ini
echo $filepath

while true; do
    choose='"['$(awk -F '=' '$1=="choose" {print $2}' ${iniconf} )']"'

    path=$(awk -F '=' '$1=='$choose' {a=1} a==1&&$1=="preforder" {a=0;print $2;exit;} ' ${iniconf} )

	    find ${filepath}${path} -type f \( -name '*.jpg' -o -name '*.png' \) -print0 |
	        shuf -n1 -z | xargs -0 feh --bg-fill

    sleepTime=$(awk -F '=' '$1=='$choose' {a=1} a==1&&$1=="sleepTime" {a=0;print $2;exit;} ' ${iniconf} )

    sleep ${sleepTime}
done
