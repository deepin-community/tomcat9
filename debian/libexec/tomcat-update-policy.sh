#!/bin/sh
#
# Script regenerating the catalina.policy file from the collection
# of files in /etc/tomcat9/policy.d/
#
# This script is run as root by systemd before starting Tomcat.
#

set -e

if [ ! -d "$CATALINA_BASE/conf" ]; then
    echo "<2>Invalid CATALINA_BASE, configuration files not found: $CATALINA_BASE"
    exit 1
fi

# Regenerate the catalina.policy file
POLICY_CACHE="$CATALINA_BASE/policy/catalina.policy"
umask 022
rm -rf "$CATALINA_BASE/policy"
mkdir "$CATALINA_BASE/policy"
echo "// AUTO-GENERATED FILE from /etc/tomcat9/policy.d/" > "$POLICY_CACHE"
echo ""  >> "$POLICY_CACHE"
cat $CATALINA_BASE/conf/policy.d/*.policy >> "$POLICY_CACHE"
