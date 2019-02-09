#! /bin/bash
#
# I3 bar with https://github.com/LemonBoy/bar

. $(dirname $0)/i3_lemonbar_config

if [ $(pgrep -cx $(basename $0)) -gt 1 ] ; then
    printf "%s\n" "The status bar is already running." >&2
    exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "${panel_fifo}" ] && rm "${panel_fifo}"
mkfifo "${panel_fifo}"

# Window title, "WIN"
xprop -spy -root _NET_ACTIVE_WINDOW | sed -un 's/.*\(0x.*\)/WIN\1/p' > "${panel_fifo}" &

# Conky, "SYS"
conky -c $(dirname $0)/i3_lemonbar_conky > "${panel_fifo}" &

cat "${panel_fifo}" | $(dirname $0)/i3_lemonbar_parser.sh \
  | lemonbar -p -f "${font}" -g "${geometry}" -B "${color_black}" -F "${color_white}" | bash &
  
wait
