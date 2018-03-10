#
# Exercise basic VM code paths.
#

# Assume running from $TOP, so the DLL will be in build dir.
Import-Module ./build/NtnxPoshSDK.dll -force
$ClusterIp = '10.7.255.141'
$VmName = '4k-rand-io'
$Password = ConvertTo-SecureString 'Nutanix.123' -AsPlainText -Force
#------------------------------------------------------------------------------
# Test authentication
#------------------------------------------------------------------------------
New-NTNX -Server $ClusterIp -UserName admin -Password $Password `
  -AcceptInvalidSslCerts

# Test as passed in param.
echo "Pass VM as parameter"
$VM = Get-VM -Name $VmName
$VM.json.spec.resources.power_state = "ON"
Set-VM -VM $VM

echo "Pass VM to pipeline"
Get-VM -Name $VmName | % { $_.json.spec.resources.power_state = "ON" } | Set-VM
