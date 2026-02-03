#!/bin/bash

# Check for HDMI-A-1 monitor
if wlr-randr | grep -q "HDMI-A-1"; then
    # Turn off eDP-1
    wlr-randr --output eDP-1 --off
fi
