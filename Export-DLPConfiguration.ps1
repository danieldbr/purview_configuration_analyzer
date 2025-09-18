param(
    [Parameter(Mandatory=$true)]
    [string]$AppId,

    [Parameter(Mandatory=$true)]
    [string]$CertificatePath,

    [Parameter(Mandatory=$true)]
    [string]$CertificatePassword,

    [Parameter(Mandatory=$true)]
    [string]$Organization
)

# Convert password to secure string
$SecureCertPassword = ConvertTo-SecureString -String $CertificatePassword -AsPlainText -Force

# Import ExchangeOnlineManagement module
Install-Module ExchangeOnlineManagement -Force -AllowClobber -Scope CurrentUser
Import-Module ExchangeOnlineManagement

# Connect to Security & Compliance
Connect-IPPSSession `
    -AppId $AppId `
    -CertificateFilePath $CertificatePath `
    -CertificatePassword $SecureCertPassword `
    -Organization $Organization

# Verify connection
Get-ConnectionInformation

# Get DLP Policies
$dlpPolicies = Get-DlpCompliancePolicy

# Get DLP Rules
$dlpRules = Get-DlpComplianceRule

# Combine policies and rules into a single object
$dlpConfiguration = @{
    Policies = $dlpPolicies
    Rules    = $dlpRules
}

# Export the backup to a JSON file
$dlpConfiguration | ConvertTo-Json -Depth 10 | Out-File "dlpConfiguration.json"
