#!/bin/sh
#
# Get all current custom AMIs; delete oldest + all associated snapshots
# since we are running this after each build and started with 1 image, should always retain 2
#

AMI_COUNT=$(aws ec2 describe-images --owners self --filters 'Name=tag:Purpose,Values=web' --query 'Images[*].{ID:ImageId}' --output text | wc -l)
if [[$AMICOUNT -gt 1]]; then
    aws ec2 describe-images --owners self --filters 'Name=tag:Purpose,Values=web' --query 'sort_by(Images, &CreationDate)[0].[ImageId]' --output text > /root/ami-delete.txt
    aws ec2 describe-images --image-ids $(cat /root/ami-delete.txt) | jq -r '.Images[].BlockDeviceMappings[0].Ebs.SnapshotId' > /root/snapami-delete.txt
    echo -e "Following are the snapshots associated with ami: $(cat /root/snapami-delete.txt) \n "
    echo -e "Deregister the AMI: $(cat /root/ami-delete.txt) \n"
    aws ec2 deregister-image --image-id $(cat /root/ami-delete.txt)
    echo -e "\nDeleting the associated snapshots... $(cat /root/snapami-delete.txt) \n"
    for i in $(cat /root/snapami-delete.txt); do aws ec2 delete-snapshot --snapshot-id $i; done
fi