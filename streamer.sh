#!/bin/bash
# This program is for start/stop mjpg-streamer
# scripted by RickyCga, 07/18/2016

frame_second=20
v0port=2500
v1port=2501
videoResolution='640*480'

case $1 in
        start)
                if ps -a | grep mjpg_streamer >/dev/null 2>&1; then
                        printf "streamer already opened.\n"
                        if netstat -atn | grep ${v0port} >/dev/null 2>&1; then
                            printf "streamer video0 opened at port ${v0port}\n"
                        else
                            printf "streamer video0 error.\n"
                        fi
                        if netstat -atn | grep ${v1port} >/dev/null 2>&1; then
                            printf "streamer video1 opened at port ${v1port}\n"
                        else
                            printf "streamer video1 error.\n"
                        fi
                else
                        cd /home/pi/mjpg-streamer/mjpg-streamer
                        ./mjpg_streamer -i "./input_uvc.so -d /dev/video0 -n -y -f ${frame_second} -r ${videoResolution}" -o "./output_http.so -n -w ./www -p ${v0port} -c username:password" > /dev/null 2>&1 &
                        ./mjpg_streamer -i "./input_uvc.so -d /dev/video1 -n -y -f ${frame_second} -r ${videoResolution}" -o "./output_http.so -n -w ./www -p ${v1port} -c username:password" > /dev/null 2>&1 &
                        sleep 0.15
                        if netstat -atn | grep ${v0port} >/dev/null 2>&1; then
                            printf "streamer video0 open at port ${v0port}\n"
                        else
                            printf "streamer video0 error.\n"
                        fi
                        if netstat -atn | grep ${v1port} >/dev/null 2>&1; then
                            printf "streamer video1 open at port ${v1port}\n"
                        else
                            printf "streamer video1 error.\n"
                        fi
                fi
                ;;
        stop)
                printf "streamer "
                if pkill -x mjpg_streamer; then
                    printf "stopped\n"
                else
                    printf "stop error\n"
                fi
                ;;
        restart)
                if ps -a | grep mjpg_streamer >/dev/null 2>&1; then
                        $0 stop
                else
                        printf "streamer not open\n"
                        $0 start
                        exit 0
                fi
                $0 start
                ;;
        status)
                if netstat -atn | grep ${v0port} >/dev/null 2>&1; then
                        printf "streamer video0 open at port ${v0port}\n"
                else
                        printf "streamer video0 not open\n"
                fi
                if netstat -atn | grep ${v1port} >/dev/null 2>&1; then
                        printf "streamer video1 open at port ${v1port}\n"
                else
                        printf "streamer video1 not open\n"
                fi
                ;;
        help)
                printf "\n=================================\n"
                printf "$0 start: start streaming.\n"
                printf "$0 stop: stop streaming.\n"
                printf "$0 status: show streaming status.\n"
                printf "$0 restart: restart streaming.\n"
                printf "$0 help: show this page."
                printf "\n=================================\n\n"
                ;;
        *)
                printf "\nUsage: $0 help to know how to use.\n\n" >&2
                ;;
esac
