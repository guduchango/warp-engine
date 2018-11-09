#!/bin/sh
#
# Set the correct file permissions for Magento 2

while true;
do
	for D in /var/www/html/*; do
	    if [ -d "${D}" ]; then
	        chgrp -R 33 "${D}"

	        find "${D}" -type d -exec chmod ug+rwx {} \; # Make folders traversable and read/write
			find "${D}" -type f -exec chmod ug+rw {} \;  # Make files read/write 
		elif [ -f "${D}" ]; then
			chmod ug+rw "${D}"
	    fi
	done

  sleep 1800 # 30 minutes
done
