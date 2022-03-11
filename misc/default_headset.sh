#!/usr/bin/env bash
pactl unload-module module-echo-cancel
pactl load-module module-echo-cancel source_master=alsa_input.usb-SteelSeries_SteelSeries_Arctis_7-00.mono-chat aec_method=webrtc source_name=echocancel sink_name=echocancel1
pacmd set-default-source echocancel
#pacmd set-default-sink echocancel1
