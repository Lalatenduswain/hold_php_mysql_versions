# Automatically Hold PHP and MySQL Versions on Ubuntu

## Overview
This repository contains a bash script to dynamically detect the currently installed versions of PHP and MySQL on an Ubuntu system and prevent them from being automatically updated during system updates. The script leverages `apt-mark hold` to ensure stability for specific applications.

## Repository Details
- **Author:** Lalatendu Swain  
- **GitHub Repository:** [https://github.com/Lalatenduswain/hold_php_mysql_versions](https://github.com/Lalatenduswain/hold_php_mysql_versions)

## Features
- Dynamically detects the installed versions of PHP and MySQL.
- Prevents unintended updates by marking packages on hold.
- Works with major and minor version formats.
- Ensures system updates do not disrupt critical applications.

## Prerequisites
Before running the script, ensure the following requirements are met:

1. **Operating System:** Ubuntu (tested on versions 20.04 and 22.04).
2. **Installed Packages:**
   - PHP and MySQL must already be installed.
   - Required tools: `apt`, `bash`, `grep`, and `awk` (default in most Ubuntu installations).
3. **Permissions:**
   - The script requires `sudo` privileges to execute commands like `apt-mark hold`.

To check if sudo is configured, run:
```bash
sudo -v
```

## Installation
### Clone the Repository
To use this script, clone the repository to your local machine:
```bash
git clone https://github.com/Lalatenduswain/hold_php_mysql_versions.git
cd hold_php_mysql_versions
```

## Script Details
### Script Name
The script is named `hold_php_mysql_versions.sh`.

### Explanation of the Script
The script performs the following actions:
1. **Detect Installed PHP Version:**
   It extracts the major and minor version of the installed PHP using `php -v`.
2. **Hold PHP Packages:**
   Based on the detected version, it dynamically identifies and holds PHP-related packages such as `php-cli`, `php-fpm`, and `php-opcache`.
3. **Detect Installed MySQL Version:**
   It fetches the major and minor version of MySQL using `mysql --version`.
4. **Hold MySQL Packages:**
   It marks MySQL server, client, and common packages on hold to prevent updates.
5. **Verify Held Packages:**
   Finally, it lists all packages currently on hold.

### Script Usage
1. **Make the Script Executable:**
   ```bash
   chmod +x hold_php_mysql_versions.sh
   ```

2. **Run the Script:**
   ```bash
   sudo ./hold_php_mysql_versions.sh
   ```

3. **Verify Results:**
   After running the script, verify the packages are on hold:
   ```bash
   apt-mark showhold
   ```

### Script Code
```bash
#!/bin/bash

# Hold PHP packages
PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION . '.' . PHP_MINOR_VERSION;")
echo "Detected PHP version: $PHP_VERSION"
for PACKAGE in php$PHP_VERSION php$PHP_VERSION-cli php$PHP_VERSION-fpm php$PHP_VERSION-common php$PHP_VERSION-opcache; do
    echo "Holding PHP package: $PACKAGE"
    sudo apt-mark hold $PACKAGE
done

# Hold MySQL packages
MYSQL_VERSION=$(mysql --version | grep -oP 'Distrib \K[0-9]+\.[0-9]+')
echo "Detected MySQL version: $MYSQL_VERSION"
for PACKAGE in mysql-server-$MYSQL_VERSION mysql-client-$MYSQL_VERSION mysql-common-$MYSQL_VERSION; do
    echo "Holding MySQL package: $PACKAGE"
    sudo apt-mark hold $PACKAGE
done

# Verify held packages
echo "Packages currently on hold:"
apt-mark showhold
```

## Disclaimer | Running the Script
**Author:** Lalatendu Swain | [GitHub](https://github.com/Lalatenduswain) | [Website](https://blog.lalatendu.info/)

This script is provided as-is and may require modifications or updates based on your specific environment and requirements. Use it at your own risk. The authors of the script are not liable for any damages or issues caused by its usage.

## Donations
If you find this script useful and want to show your appreciation, you can donate via [Buy Me a Coffee](https://www.buymeacoffee.com/lalatendu.swain).

## Support or Contact
Encountering issues? Don't hesitate to submit an issue on our [GitHub page](https://github.com/Lalatenduswain/hold_php_mysql_versions/issues).
