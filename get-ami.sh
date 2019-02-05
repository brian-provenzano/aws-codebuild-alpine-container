#!/bin/sh
#
# Gets current AMI (post processor in packer in aws codebuild) by reading the packer manifest.json created in packer json template
# Captures the image ID in local file for later usage in the build process
#
# Usage:
# get-ami.sh 
#
# Notes:
#
# Author:
# BJP - 1/19
#
export NEW_AMI=$(jq -r '.builds[].artifact_id' manifest.json | cut -d':' -f2)
echo "From Packer post processor - the AMI created: ${NEW_AMI}"
echo "Capturing AMI in ami.txt locally..."
echo -n $NEW_AMI > /root/ami.txt