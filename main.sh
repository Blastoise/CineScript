#!/bin/bash

function select_option {

    # little helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()  { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to()        { printf "$ESC[$1;${2:-1}H"; }
    print_option()     { printf "   $1 "; }
    print_selected()   { printf "  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()   { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()        { read -s -n1 key 2>/dev/null >&2
                         if [[ $key = "" ]]; then
                            echo enter;
                         elif [[ $key = "$ESC" ]]; then
                            read -s -n2 key 2>/dev/null >&2
                            if [[ $key = "[A" ]]; then
                                echo up;
                            elif [[ $key = "[B" ]]; then 
                                echo down;
                            else
                                echo random;
                            fi
                         else
                            echo random;
                         fi
                        } 
                         

    # initially print empty new lines (scroll down if at bottom of screen)
    for opt; do printf "\n"; done

    # determine current screen position for overwriting the options
    local lastrow=`get_cursor_row`
    local startrow=$(($lastrow - $#))

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local selected=0
    while true; do
        # print options by overwriting the last lines
        local idx=0
        for opt; do
            cursor_to $(($startrow + $idx))
            if [ $idx -eq $selected ]; then
                print_selected "$opt"
            else
                print_option "$opt"
            fi
            ((idx++))
        done

        # user key control
        case `key_input` in
            enter) break;;
            up)    ((selected--));
                   if [ $selected -lt 0 ]; then selected=$(($# - 1)); fi;;
            down)  ((selected++));
                   if [ $selected -ge $# ]; then selected=0; fi;;
            *) ;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    return $selected
}

function yt_downloader() {
    read -r -p "Enter the url of the video: " url
    echo "$url"
    youtube-dl "$url"
}

magnet=""

function get_data() {
    local name
    read -r -p "Enter the name of the Movie/TV Series: " name
    local query=$(echo "$name" | tr ' ' '+')
    echo "$query"

    local content_name=()
    local link=()
    local magnets=()

    curl -s "https://pirate-proxy.cc/newapi/q.php?q=${query}&cat=$2" | jq '.[] | {name, info_hash}' | grep "^\s*\"name\|^\s*\"info_hash" | sed -nE 's/"name":\s*"(.*)",|"info_hash":\s*"(.*)"/\1\2/p' | sed -n "s/^\s*//p" | head -20 > pirate.txt

    local i=0
    while IFS= read -r line; do
        if (($i%2==0))
        then
            content_name+=("$line")
        else
            magnets+=("magnet:?xt=urn:btih:${line}")
            link+=("-1")
        fi
        ((i+=1))
    done < pirate.txt
    
    curl -s "https://1337x.wtf/category-search/${query}/${1}/1/" | grep -Eo "<a href=\"/torrent/[0-9]{1,}/[a-zA-Z0-9?%-]*/\">.+</a>" | sed -nE 's/<a href="\/(torrent\/[0-9]{1,}\/[a-zA-Z0-9?%-]*\/)">(.+)<\/a>/\2\n\1/p' | sed -E "s/\s*$//;s/^\s*//" | head -20 > pirate.txt

    i=0
    while IFS= read -r line; do
        if (($i%2==0))
        then
            content_name+=("$line")
        else
            link+=("https://1337x.wtf/${line}")
        fi
        ((i+=1))
    done < pirate.txt

    select_option "${content_name[@]}"
    local content_choice=$?
    
    if [[ "${link[${content_choice}]}" == "-1" ]]
    then
        magnet="${magnets[${content_choice}]}"
    else
        magnet=$(curl -s "${link[${content_choice}]}" | grep -o "magnet:?xt=urn:btih:[a-zA-Z0-9]*" | head -1)
    fi
}


function download_content() {
    echo "$magnet"
}

function stream_content() {
    echo "$magnet"
}

echo "Select one option using up/down keys and enter to confirm:"
echo


options=('Download Youtube Video' "Download Movie" "Stream Movie" "Download TV Series" "Stream TV Series" "Download Anime" "Exit")

select_option "${options[@]}"
choice=$?

dialog="You selected"

case $choice in
    "0")
    echo "${dialog}: ${options[0]}"
    yt_downloader
    ;;
    "1")
    echo "${dialog}: ${options[1]}"
    get_data Movies 207
    download_content
    ;;
    "2")
    echo "${dialog}: ${options[2]}"
    get_data Movies 207
    stream_content
    ;;
    "3")
    echo "${dialog}: ${options[3]}"
    get_data TV 208
    download_content
    ;;
    "4")
    echo "${dialog}: ${option[4]}"
    get_data TV 208
    stream_content
    ;;
    *)
    echo "Something went wrong"
    ;;
esac


