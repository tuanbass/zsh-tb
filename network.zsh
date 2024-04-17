# if ((!$ + commands[git])); then
# 	return
# fi

vpn-get-status(){
# check openvpn status 
#
    network=${1:-wlo1}
    ifconfig $network |grep "inet " >/dev/null

    if [[ $? -gt 0 ]]; then
        echo "interface $network is not activated"
        return 255 
    fi
    pgrep -a openvpn >/dev/null
    res=$?
    openvpn=0
    if [[ $res -eq 0 ]]; then # Found VPN process, consider that openvpn is activated
        openvpn=1
    else
        openvpn=0
    fi

    warp=0
    warp-cli status|grep "Disconnected" >/dev/null 

    if [[ $? -eq 0 ]]; then #  THere is message: "Disconnected", mean VPN is not connected
      
      warp=0
    else
      warp=1
    fi

    return $((openvpn+warp * 2))
}

vpn-status() {
  vpn-get-status
  vpn_status=$?
  case "$vpn_status" in
    1) echo "OpenVPN activated"
    ;;
    2) echo "Warp activated"
    ;;
    3) echo "Both activated"
    ;;
    *) 
    echo "None activated"
    ;;
  esac

}


vpn-aura() {
  vpn-get-status
  res=$? 

  if [[ $res -eq 2 || $res -eq 3 ]]; then
    echo "***************************"
    echo " Warning: Warp is activated, please disconnect it first"
    read -n 1 
    echo "\n\n\n"
    return
  fi
  cd $HOME/.ssh/aura/ && sudo openvpn aura-key.ovpn
}


function vpn-warp (){
    vpn-get-status
    res=$? 
    if [[ $res -eq 1 || $res -eq 3 ]]; then
      echo "***************************"
      echo " Warning: OpenVPN is activated, please disconnect it first"
      read -n 1 
      echo "\n\n\n"
      return
    fi

    if [[ $res -eq 2 || $res -eq 3 ]]; then # warp is activated
      notify-send "disconnect..."
      echo "disconnect..."
      warp-cli disconnect
    else
      echo "connect..."
      notify-send "connect..."
      warp-cli connect
    fi

}


mac_change_byod ()
{
    BYOD="38:fc:98:a9:cc:a0"
    NETWORK_IF="wlo1"
    sudo macchanger --mac=$BYOD $NETWORK_IF
}

bluetooth_restart ()
{
    rfkill block bluetooth
    rfkill unblock bluetooth
}


### redirect traffict between port with iptables
function redirect-port ()
{
    #usage redirect-port 80 8080
    from=$1
    to=$2
    iptables -t mangle -A PREROUTING -p tcp --dport $from -j MARK --set-mark 1
    iptables -t nat -A PREROUTING -p tcp --dport $from -j REDIRECT --to-port $to
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $to -m mark --mark 1 -j ACCEPT
}

disable_ipv6()
{
    sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
    sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1

}


function download(){
    axel -n 32 -a $*
}

function ping_gateway(){
    local default_gw=$(route -n|awk '/UG/{print $2}')
    ping $default_gw
}

function fix-dns(){
    # sudo cp /etc/resolv.conf /etc/resolv.conf.bak
    # sudo cp $DOTFILES/zsh/resolv.conf /etc/resolv.conf  
    REGEX='\(nameserver\)[[:blank:]]*[[:xdigit:]]*.[[:xdigit:]]*.[[:xdigit:]]*.[[:xdigit:]]*'
    REPLACE='\1 8.8.8.8'
    sudo sed  -i  "0,/${REGEX}/s//$REPLACE/" /etc/resolv.conf
}


telnet-ssl ()
{
    host=$1
    port=${2:-443}
    openssl s_client -connect $host:$port
    # possible use alternative: gnutls-cli www.somesite
}

function aws-profile(){
  profile=$(grep '\[.*\]' ~/.aws/credentials | sed 's/\[\(.*\)\]/\1/'|fzf)
  export AWS_PROFILE=$profile
}
