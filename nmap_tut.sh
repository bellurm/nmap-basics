#!/bin/bash

function explains_and_menu() {
    specified_port="Select to scan specific ports (-p <value>)"
    tcp_syn_scan="Select for relatively hidden and strong scanning (-sS)."
    udp_scan="Select to scan UDP ports (-sU)."
    ping_skip="Skip checking if the target systems are alive using ICMP (-Pn)."
    fin_scan="Select for FIN scan, a stealthy scanning technique that sends FIN packets to check for open ports (-sF)."
    IPs_in_a_file="Select to scanning IP addresses in a file (-iL /file/to/path/)."
    scan_all_ports="Select to scan all of the ports (1-65535) (-p-)."
    most_popular_ports="Select to scan most popular 100 ports (Fast) (-F)."
    choice_most_popular="How many most popular ports do you want to scan? (--top-ports)."
    if_up="Select to detect your target machine is up/alive without port scanning (-sn)."
    tcp_syn_ping="Select to send pings with SYN packs (-PS)."
    tcp_ack_ping="Select to send pings with ACK packs (-PA)."
    udp_ping="Select to send pings with UDP packs (-PU)."
    arp_ping="Select to send ARP pings to detect who is on your network (-PR)."
    version_detection="Select to detect versions of services (-sV)."
    version_detection_support="Select to support Version Detection operation (-sV --version-intensity <value>)."
    version_detection_agressive="Select to detect versions aggressively without entering a value (-sV --version-all)."
    os_detection="Select to detect target's Operating System. For this section, the target must have 1 open port and 1 closed port.\n If it doesn't, choose the 19th option (-O)."
    osscan_limit="This option returns a result without performing the OS scan if the destination does not have 1 open port and 1 closed port.\n If there is, it returns the result of the OS scan (-O --osscan-limit)."
    max_os_tries="For OS detection, run as many trials as you want (-O -max-os-tries <value>)."
    os_detection_agressive="Select to detect OS aggressively (-O --osscan-guess)."
    general_aggressive_scanning="Select to gather informations with details and agressively; detect OS, version, traceroute etc. (-A)."
    t5_scanning="Select to scanning with short time (insane-fast) (-T5)."
    t4_scanning="Select to scanning agressively (more time than -T5) (-T4)."
    t3_scanning="Select to scanning normal (nmap's default) (more time than -T4) (-T3)."
    t2_scanning="Select to scanning polite (more time than -T3) (-T2)."
    t1_scanning="Select to scanning sneaky (more time than -T2) (-T1)."
    t0_scanning="Select to scanning paranoid (more time than -T1) (-T0)."
    default_script="Select to scanning with default scripts. It's safe and secure (--script=default or -sC)."
    vuln_script="Select to get vulnerabilities on the target (--script vuln)."
    exploit_script="Select to get expolits on the target (--script exploit)."
    auth_script="Select to get authentication informations on the target (--script auth)."
    choose_proto_scripts="Select to scan with scripts of protocols; http, ssh, dns etc. (<proto>)."
    avoid_firewall="Select to avoid the firewall with change the size of TCP headers (-f)."
    spoofing_ip="Select to spoofing (change) your IP address for the target's system (-D RND:<value>)."
    spoofing_mac="Select to spoofing (change) your MAC address for the target's system (--spoof-mac 0)."
    verbose_output="Select to verbose the output (-v)."

    menu="
\e[1;31m[WARN] Type 'exit' to start the process and exit from the menu.\e[0m

'done'. End the program

 1. $specified_port
 2. $tcp_syn_scan
 3. $udp_scan
 4. $ping_skip
 5. $fin_scan
 6. $IPs_in_a_file
 7. $scan_all_ports
 8. $most_popular_ports
 9. $choice_most_popular
10. $if_up
11. $tcp_syn_ping
12. $tcp_ack_ping
13. $udp_ping
14. $arp_ping
15. $version_detection
16. $version_detection_support
17. $version_detection_agressive
18. $os_detection
19. $osscan_limit
20. $max_os_tries
21. $os_detection_agressive
22. $general_aggressive_scanning
23. $t5_scanning
24. $t4_scanning
25. $t3_scanning
26. $t2_scanning
27. $t1_scanning
28. $t0_scanning
29. $default_script
30. $vuln_script
31. $exploit_script
32. $auth_script
33. $choose_proto_scripts
34. $avoid_firewall
35. $spoofing_ip
36. $spoofing_mac
37. $verbose_output
"

    echo -e "$menu"
}

function main() {
    operations=()

    while true; do
        echo ""
        read -e -p $'\e[33m[???] Please, select from the menu and hit enter (\'exit\' to start scan, \'done\' to quit): \e[0m' select

        if [[ "$select" == "1" ]]; then
            read -e -p $'\e[33m[???] Which ports do you want to scan? (e.g. 22,23,25 or define a range e.g. 21-54) > \e[0m' specified_ports
            operations+=("-p" "$specified_ports")
            echo -e "\e[32m[INFO] $specified_ports is/are added with the '-p' parameter.\e[0m"

        elif [[ "$select" == "2" ]]; then
            operations+=("-sS")
            echo -e "\e[32m[INFO] The '-sS' parameter has been added for the TCP SYN SCAN.\e[0m"

        elif [[ "$select" == "3" ]]; then
            operations+=("-sU")
            echo -e "\e[32m[INFO] The '-sU' parameter has been added for the UDP SCAN.\e[0m"

        elif [[ "$select" == "4" ]]; then
            operations+=("-Pn")
            echo -e "\e[32m[INFO] The '-Pn' parameter has been added for skipping ICMP checking.\e[0m"

        elif [[ "$select" == "5" ]]; then
            operations+=("-sF")
            echo -e "\e[32m[INFO] The '-sF' parameter has been added to send FIN packets.\e[0m"

        elif [[ "$select" == "6" ]]; then
            read -e -p $'\e[33m[???] Please, write the path of the file containing the IP addresses: \e[0m' path
            if [[ -f "$path" ]]; then
                operations+=("-iL" "$path")
                echo -e "\e[32m[INFO] The '-iL' parameter has been added with given file path ($path).\e[0m"
                echo -e "\e[1;31m[INFO] This command in progress: nmap ${operations[*]} \e[0m\n"
                nmap "${operations[@]}"
                exit 0
            else
                echo -e "\e[31m[WARN] Invalid path or file name. Please try again.\e[0m"
            fi

        elif [[ "$select" == "7" ]]; then
            operations+=("-p-")
            echo -e "\e[32m[INFO] The '-p-' parameter has been added. It will take time. Please, be patient.\e[0m"

        elif [[ "$select" == "8" ]]; then
            operations+=("-F")
            echo -e "\e[32m[INFO] The '-F' parameter has been added for scanning the most popular 100 ports.\e[0m"

        elif [[ "$select" == "9" ]]; then
            read -e -p $'\e[33m[???] How many ports to scan? > \e[0m' most_popular_choice
            operations+=("--top-ports" "$most_popular_choice")

        elif [[ "$select" == "10" ]]; then
            operations+=("-sn")
            echo -e "\e[32m[INFO] The '-sn' parameter has been added to detect if your target is up/alive.\e[0m"

        elif [[ "$select" == "11" ]]; then
            read -e -p $'\e[33m[???] Give us a port number for the SYN ping:  \e[0m' syn_port
            operations+=("-PS${syn_port}")
            echo -e "\e[32m[INFO] The '-PS' parameter along with the specified port has been added to the SYN ping operation.\e[0m"

        elif [[ "$select" == "12" ]]; then
            operations+=("-PA")
            echo -e "\e[32m[INFO] The '-PA' parameter has been added to the ACK ping operation.\e[0m"

        elif [[ "$select" == "13" ]]; then
            operations+=("-PU")
            echo -e "\e[32m[INFO] The '-PU' parameter has been added to the UDP ping operation.\e[0m"

        elif [[ "$select" == "14" ]]; then
            operations+=("-PR")
            echo -e "\e[32m[INFO] The '-PR' parameter has been added to the ARP ping operation.\e[0m"

        elif [[ "$select" == "15" ]]; then
            operations+=("-sV")
            echo -e "\e[32m[INFO] The '-sV' parameter has been added to the version detection operation.\e[0m"

        elif [[ "$select" == "16" ]]; then
            read -e -p $'\e[36m[???] Give us a number to support version detection (0-9): \e[0m' supporting_value
            operations+=("-sV" "--version-intensity" "$supporting_value")
            echo -e "\e[32m[INFO] The '-sV --version-intensity' parameters have been added to support the '-sV' option.\e[0m"

        elif [[ "$select" == "17" ]]; then
            operations+=("-sV" "--version-all")
            echo -e "\e[32m[INFO] The '-sV --version-all' parameters have been added for aggressive version scan.\e[0m"

        elif [[ "$select" == "18" ]]; then
            operations+=("-O")
            echo -e "\e[32m[INFO] The '-O' parameter has been added to detect OS.\e[0m"

        elif [[ "$select" == "19" ]]; then
            operations+=("-O" "--osscan-limit")
            echo -e "\e[32m[INFO] The '-O --osscan-limit' parameters have been added to detect OS.\e[0m"

        elif [[ "$select" == "20" ]]; then
            read -e -p $'\e[33m[???] How many times should OS detection be tried? > \e[0m' tries
            operations+=("-O" "--max-os-tries" "$tries")
            echo -e "\e[32m[INFO] The '-O --max-os-tries' parameters have been added with value ($tries).\e[0m"

        elif [[ "$select" == "21" ]]; then
            operations+=("-O" "--osscan-guess")
            echo -e "\e[32m[INFO] The '-O --osscan-guess' parameters have been added to detect OS aggressively.\e[0m"

        elif [[ "$select" == "22" ]]; then
            operations+=("-A")
            echo -e "\e[32m[INFO] The '-A' parameter has been added to gather information aggressively.\e[0m"

        elif [[ "$select" == "23" ]]; then
            operations+=("-T5")
            echo -e "\e[32m[INFO] The '-T5' parameter has been added to insane-fast scanning.\e[0m"

        elif [[ "$select" == "24" ]]; then
            operations+=("-T4")
            echo -e "\e[32m[INFO] The '-T4' parameter has been added to aggressive scanning.\e[0m"

        elif [[ "$select" == "25" ]]; then
            operations+=("-T3")
            echo -e "\e[32m[INFO] The '-T3' parameter has been added to normal (default) scanning.\e[0m"

        elif [[ "$select" == "26" ]]; then
            operations+=("-T2")
            echo -e "\e[32m[INFO] The '-T2' parameter has been added to polite scanning.\e[0m"

        elif [[ "$select" == "27" ]]; then
            operations+=("-T1")
            echo -e "\e[32m[INFO] The '-T1' parameter has been added to sneaky scanning.\e[0m"

        elif [[ "$select" == "28" ]]; then
            operations+=("-T0")
            echo -e "\e[32m[INFO] The '-T0' parameter has been added to paranoid scanning.\e[0m"

        elif [[ "$select" == "29" ]]; then
            operations+=("--script=default")
            echo -e "\e[32m[INFO] The '--script=default' parameter has been added for safe default scripts.\e[0m"

        elif [[ "$select" == "30" ]]; then
            operations+=("--script" "vuln")
            echo -e "\e[32m[INFO] The '--script vuln' parameter has been added to get vulnerabilities.\e[0m"

        elif [[ "$select" == "31" ]]; then
            operations+=("--script" "exploit")
            echo -e "\e[32m[INFO] The '--script exploit' parameter has been added to get exploits.\e[0m"

        elif [[ "$select" == "32" ]]; then
            operations+=("--script" "auth")
            echo -e "\e[32m[INFO] The '--script auth' parameter has been added to get authentication information.\e[0m"

        elif [[ "$select" == "33" ]]; then
            ls /usr/share/nmap/scripts
            read -e -p $'\e[33m\n[???] You can see all of the scripts above. To try all software related to a protocol, just type the protocol name (e.g. http, ssh): \e[0m' choose_proto
            operations+=("--script" "${choose_proto}-*")
            echo -e "\e[32m[INFO] The '--script ${choose_proto}-*' parameter has been added to use all $choose_proto scripts.\e[0m"

        elif [[ "$select" == "34" ]]; then
            operations+=("-f")
            echo -e "\e[32m[INFO] The '-f' parameter has been added to try to avoid the firewall.\e[0m"

        elif [[ "$select" == "35" ]]; then
            read -e -p $'\e[33m\n[???] How many fake IPs to create? > \e[0m' choose_fake_ip
            operations+=("-D" "RND:$choose_fake_ip")
            echo -e "\e[32m[INFO] The '-D RND:$choose_fake_ip' parameters have been added for IP spoofing.\e[0m"

        elif [[ "$select" == "36" ]]; then
            operations+=("--spoof-mac" "0")
            echo -e "\e[32m[INFO] The '--spoof-mac 0' parameters have been added for MAC spoofing.\e[0m"

        elif [[ "$select" == "37" ]]; then
            operations+=("-v")
            echo -e "\e[32m[INFO] The '-v' parameter has been added for verbose output.\e[0m"

        elif [[ "$select" == "exit" ]]; then
            read -e -p $'\e[33m[???] Give us one or more IP addresses, Domain Names or IP range (e.g. 192.168.1.0/24) to scan: \e[0m' targets
            echo -e "\e[1;31m[INFO] This command in progress: nmap ${operations[*]} $targets \e[0m\n"

            for item in "${operations[@]}"; do
                if [[ "$item" == "--script" ]] || [[ "$item" == "--script=default" ]]; then
                    apt-cache policy nmap
                fi
            done

            nmap "${operations[@]}" $targets
            operations=()

        elif [[ "$select" == "done" ]]; then
            echo -e "\e[32m[SUCCESS] Exited by user.\e[0m"
            exit 0
        else
            echo -e "\e[31m[WARN] Invalid choice. Please try again.\e[0m"
        fi
    done
}

if [[ "$(id -u)" -ne 0 ]]; then
    echo "[WARN] You have to be root."
else
    explains_and_menu
    main
fi
