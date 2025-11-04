#!/bin/bash

icons_path=""

battery_check() {
    local battery_info=$(acpi -b 2>/dev/null)
    local battery_status=$(echo "$battery_info" | grep -Po 'Discharging|Charging|Full' | head -1)
    local battery_level=$(echo "$battery_info" | grep -Po '[0-9]+(?=%)' | head -1)

    case "$battery_status" in
        "Discharging")
            [[ $battery_level -lt 20 ]] && \
                notify-send \
                    -u critical \
                    "Batterie info" \
                    "Batterie faible - Niveau : $battery_level%" 
            ;;
        "Charging")
            [[ $battery_level -gt 95 ]] && \
                notify-send \
                    -u normal \
                    "Batterie info" \
                    "Batterie presque pleine - Niveau : $battery_level%"
            ;;
    esac
}

ac_event() {
    case "$1" in
        *0x00000000)
            notify-send \
                -u low \
                "Alimentation" \
                "Branchement secteur détecté"
            ;;
        *0x00000001)
            notify-send \
                -u low \
                "Alimentation" \
                "Débranchement secteur détecté"

            battery_check
            ;;
    esac
}

brightness_event() {
    local current_level=$(brightnessctl get)
    local max_level=$(brightnessctl max)
    local percentage=$(( (current_level * 100) / max_level ))
    
    case "$1" in
        *brightnessup*)
            notify-send \
                -u low \
                -h int:value:"$percentage" \
                -r 9991 \
                "Luminosité" \
                "Augmentée - $percentage%"
            ;;
        *brightnessdown*)
            notify-send \
                -u low \
                -h int:value:"$percentage" \
                -r 9991 \
                "Luminosité" \
                "Diminuée - $percentage%"
            ;;
    esac
}

volume_event() {
    local current_level=$(ponymix get-volume)
    case "$1" in
        *volumeup*)
            notify-send \
                -u low \
                -h int:value:"$current_level" \
                -r 9992 \
                "Volume" \
                "Augmenté - $current_level%"
            ;;
        *volumedown*)
            notify-send \
                -u low \
                -h int:value:"$current_level" \
                -r 9992 \
                "Volume" \
                "Diminué - $current_level%"
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
        button/brightness*)
            brightness_event "$line"
            ;;
        button/volume*)
            volume_event "$line"
            ;;
    esac
done