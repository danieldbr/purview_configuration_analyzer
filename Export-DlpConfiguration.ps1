param(
    [Parameter(Mandatory=$true)]
    [string]$AppId,

    [Parameter(Mandatory=$true)]
    [string]$CertificatePath,

    [Parameter(Mandatory=$true)]
    [securestring]$CertificatePassword,

    [Parameter(Mandatory=$true)]
    [string]$Organization
)

# Import ExchangeOnlineManagement module
Install-Module ExchangeOnlineManagement -Force -AllowClobber -Scope CurrentUser
Import-Module ExchangeOnlineManagement

# Connect to Security & Compliance
Connect-IPPSSession `
    -AppId $AppId `
    -CertificateFilePath $CertificatePath `
    -CertificatePassword $CertificatePassword `
    -Organization $Organization

# Verify connection
Get-ConnectionInformation

# Get DLP policies
$dlpPolicies = Get-DlpCompliancePolicy

# Get DLP rules
$dlpRules = Get-DlpComplianceRule

# Combine policies and rules into a single object
$dlpConfiguration = @{
    Policies = $dlpPolicies
    Rules    = $dlpRules
}

# Export the backup to a JSON file
$dlpConfiguration | ConvertTo-Json -Depth 10 | Out-File "dlpConfiguration.json"
Write-Output "DLP configuration exported"

# Get PCI policy
$pciPolicies = Get-DlpCompliancePolicy -Identity "PCI Data Security Standard (PCI DSS)"
$pciPolicies | ConvertTo-Json -Depth 10 | Out-File "pciPolicy.json"
Write-Output "PCI policy exported"
