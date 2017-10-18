#/bin/bash
function get-survey() {
        echo ""
        echo -e $y"##################### CHECK SYSLOG  ####################"$d
        cat /etc/*syslog*
        echo ""
        echo -e $y"##################### SHOW KERNEL MODS  ####################"$d
        lsmod

        echo ""
        echo -e $y"##################### DISTRO INFO  ####################"$d
        cat /etc/*release*

        echo ""
        echo -e $y"##################### CPU INFO  ####################"$d
        cat /proc/cpuinfo

        echo ""
        echo -e $y"##################### SERVICES INFO  ####################"$d
        systemctl status --no-pager || service --status-all

        echo ""
        echo -e $y"##################### CRON INFO  ####################"$d
        for user in $(cat /etc/passwd | egrep '/bin/sh|/bin/bash' | cut -d \: -f1); do crontab -u $user -l; done
        cat /etc/crontab
        ls -la /etc/cron.*

        echo ""
        echo -e $y"##################### ARP & ROUTE  ####################"$d
        ip nei || arp -vn
        route -n

        echo ""
        echo -e $y"##################### RC.LOCAL  ####################"$d
        cat /etc/rc.local

        echo ""
        echo -e $y"##################### MOUNT  ####################"$d
        mount

        echo ""
        echo -e $y"##################### IPTABLES  ####################"$d
        if [[ $(lsmod | grep -i table) ]]; then eval "iptables -L"; else echo "No IPTables"; fi
        echo ""

        echo -e $y"##################### LOOKING FOR SSH KEYS  ####################"$d
        ls -latr /root/.ssh
        ls -latr /home/*/.ssh
        echo ""
        echo ""
        echo -e $r"##################### COPY ALL SURVEY OUTPUT!!!  ####################"$d
        echo ""
        echo ""
        return 0
}

get-survey
