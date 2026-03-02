# Purview Configuration Export & Analysis

This repository provides tools to **export** your [Microsoft Purview](https://learn.microsoft.com/en-us/azure/purview/) configuration and optionally **analyze it with ChatGPT** to identify issues and suggest best practices.  


## Scenarios

- **Automation for Backup**  
  Currently, there is [no automated solution to back up](https://learn.microsoft.com/en-us/purview/data-gov-best-practices-disaster-recovery-migration) or version-control Microsoft Purview configurations.  
  This project was created to fill that gap by providing automated export and backup capabilities.  

- **Configuration as Code (GitOps)**  
  Store Purview configurations in version control for easier management, reviews, and deployments.  

- **ChatGPT Integration**  
  Analyze your Purview configuration using ChatGPT to detect issues and get recommendations for best practices.  


## Workflows

### Export Data Loss Prevention Configuration (`export_dlp_configuration.yml`)
Runs `Export-DlpConfiguration.ps1` to authenticate to Microsoft Purview (Security & Compliance) using certificate-based service principal authentication, export all DLP policies, DLP rules, and PCI policy settings, and save them into `dlpConfiguration.json`, which is then published as an artifact via `actions/upload-artifact`.

### Analyze Data Loss Prevention Configuration (`analyze_dlp_configuration.yml`)
Performs the same export process as above, then runs `Invoke-DlpAnalysis.ps1` to send the exported configuration to a ChatGPT prompt acting as a Purview Administrator, returning detailed analysis, best‑practice recommendations, and identification of potential misconfigurations.
