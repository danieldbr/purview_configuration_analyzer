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
