#!/bin/bash

####################################################################################################
#
# Copyright (c) 2017, Jamf, LLC.  All rights reserved.
#
#       Redistribution and use in source and binary forms, with or without
#       modification, are permitted provided that the following conditions are met:
#               * Redistributions of source code must retain the above copyright
#                 notice, this list of conditions and the following disclaimer.
#               * Redistributions in binary form must reproduce the above copyright
#                 notice, this list of conditions and the following disclaimer in the
#                 documentation and/or other materials provided with the distribution.
#               * Neither the name of the JAMF Software, LLC nor the
#                 names of its contributors may be used to endorse or promote products
#                 derived from this software without specific prior written permission.
#
#       THIS SOFTWARE IS PROVIDED BY JAMF SOFTWARE, LLC "AS IS" AND ANY
#       EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#       DISCLAIMED. IN NO EVENT SHALL JAMF SOFTWARE, LLC BE LIABLE FOR ANY
#       DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#       (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#       LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#       ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#       (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
####################################################################################################

# written by Katie English, Jamf October 2016
# updated for 10.12 CIS benchmarks by Katie English, Jamf May 2017
# updated to use configuration profiles by Apple Professional Services, January 2018
# github.com/jamfprofessionalservices

# USAGE
# Admins set organizational compliance for each listed item, which gets written to plist.
# Values default to "true," and must be commented to "false" to disregard as an organizational priority.
# Writes to /Library/Application Support/SecurityScoring/org_security_score.plist by default.

# Create the Scoring file destination directory if it does not already exist

dir="/Library/Application Support/SecurityScoring"

if [[ ! -e "$dir" ]]; then
    mkdir "$dir"
fi
plistlocation="$dir/org_security_score.plist"


##################################################################
############### ADMINS DESIGNATE ORG VALUES BELOW ################
##################################################################

# 1.1 Verify all Apple provided software is current
# Best managed via Jamf
# OrgScore1_1="true"
OrgScore1_1="false"

# 1.2 Enable Auto Update
# Configuration Profile - Custom payload > com.apple.SoftwareUpdate.plist > AutomaticCheckEnabled=true, AutomaticDownload=true
OrgScore1_2="true"
# OrgScore1_2="false"

# 1.3 Enable app update installs
# Does not work as a Configuration Profile - Custom payload > com.apple.commerce
OrgScore1_3="true"
# OrgScore1_3="false"

# 1.4 Enable system data files and security update installs
# Configuration Profile - Custom payload > com.apple.SoftwareUpdate.plist > ConfigDataInstall=true, CriticalUpdateInstall=true
OrgScore1_4="true"
# OrgScore1_4="false"

# 1.5 Enable OS X update installs
# Does not work as a Configuration Profile - Custom payload > com.apple.commerce
OrgScore1_5="true"
# OrgScore1_5="false"

# 2.1.1 Turn off Bluetooth, if no paired devices exist
OrgScore2_1_1="true"
# OrgScore2_1_1="false"

## 2.1.2 Turn off Bluetooth "Discoverable" mode when not pairing devices - not applicable to 10.9 and higher.
## Starting with OS X (10.9) Bluetooth is only set to Discoverable when the Bluetooth System Preference is selected.
## To ensure that the computer is not Discoverable do not leave that preference open.

# 2.1.3 Show Bluetooth status in menu bar
OrgScore2_1_3="true"
# OrgScore2_1_3="false"

# 2.2.1 Enable "Set time and date automatically" (Not Scored)
OrgScore2_2_1="true"
# OrgScore2_2_1="false"

# 2.2.2 Ensure time set is within appropriate limits
# Not audited - only enforced if identified as priority
OrgScore2_2_2="true"
# OrgScore2_2_2="false"

# 2.2.3 Restrict NTP server to loopback interface
OrgScore2_2_3="true"
# OrgScore2_2_3="false"

# 2.3.1 Set an inactivity interval of 20 minutes or less for the screen saver
# Configuration Profile - LoginWindow payload > Options > Start screen saver after: 20 Minutes of Inactivity
OrgScore2_3_1="true"
# OrgScore2_3_1="false"

# 2.3.2 Secure screen saver corners
# Configuration Profile - Custom payload > com.apple.dock > wvous-tl-corner=0, wvous-br-corner=5, wvous-bl-corner=0, wvous-tr-corner=0
OrgScore2_3_2="true"
# OrgScore2_3_2="false"

## 2.3.3 Verify Display Sleep is set to a value larger than the Screen Saver (Not Scored)
## The rationale in the CIS Benchmark for this is incorrect. The computer will lock if the
## display sleeps before the Screen Saver activates

# 2.3.4 Set a screen corner to Start Screen Saver
# Configuration Profile - Custom payload > com.apple.dock > wvous-tl-corner=0, wvous-br-corner=5, wvous-bl-corner=0, wvous-tr-corner=0
OrgScore2_3_4="true"
# OrgScore2_3_4="false"

# 2.4.1 Disable Remote Apple Events
OrgScore2_4_1="true"
# OrgScore2_4_1="false"

# 2.4.2 Disable Internet Sharing
OrgScore2_4_2="true"
# OrgScore2_4_2="false"

# 2.4.3 Disable Screen Sharing
OrgScore2_4_3="true"
# OrgScore2_4_3="false"

# 2.4.4 Disable Printer Sharing
OrgScore2_4_4="true"
# OrgScore2_4_4="false"

# 2.4.5 Disable Remote Login
# SSH
OrgScore2_4_5="true"
# OrgScore2_4_5="false"

# 2.4.6 Disable DVD or CD Sharing
OrgScore2_4_6="true"
# OrgScore2_4_6="false"

# 2.4.7 Disable Bluetooth Sharing
OrgScore2_4_7="true"
# OrgScore2_4_7="false"

# 2.4.8 Disable File Sharing
OrgScore2_4_8="true"
# OrgScore2_4_8="false"

# 2.4.9 Disable Remote Management
# Screen Sharing and Apple Remote Desktop
OrgScore2_4_9="true"
# OrgScore2_4_9="false"

# 2.5.1 Disable "Wake for network access"
OrgScore2_5_1="true"
# OrgScore2_5_1="false"

# 2.5.2 Disable sleeping the computer when connected to power
OrgScore2_5_2="true"
# OrgScore2_5_2="false"

# 2.6.1 Enable FileVault
OrgScore2_6_1="true"
# OrgScore2_6_1="false"

# 2.6.2 Enable Gatekeeper
# Configuration Profile - Security and Privacy payload > General > Gatekeeper > Mac App Store and identified developers (selected)
OrgScore2_6_2="true"
# OrgScore2_6_2="false"

# 2.6.3 Enable Firewall
# Configuration Profile - Security and Privacy payload > Firewall > Enable Firewall (checked)
OrgScore2_6_3="true"
# OrgScore2_6_3="false"

# 2.6.4 Enable Firewall Stealth Mode
# Configuration Profile - Security and Privacy payload > Firewall > Enable stealth mode (checked)
OrgScore2_6_4="true"
# OrgScore2_6_4="false"

# 2.6.5 Review Application Firewall Rules
# Configuration Profile - Security and Privacy payload > Firewall > Control incoming connections for specific apps (selected)
OrgScore2_6_5="true"
# OrgScore2_6_5="false"

# 2.6.6 Enable Location Services (Not Scored)
OrgScore2_6_6="true"

## 2.6.7 Monitor Location Services Access (Not Scored)
## As of macOS 10.12.2, Location Services cannot be enabled/monitored programmatically.
## It is considered user opt in.

# 2.7.1 iCloud configuration (Check for iCloud accounts) (Not Scored)
OrgScore2_7_1="true"
# OrgScore2_7_1="false"

# 2.7.1.01 Disable Apple ID setup during login (Not Scored)
# Configuration Profile - LoginWindow payload > Options >  Disable Apple ID setup during login (checked)
OrgScore2_7_1_01="true"
# OrgScore2_7_1_01="false"

# 2.7.1.02 Disable the iCloud system preference pane (Not Scored)
# Configuration Profile - Restrictions payload > Preferences > disable selected items > iCloud
OrgScore2_7_1_02="true"
# OrgScore2_7_1_02="false"

# 2.7.1.03 Disable the use of iCloud password for local accounts (Not Scored)
# Configuration Profile - Restrictions payload > Functionality > Allow use of iCloud password for local accounts (unchecked)
OrgScore2_7_1_03="true"
# OrgScore2_7_1_03="false"

# 2.7.1.04 Disable iCloud Back to My Mac (Not Scored)
# Configuration Profile - Restrictions payload > Functionality > Allow iCloud Back to My Mac (unchecked)
OrgScore2_7_1_04="true"
# OrgScore2_7_1_04="false"

# 2.7.1.05 Disable iCloud Find My Mac (Not Scored)
# Configuration Profile - Restrictions payload > Functionality > Allow iCloud Find My Mac (unchecked)
OrgScore2_7_1_05="true"
# OrgScore2_7_1_05="false"

# 2.7.1.06 Disable iCloud Bookmarks (Not Scored)
# Configuration Profile - Restrictions payload > Functionality > Allow iCloud Bookmarks (unchecked)
OrgScore2_7_1_06="true"
# OrgScore2_7_1_06="false"

# 2.7.1.07 Disable iCloud Mail (Not Scored)
# Configuration Profile - Restrictions payload > Functionality > Allow iCloud Mail (unchecked)
OrgScore2_7_1_07="true"
# OrgScore2_7_1_07="false"

# 2.7.1.08 Disable iCloud Calendar (Not Scored)
# Configuration Profile - Restrictions payload > Functionality > Allow iCloud Calendar (unchecked)
OrgScore2_7_1_08="true"
# OrgScore2_7_1_08="false"

# 2.7.1.09 Disable iCloud Reminders (Not Scored)
# Configuration Profile - Restrictions payload > Functionality > Allow iCloud Reminders (unchecked)
OrgScore2_7_1_09="true"
# OrgScore2_7_1_09="false"

# 2.7.1.10 Disable iCloud Contacts (Not Scored)
# Configuration Profile - Restrictions payload > Functionality > Allow iCloud Contacts (unchecked)
OrgScore2_7_1_10="true"
# OrgScore2_7_1_10="false"

# 2.7.1.11 Disable iCloud Notes (Not Scored)
# Configuration Profile - Restrictions payload > Functionality > Allow iCloud Notes (unchecked)
OrgScore2_7_1_11="true"
# OrgScore2_7_1_11="false"

# 2.7.1.12 Disable Content Caching (Not Scored)
# Configuration Profile - Restrictions payload > Functionality > Allow Content Caching (unchecked)
OrgScore2_7_1_12="true"
# OrgScore2_7_1_12="false"

# 2.7.2 iCloud keychain (Not Scored)
# Configuration Profile - Restrictions payload > Functionality > Allow iCloud Keychain (unchecked)
OrgScore2_7_2="true"
# OrgScore2_7_2="false"

# 2.7.3 iCloud Drive (Not Scored)
# Configuration Profile - Restrictions payload > Functionality > Allow iCloud Drive (unchecked)
OrgScore2_7_3="true"
# OrgScore2_7_3="false"

# 2.7.4 iCloud Drive Document sync
# Configuration Profile - Restrictions payload - > Functionality > Allow iCloud Desktop & Documents (unchecked)
OrgScore2_7_4="true"
# OrgScore2_7_4="false"

# 2.7.5 iCloud Drive Desktop sync
# Configuration Profile - Restrictions payload - > Functionality > Allow iCloud Desktop & Documents (unchecked)
OrgScore2_7_5="true"
# OrgScore2_7_5="false"

# 2.8.1 Time Machine Auto-Backup
# Time Machine is typically not used as an Enterprise backup solution
# OrgScore2_8_1="true"
OrgScore2_8_1="false"

## 2.8.2 Time Machine Volumes Are Encrypted (Not Scored)
## Time Machine is typically not used as an Enterprise backup solution

# 2.9 Pair the remote control infrared receiver if enabled
# Since 2013 only the Mac Mini has an infrared receiver
OrgScore2_9="true"
# OrgScore2_9="false"

# 2.10 Enable Secure Keyboard Entry in terminal.app
# Configuration Profile - Custom payload > com.apple.Terminal > SecureKeyboardEntry=true
OrgScore2_10="true"
# OrgScore2_10="false"

# 2.11 Java 6 is not the default Java runtime
OrgScore2_11="true"
# OrgScore2_11="false"

## 2.12 Securely delete files as needed (Not Scored)
## With the wider use of FileVault and other encryption methods and the growing use of Solid State Drives
## the requirements have changed and the "Secure Empty Trash" capability has been removed from the GUI.

# 3.1.1 Retain system.log for 90 or more days
OrgScore3_1_1="true"
# OrgScore3_1_1="false"

# 3.1.2 Retain appfirewall.log for 90 or more days
OrgScore3_1_2="true"
# OrgScore3_1_2="false"

# 3.1.3 Retain authd.log for 90 or more days
OrgScore3_1_3="true"
# OrgScore3_1_3="false"

# 3.2 Enable security auditing
OrgScore3_2="true"
# OrgScore3_2="false"

# 3.3 Configure Security Auditing Flags
OrgScore3_3="true"
# OrgScore3_3="false"

## 3.4 Enable remote logging for Desktops on trusted networks (Not Scored)
## The built-in syslog capability in OS X runs over UDP without encryption. Broadcasting log unencrypted over
## the internet is not a good idea. While syslog may be acceptable on some internal trusted networks it is not a
## solution for mobile devices that hop between networks.

# 3.5 Retain install.log for 365 or more days
OrgScore3_5="true"
# OrgScore3_5="false"

# 4.1 Disable Bonjour advertising service
# Configuration Profile - Custom payload > com.apple.mDNSResponder > NoMulticastAdvertisements=true
OrgScore4_1="true"
# OrgScore4_1="false"

# 4.2 Enable "Show Wi-Fi status in menu bar"
OrgScore4_2="true"
# OrgScore4_2="false"

## 4.3 Create network specific locations (Not Scored)

# 4.4 Ensure http server is not running
OrgScore4_4="true"
# OrgScore4_4="false"

# 4.5 Ensure ftp server is not running
OrgScore4_5="true"
# OrgScore4_5="false"

# 4.6 Ensure nfs server is not running
OrgScore4_6="true"
# OrgScore4_6="false"

# 5.1.1 Secure Home Folders
OrgScore5_1_1="true"
# OrgScore5_1_1="false"

# 5.1.2 Check System Wide Applications for appropriate permissions
OrgScore5_1_2="true"
# OrgScore5_1_2="false"

# 5.1.3 Check System folder for world writable files
OrgScore5_1_3="true"
# OrgScore5_1_3="false"

# 5.1.4 Check Library folder for world writable files
OrgScore5_1_4="true"
# OrgScore5_1_4="false"

## Managed by Active Directory, Enterprise Connect, or a configuration profile.
## 5.2.1 Configure account lockout threshold
## 5.2.2 Set a minimum password length
## 5.2.3 Complex passwords must contain an Alphabetic Character
## 5.2.4 Complex passwords must contain a Numeric Character
## 5.2.5 Complex passwords must contain a Special Character
## 5.2.6 Complex passwords must uppercase and lowercase letters
## 5.2.7 Password Age
## 5.2.8 Password History

# 5.3 Reduce the sudo timeout period
OrgScore5_3="true"
# OrgScore5_3="false"

# 5.4 Automatically lock the login keychain for inactivity
# This is a very bad idea. It will confuse users.
# OrgScore5_4="true"
OrgScore5_4="false"

# 5.5 Ensure login keychain is locked when the computer sleeps
# This is a very bad idea. It will confuse users.
# OrgScore5_5="true"
OrgScore5_5="false"

# 5.6 Enable OCSP and CRL certificate checking
# Does not work as a Configuration Profile - Custom payload > com.apple.security.revocation
# This is a very bad idea. CRL and OCSP should be set to Best Attempt.
# OrgScore5_6="true"
OrgScore5_6="false"

# 5.7 Do not enable the "root" account
OrgScore5_7="true"
# OrgScore5_7="false"

# 5.8 Disable automatic login
# Configuration Profile - LoginWindow payload > Options > Disable automatic login (checked)
OrgScore5_8="true"
# OrgScore5_8="false"

# 5.9 Require a password to wake the computer from sleep or screen saver
# Configuration Profile - Security and Privacy payload > General > Require password * after sleep or screen saver begins (checked)
OrgScore5_9="true"
# OrgScore5_9="false"

# 5.10 Require an administrator password to access system-wide preferences
OrgScore5_10="true"
# OrgScore5_10="false"

# 5.11 Disable ability to login to another user's active and locked session
OrgScore5_11="true"
# OrgScore5_11="false"

# 5.12 Create a custom message for the Login Screen
# Configuration Profile - LoginWindow payload > Window > Banner (message)
OrgScore5_12="true"
# OrgScore5_12="false"

# 5.13 Create a Login window banner
# Policy Banner https://support.apple.com/en-us/HT202277
OrgScore5_13="true"
# OrgScore5_13="false"

## 5.14 Do not enter a password-related hint (Not Scored)
## Not needed if 6.1.2 Disable "Show password hints" is enforced.

# 5.15 Disable Fast User Switching (Not Scored)
# Configuration Profile - LoginWindow payload > Options > Enable Fast User Switching (unchecked)
OrgScore5_15="true"
# OrgScore5_15="false"

## 5.16 Secure individual keychains and items (Not Scored)

## 5.17 Create specialized keychains for different purposes (Not Scored)

# 5.18 System Integrity Protection status
OrgScore5_18="true"
# OrgScore5_18="false"

# 5.19 Install an approved tokend for smartcard authentication
# This is superseded by the macos 10.12.x built in SmartCardServices and CryptoTokenKit.
# OrgScore5_19="true"
OrgScore5_19="false"

# 6.1.1 Display login window as name and password
# Configuration Profile - LoginWindow payload > Window > LOGIN PROMPT > Name and password text fields (selected)
OrgScore6_1_1="true"
# OrgScore6_1_1="false"

# 6.1.2 Disable "Show password hints"
# Configuration Profile - LoginWindow payload > Options > Show password hint when needed and available (unchecked - Yes this is backwards)
OrgScore6_1_2="true"
# OrgScore6_1_2="false"

# 6.1.3 Disable guest account
# Configuration Profile - LoginWindow payload > Options > Allow Guest User (unchecked)
OrgScore6_1_3="true"
# OrgScore6_1_3="false"

# 6.1.4 Disable "Allow guests to connect to shared folders"
# Configuration Profile - 6.1.4 Disable Allow guests to connect to shared folders - Custom payload > com.apple.AppleFileServer guestAccess=false, com.apple.smb.server AllowGuestAccess=false
OrgScore6_1_4="true"
# OrgScore6_1_4="false"

# 6.1.5 Remove Guest home folder
OrgScore6_1_5="true"
# OrgScore6_1_5="false"

# 6.2 Turn on filename extensions
# Does not work as a Configuration Profile - .GlobalPreferences.plist
OrgScore6_2="true"
# OrgScore6_2="false"

# 6.3 Disable the automatic run of safe files in Safari
# Configuration Profile - Custom payload > com.apple.Safari > AutoOpenSafeDownloads=false
OrgScore6_3="true"
# OrgScore6_3="false"

## 6.4 Safari disable Internet Plugins for global use (Not Scored)

## 6.5 Use parental controls for systems that are not centrally managed (Not Scored)


##################################################################
############# DO NOT MODIFY ANYTHING BELOW THIS LINE #############
##################################################################
# Write org_security_score values to local plist

cat << EOF > "$plistlocation"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
		<key>OrgScore1_1</key>
		<${OrgScore1_1}/>
		<key>OrgScore1_2</key>
		<${OrgScore1_2}/>
		<key>OrgScore1_3</key>
		<${OrgScore1_3}/>
		<key>OrgScore1_4</key>
		<${OrgScore1_4}/>
		<key>OrgScore1_5</key>
		<${OrgScore1_5}/>
		<key>OrgScore2_1_1</key>
		<${OrgScore2_1_1}/>
		<key>OrgScore2_1_3</key>
		<${OrgScore2_1_3}/>
		<key>OrgScore2_2_1</key>
		<${OrgScore2_2_1}/>
		<key>OrgScore2_2_2</key>
		<${OrgScore2_2_2}/>
		<key>OrgScore2_2_3</key>
		<${OrgScore2_2_3}/>
		<key>OrgScore2_3_1</key>
		<${OrgScore2_3_1}/>
		<key>OrgScore2_3_2</key>
		<${OrgScore2_3_2}/>
		<key>OrgScore2_3_4</key>
		<${OrgScore2_3_4}/>
		<key>OrgScore2_4_1</key>
		<${OrgScore2_4_1}/>
		<key>OrgScore2_4_2</key>
		<${OrgScore2_4_2}/>
		<key>OrgScore2_4_3</key>
		<${OrgScore2_4_3}/>
		<key>OrgScore2_4_4</key>
		<${OrgScore2_4_4}/>
		<key>OrgScore2_4_5</key>
		<${OrgScore2_4_5}/>
		<key>OrgScore2_4_6</key>
		<${OrgScore2_4_6}/>
		<key>OrgScore2_4_7</key>
		<${OrgScore2_4_7}/>
		<key>OrgScore2_4_8</key>
		<${OrgScore2_4_8}/>
		<key>OrgScore2_4_9</key>
		<${OrgScore2_4_9}/>
		<key>OrgScore2_5_1</key>
		<${OrgScore2_5_1}/>
		<key>OrgScore2_5_2</key>
		<${OrgScore2_5_2}/>
		<key>OrgScore2_6_1</key>
		<${OrgScore2_6_1}/>
		<key>OrgScore2_6_2</key>
		<${OrgScore2_6_2}/>
		<key>OrgScore2_6_3</key>
		<${OrgScore2_6_3}/>
		<key>OrgScore2_6_4</key>
		<${OrgScore2_6_4}/>
		<key>OrgScore2_6_5</key>
		<${OrgScore2_6_5}/>
		<key>OrgScore2_7_1</key>
		<${OrgScore2_7_1}/>
		<key>OrgScore2_7_1_01</key>
		<${OrgScore2_7_1_01}/>
		<key>OrgScore2_7_1_02</key>
		<${OrgScore2_7_1_02}/>
		<key>OrgScore2_7_1_03</key>
		<${OrgScore2_7_1_03}/>
		<key>OrgScore2_7_1_04</key>
		<${OrgScore2_7_1_04}/>
		<key>OrgScore2_7_1_05</key>
		<${OrgScore2_7_1_05}/>
		<key>OrgScore2_7_1_06</key>
		<${OrgScore2_7_1_06}/>
		<key>OrgScore2_7_1_07</key>
		<${OrgScore2_7_1_07}/>
		<key>OrgScore2_7_1_08</key>
		<${OrgScore2_7_1_08}/>
		<key>OrgScore2_7_1_09</key>
		<${OrgScore2_7_1_09}/>
		<key>OrgScore2_7_1_10</key>
		<${OrgScore2_7_1_10}/>
		<key>OrgScore2_7_1_11</key>
		<${OrgScore2_7_1_11}/>
		<key>OrgScore2_7_1_12</key>
		<${OrgScore2_7_1_12}/>
		<key>OrgScore2_7_2</key>
		<${OrgScore2_7_2}/>
		<key>OrgScore2_7_3</key>
		<${OrgScore2_7_3}/>
		<key>OrgScore2_7_4</key>
		<${OrgScore2_7_4}/>
		<key>OrgScore2_7_5</key>
		<${OrgScore2_7_5}/>
		<key>OrgScore2_8_1</key>
		<${OrgScore2_8_1}/>
		<key>OrgScore2_9</key>
		<${OrgScore2_9}/>
		<key>OrgScore2_10</key>
		<${OrgScore2_10}/>
		<key>OrgScore2_11</key>
		<${OrgScore2_11}/>
		<key>OrgScore3_1_1</key>
		<${OrgScore3_1_1}/>
		<key>OrgScore3_1_2</key>
		<${OrgScore3_1_2}/>
		<key>OrgScore3_1_3</key>
		<${OrgScore3_1_3}/>
		<key>OrgScore3_2</key>
		<${OrgScore3_2}/>
		<key>OrgScore3_3</key>
		<${OrgScore3_3}/>
		<key>OrgScore3_5</key>
		<${OrgScore3_5}/>
		<key>OrgScore4_1</key>
		<${OrgScore4_1}/>
		<key>OrgScore4_2</key>
		<${OrgScore4_2}/>
		<key>OrgScore4_4</key>
		<${OrgScore4_4}/>
		<key>OrgScore4_5</key>
		<${OrgScore4_5}/>
		<key>OrgScore4_6</key>
		<${OrgScore4_6}/>
		<key>OrgScore5_1_1</key>
		<${OrgScore5_1_1}/>
		<key>OrgScore5_1_2</key>
		<${OrgScore5_1_2}/>
		<key>OrgScore5_1_3</key>
		<${OrgScore5_1_3}/>
		<key>OrgScore5_1_4</key>
		<${OrgScore5_1_4}/>
		<key>OrgScore5_3</key>
		<${OrgScore5_3}/>
		<key>OrgScore5_4</key>
		<${OrgScore5_4}/>
		<key>OrgScore5_5</key>
		<${OrgScore5_5}/>
		<key>OrgScore5_6</key>
		<${OrgScore5_6}/>
		<key>OrgScore5_7</key>
		<${OrgScore5_7}/>
		<key>OrgScore5_8</key>
		<${OrgScore5_8}/>
		<key>OrgScore5_9</key>
		<${OrgScore5_9}/>
		<key>OrgScore5_10</key>
		<${OrgScore5_10}/>
		<key>OrgScore5_11</key>
		<${OrgScore5_11}/>
		<key>OrgScore5_12</key>
		<${OrgScore5_12}/>
		<key>OrgScore5_13</key>
		<${OrgScore5_13}/>
		<key>OrgScore5_15</key>
		<${OrgScore5_15}/>
		<key>OrgScore5_18</key>
		<${OrgScore5_18}/>
		<key>OrgScore5_19</key>
		<${OrgScore5_19}/>
		<key>OrgScore6_1_1</key>
		<${OrgScore6_1_1}/>
		<key>OrgScore6_1_2</key>
		<${OrgScore6_1_2}/>
		<key>OrgScore6_1_3</key>
		<${OrgScore6_1_3}/>
		<key>OrgScore6_1_4</key>
		<${OrgScore6_1_4}/>
		<key>OrgScore6_1_5</key>
		<${OrgScore6_1_5}/>
		<key>OrgScore6_2</key>
		<${OrgScore6_2}/>
		<key>OrgScore6_3</key>
		<${OrgScore6_3}/>
</dict>
</plist>
EOF
