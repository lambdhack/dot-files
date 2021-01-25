#!/bin/bash

# config
. $(dirname $0)/i3_lemonbar_config

# parser
while read -r line ; do
  case $line in
    SYS*)
      # conky=, 0 = wday, 1 = mday, 2 = month, 3 = time, 4 = cpu, 5 = mem, 6 = disk /, 7 = disk /home, 8-9 = up/down wlan, 10-11 = up/down eth, 12-13=speed
      sys_arr=(${line#???})
      # date
      if [ ${res_w} -gt 1024 ]; then
        date="${sys_arr[0]} ${sys_arr[1]} ${sys_arr[2]}"
      else
        date="${sys_arr[1]} ${sys_arr[2]}"
      fi
      date="%{F${color_black}}${sep_left}%{F${color_white} B${color_black}} ${icon_cal} ${date}"
      # time
      time="%{F${color_red}}${sep_left}%{F${color_black} B${color_red}} ${icon_clock} ${sys_arr[3]} "
      # cpu
      cpu="%{F${color_red}}${sep_left}%{F${color_black} B${color_red}} ${icon_cpu} ${sys_arr[4]}%"
      # mem
      mem="%{F${color_black}}${sep_left}%{F${color_white} B${color_black}} ${icon_mem} ${sys_arr[5]}"
      #battery percentage
      perc="$(acpi -b | cut -d ' ' -f 4 | cut -d ',' -f 1)"
      if [ $(("${perc::-1}>75" | bc)) = 1 ]; then
          icon_bat=${icon_bat_100}
      elif [ $(("${perc::-1}>50" | bc)) = 1 ]; then
          icon_bat=${icon_bat_75}
      elif [ $(("${perc::-1}>25" | bc)) = 1 ]; then
          icon_bat=${icon_bat_25}
      elif [ $(("${perc::-1}>10" | bc)) = 1 ]; then
          icon_bat=${icon_bat_10}
      else
          icon_bat=${icon_bat_0}
      fi
      bat="%{F${color_black}}${sep_left}%{F${color_white} B${color_black}} ${icon_bat} ${perc} "
      # network
      # wlan
      if [ "${sys_arr[9]}" != "down" ]; then
        wland_v=${sys_arr[9]}K; wlanu_v=${sys_arr[10]}K;
        netd="%{F${color_red}}${sep_left}%{F${color_black} B${color_red}} ${icon_dl} ${wland_v}"
        netu="%{F${color_black}}${sep_left}%{F${color_white} B${color_black}} ${icon_ul} ${wlanu_v}"
      # eth
      elif [ "${sys_arr[11]}" != "down" ]; then
        ethd_v=${sys_arr[11]}K; ethu_v=${sys_arr[12]}K;
        netd="%{F${color_red}}${sep_left}%{F${color_black} B${color_red}} ${icon_dl} ${ethd_v}"
        netu="%{F${color_black}}${sep_left}%{F${color_white} B${color_black}} ${icon_ul} ${ethu_v}"
      else
        netd_v="×"; netu_v="×";
        net_cback=${color_sec_b2}; net_cicon=${color_sec_b3}; net_cfore=${color_sec_b3};
        netd="%{F${color_red}}${sep_left}%{F${color_black} B${color_red}}  ${icon_dl} ${netd_v}"
        netu="%{F${color_black}}${sep_left}%{F${color_white} B${color_black}} ${icon_ul} ${netu_v}"
      fi
      # Volume
      vol="$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master))"
      volume="%{F${color_red}}${sep_left}%{F${color_black} B${color_red}} ${icon_vol} ${vol}"
      ;;
    WIN*)
      # window title
      title=$(xprop -id ${line:3} | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
      spaces="                                                                                                                                                                     " # fast way to fix a bug
      title="%{A:terminator --command='neofetch;cat TODO;zsh' --geometry=800x500:}%{F${color_black} B${color_red}}${icon_prog}%{F${color_red} B${color_black}}%{A}${sep_right} ${title}${spaces}"
      ;;
  esac

  # And finally, output
  echo -e "%{l}${title} %{r}${cpu}${stab}${mem}${stab}${netd}${stab}${netu}${stab}${location}${stab}${ethereum}${stab}${bat}${stab}${volume}${stab}%{A:galendae:}${date}%{A}${stab}${time}"
done
