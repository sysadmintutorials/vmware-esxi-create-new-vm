# Creating Virtual Machines with PowerCLI
#### Date: 16/12/2020
#### Version: 1
#### Blog: www.sysadmintutorials.com
#### Twitter: @systutorials
#### Youtube: https://www.youtube.com/user/sysadmintutorials


## Description

This script automates the install of virtual machines within VMware ESXi.

It will prompt for the ip or DNS address of your ESXi host and then ask for your root user credentials.

Once a successful connection is established, you will then need to press 1, 2 or 3 in order to select the operating system you intend to install: Windows Server 2019, Windows Server 2016 or Windows Server 2012.

Lastly you will be prompted to enter the vm name, amount of vcpu's, ram and the hard disk size.

The script will then created the virtual machine based on the information you entered above.

## File Listing & Description
vmware-esxi-create-new-vm.ps1 (Creating Virtual Machines with PowerCLI)
