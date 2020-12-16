<#
    ===========================================================================
    Script Created by: David Rodriguez
    Blog:                   www.sysadmintutorials.com
    Twitter:                @systutorials
    Youtube:                https://www.youtube.com/user/sysadmintutorials
    ===========================================================================
    .DESCRIPTION
    This script will automate the creation of virtual machine within ESXi
#>

$vmhostipaddress = Read-Host "Enter the IP of your VMware ESXi Host"
$vmhostcreds = Get-Credential -Message "Please enter the root username and password"

Write-Host -ForegroundColor Yellow "`n---- Connecting to VMware ESXi Host ----"
try{
    Connect-VIServer $vmhostipaddress -User "$($vmhostcreds.UserName)" -Password ([System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($vmhostcreds.Password))) -ErrorAction Stop | Out-Null
    Write-Host -ForegroundColor Green "Successfully connected to VMware ESXi Host"
    }
catch
    {
    Write-Warning -Message $("Something went wrong connecting to the ESXi host. Please read the error message and re-run the script. Error: "+ $_.Exception.Message)
    Break;
    }
    

Write-Host "Operating system options" -ForegroundColor Yellow
Write-Host "1. Windows Server 2019"
Write-Host "2. Windows Server 2016"
Write-Host "3. Windows Server 2012"

$operatingsystem = Read-Host "Select the Operating System you wish to install by typing in either 1, 2 or 3 ?"

IF ($operatingsystem -eq 1)
    {
    $guestid = "windows2019srv_64Guest"
    }
IF ($operatingsystem -eq 2)
    {
    $guestid = "windows9Server64Guest"
    }
IF ($operatingsystem -eq 3)
    {
    $guestid = "windows8Server64Guest"
    }

$vmname = Read-Host "Please enter the name of the virtual machine?"
$cpuamount = Read-Host "How many CPU's would you like to provision?"
$ramamount = Read-Host "How much RAM do you wish to provision in GB's?"
$hddamount = Read-Host "How much Disk storage do you wish to provision in GB's?"

try
    {
    New-VM -Name $vmname -Datastore datastore1 -NumCpu $cpuamount -MemoryGB $ramamount -DiskGB $hddamount -DiskStorageFormat Thin -NetworkName "VM Network" -CD -GuestId $guestid -ErrorAction Stop | Out-Null
    Get-VM $vmname | Get-NetworkAdapter | Set-NetworkAdapter -Type VMXNet3 -Confirm:$False -ErrorAction Stop | Out-Null
    Write-Host "Successfully created $($vmname)" -ForegroundColor Green
    }
catch
    {
    Write-Warning -Message $("Something went wrong in creating the virtual machine: $($vmname). Please read the error message and re-run the script. Error: "+ $_.Exception.Message)
    Break;
    }


