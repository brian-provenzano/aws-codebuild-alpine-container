
## AWS Codebuild Docker Build Container Using Alpine Linux
Basic Alpine image build environment needed to create AWS AMIs per this POC project/repo [aws-codebuild-packer-poc](https://github.com/brian-provenzano/aws-codebuild-packer-poc


### Ingredients
- `alpine:latest` as base image
- python3, wget, git, jq, awscli, python, requests
- [My hashicorp-get script](https://github.com/brian-provenzano/hashicorp-get) to retrieve latest packer
- [get-ami.sh](https://github.com/brian-provenzano/aws-codebuild-alpine-container/blob/master/get-ami.sh) to grab image ID of newly built AMI (via packer postprocessor in aws codebuild). See [packer template](https://github.com/brian-provenzano/aws-codebuild-packer-poc/blob/master/Basic-WebPHP-EC2AMI.json)
- [cleanup-ami.sh](https://github.com/brian-provenzano/aws-codebuild-alpine-container/blob/master/cleanup-ami.sh) - cleans up old versions of AMIs (deregisters AMI, deletes associated snapshots).

Note: See [Codebuild buildspec.yaml](https://github.com/brian-provenzano/aws-codebuild-packer-poc/blob/master/buildspec.yaml) for usage details

### Policies
The following policies need to be added to the codebuild service role:
 - Policy to allow codebuild access to ECR [ECR policy](https://github.com/brian-provenzano/aws-codebuild-alpine-container/blob/master/codebuild-ecr-policy2.json)
 - Policy to allow codebuild update-project permissions [Codebuild update policy](https://github.com/brian-provenzano/aws-codebuild-alpine-container/blob/master/codebuild-allow-update-proj.json)

### Update
Now using AWS codebuild to build the docker image.  Changed buildspec.yaml (aws codebuild) to version 0.2 in order to get around the following.  I didnt realize version 0.1 was executing each command in an isolated subshell.

```
You can specify any Shell command. In build spec version 0.1, AWS CodeBuild runs each Shell command in a separate instance in the build environment. This means that each command runs in isolation from all other commands. Therefore, by default, you cannot run a single command that relies on the state of any previous commands (for example, changing directories or setting environment variables). To get around this limitation, we recommend that you use version 0.2, which solves this issue. 
```
https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-cmd.html


### Thanks 
Hashicorp
AWS
