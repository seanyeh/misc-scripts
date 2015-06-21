#!/bin/bash

# Enable PulseAudio to record audio and microphone simultaneously
# http://www.maartenbaert.be/simplescreenrecorder/recording-game-audio/
#
# After turning on, open PulseAudio Volume Control (pavucontrol) and set:
#   Playback tab: Set second null output
#   Recording tab: Set first null output

turn_on() {
    pactl load-module module-null-sink sink_name=duplex_out
    pactl load-module module-null-sink sink_name=game_out
    pactl load-module module-loopback source=game_out.monitor
    pactl load-module module-loopback source=game_out.monitor sink=duplex_out
    pactl load-module module-loopback sink=duplex_out
}

turn_off() {
    pactl unload-module module-loopback
    pactl unload-module module-null-sink
}

if [ "$1" = "on" ]; then
    turn_on
elif [ "$1" = "off" ]; then
    turn_off
else
    printf "Enable PulseAudio to record audio and microphone simultaneously.\n"
    printf "Usage:\n\t$0 on\n\t$0 off\n"
fi
