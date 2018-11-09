#!/bin/sh
#
# Set the correct file permissions for Magento 2

while true;
do
	chgrp 33 /var/www/html

	for D in $(ls /var/www/html); do
        chgrp -R 33 "${D}"

        find "${D}" -type d -exec chmod ug+rwx {} \; # Make folders traversable and read/write
		find "${D}" -type f -exec chmod ug+rw {} \;  # Make files read/write 
	done

	chmod 775 /var/www/html/warp
	chmod 775 /var/www/html/bin/magento

  sleep 1800 # 30 minutes
done
