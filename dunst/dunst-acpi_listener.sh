#!/bin/bash

battery_check() {
    local battery_info=$(acpi -b 2>/dev/null)
    local battery_status=$(echo "$battery_info" | grep -Po 'Discharging|Charging|Full' | head -1)
    local battery_level=$(echo "$battery_info" | grep -Po '[0-9]+(?=%)' | head -1)

    case "$battery_status" in
        "Discharging")
            [[ $battery_level -lt 20 ]] && \
                notify-send \
                    -u critical \
                    -r 9994 \
                    "Batterie info" \
                    "Batterie faible - Niveau : $battery_level%" 
            ;;
        "Charging")
            [[ $battery_level -gt 95 ]] && \
                notify-send \
                    -u normal \
                    -r 9994 \
                    "Batterie info" \
                    "Batterie presque pleine - Niveau : $battery_level%"
            ;;
    esac
}

ac_event() {
    case "$1" in
        *0x00000080)
            notify-send \
                -u low \
                -r 9993 \
                "Alimentation" \
                "Branchement secteur détecté"
            ;;
        *0x00000001)
            notify-send \
                -u low \
                -r 9993 \
                "Alimentation" \
                "Débranchement secteur détecté"
            battery_check
            ;;
    esac
}

brightness_event() {
    local current_level max_level percentage
    
    sleep 0.03
    
    case "$1" in
        *brightnessup*|*brightnessdown*)
            current_level=$(brightnessctl get)
            max_level=$(brightnessctl max)
            percentage=$(( (current_level * 100) / max_level ))
            notify-send \
                -u low \
                -h "int:value:$percentage" \
                -r 9991 \
                "Luminosité" \
                "Niveau : $percentage%"
            ;;
    esac
}

volume_event() {
    local current_level
    
    sleep 0.03
    
    case "$1" in
        *volumeup*|*volumedown*)
            current_level=$(ponymix get-volume)
            notify-send \
                -u low \
                -h "int:value:$current_level" \
                -r 9992 \
                "Volume" \
                "Niveau : $current_level%"
            ;;
    esac
}

acpi_listen | while read -r line; do
    case "$line" in
        ac_adapter*)
            ac_event "$line"
            ;;
        battery*)
            battery_check
            ;;
        video/brightness*)
            brightness_event "$line" &
            ;;
        button/volume*)
            volume_event "$line" &
            ;;
    esac
done