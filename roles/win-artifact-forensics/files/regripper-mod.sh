#!/bin/bash
echo $1
tail -n +2 $1/rip.pl > /usr/share/regripper/rip.pl
perl -pi -e 'tr[\r][]d' /usr/share/regripper/rip.pl
sed -i "1i #\!$(which perl)" /usr/share/regripper/rip.pl
sed -i 's/\#my\ \$plugindir/\my\ \$plugindir/g' /usr/share/regripper/rip.pl
sed -i 's/\#push/push/' /usr/share/regripper/rip.pl
sed -i 's/\"plugins\/\"\;/\"\/usr\/share\/regripper\/plugins\/\"\;/' /usr/share/regripper/rip.pl
sed -i 's/(\"plugins\")\;/(\"\/usr\/share\/regripper\/plugins\")\;/' /usr/share/regripper/rip.pl
