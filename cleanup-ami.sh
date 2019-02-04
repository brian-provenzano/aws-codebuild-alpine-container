#!/bin/sh
#Find snapshots associated with AMI.
aws ec2 describe-images --image-ids `cat ami.txt` | jq -r '.Images[].BlockDeviceMappings[0].Ebs.SnapshotId' > snapami.txt
echo -e "Following are the snapshots associated with ami : `cat snapami.txt`:\n "
echo -e "Deregister the AMI : `cat ami.txt`:\n"
aws ec2 deregister-image --image-id `cat ami.txt`
echo -e "\nDeleting the associated snapshots... `cat snapami.txt` \n"
for i in `cat snapami.txt`; do aws ec2 delete-snapshot --snapshot-id $i; done