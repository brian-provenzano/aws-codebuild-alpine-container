
## AWS Codebuild Docker Build Container Using Alpine Linux
Basic Alpine image build environment needed to create AWS AMIs per this POC project/repo [aws-codebuild-packer-poc](https://github.com/brian-provenzano/aws-codebuild-packer-poc


### Ingredients
- `alpine:latest` as base image
- python3, wget, git, jq, awscli, python, requests
- [My hashicorp-get script](https://github.com/brian-provenzano/hashicorp-get) to retrieve latest packer
- [get-ami.sh](https://github.com/brian-provenzano/aws-codebuild-alpine-container/blob/master/cleanup-ami.sh) to grab image ID of newly built AMI (via packer postprocessor in aws codebuild). See [packer template](https://github.com/brian-provenzano/aws-codebuild-packer-poc/blob/master/Basic-WebPHP-EC2AMI.json)
- [cleanup-ami.sh](https://github.com/brian-provenzano/aws-codebuild-alpine-container/blob/master/cleanup-ami.sh) - cleans up old versions of AMIs (deregisters AMI, deletes associated snapshots).

Note: See [Codebuild buildspec.yaml](https://github.com/brian-provenzano/aws-codebuild-packer-poc/blob/master/buildspec.yaml) for usage details

### Thanks 
Hashicorp
AWS
