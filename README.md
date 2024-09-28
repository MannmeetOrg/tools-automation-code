# tools-automation-code

This Code is for having Infrastructure creation automatically but there are few manual steps to avoid secrets to be revealed.

This code is written in terraform, ansible.

"Create.yaml" is used to create Infrastructure for Github-runner, Vault and many other EC2 Instances required to have it run with various projects.

"Destroy.yaml" is used to Destroy all created Infrastructure via terraform.

Before the creation of Github runner there are few manual steps that you need to follow.
Note: You could run step 1 and step 2 via user data configuration at launch but step 3 still need manual intervention to add the code to link your github account.

Step1: sudo curl -L -o /etc/yum.repos.d/gh-cli.repo https://cli.github.com/packages/rpm/gh-cli.repo 

Step2:  sudo dnf install gh -y

Step3:  gh auth login -s admin:org

"github-runner.yaml" is used to configure the github runner EC2 Instance using Ansible which was created by terraform above automatically.

"vault.yaml" is used to configure the Hashicorp Vault EC2 Instance using ansible which was created by terraform above automatically.

