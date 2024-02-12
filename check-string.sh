#!/bin/bash

#lead-in segment validation
check_lead_in() {
    local lead_in=$1

    if [[ $lead_in != "90" ]]; then
        echo "Invalid lead-in: Must be 90."
        return 1
    fi
}

#version segment validation
check_version() {
    local version=$1

    if [[ $version == "00" ]]; then
        echo "Version: S2-only device"
    elif [[ $version == "01" ]]; then
        echo "Version: SmartStart enabled device"
    else
        echo "Invalid version: Must be 00 for S2-only devices or 01 for SmartStart enabled devices."
        return 1
    fi
}

# print requested keys - TODO-map the keys
print_requested_keys() {
    local requested_keys=$1

    echo "Requested Keys: $requested_keys"
}

#print  DSK 5-digit
print_dsk() {
    local dsk=$1

    echo "DSK Key: $dsk"
}

main() {
    if [[ $# -eq 1 ]]; then
        lead_in="${1:0:2}"
        version="${1:2:2}"
        checksum="${1:4:5}"
        requested_keys="${1:9:3}"
        dsk="${1:12:5}"

        check_lead_in "$lead_in" || return 1
        check_version "$version" || return 1

        print_requested_keys "$requested_keys"
        print_dsk "$dsk"
    else
        echo "Usage: $0 <DSK>"
        exit 1
    fi
}


main "$@"
