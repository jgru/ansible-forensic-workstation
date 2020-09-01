#!/bin/bash
echo $1
tail -n +2 $1/rip.pl > /usr/local/share/regripper/rip
perl -pi -e 'tr[\r][]d' /usr/local/share/regripper/rip
sed -i "1i #\!$(which perl)" /usr/local/share/regripper/rip
sed -i 's/\#my\ \$plugindir/\my\ \$plugindir/g' /usr/local/share/regripper/rip
sed -i 's/\#push/push/' /usr/local/share/regripper/rip
sed -i 's/\"plugins\/\"\;/\"\/usr\/local\/share\/regripper\/plugins\/\"\;/' /usr/local/share/regripper/rip
sed -i 's/(\"plugins\")\;/(\"\/usr\/local\/share\/regripper\/plugins\")\;/' /usr/local/share/regripper/rip
