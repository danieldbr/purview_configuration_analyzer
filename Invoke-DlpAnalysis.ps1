param (
    [Parameter(Mandatory=$true)]
    [string]$JsonFilePath,

    [Parameter(Mandatory=$true)]
    [string]$ApiKey,

    [Parameter(Mandatory=$false)]
    [string]$OutputFilePath,

    [int]$MaxTokens = 800
)

# Read JSON file
if (-Not (Test-Path $JsonFilePath)) {
    Write-Error "File not found: $JsonFilePath"
    exit
}
$jsonContent = Get-Content -Path $JsonFilePath -Raw

# Build request body for ChatGPT
$body = @{
    model = "gpt-3.5-turbo"
    messages = @(
        @{
            role = "system"; content = "You are a Purview Administrator. Provide detailed analysis and guidance on DLP exports, focusing on best practices and identifying potential errors or misconfigurations."
        },
        @{
            role = "user"; content = "Here is the DLP JSON export: $jsonContent. Please review it thoroughly and provide insights, best practices recommendations, and any issues you spot."
        }
    )
    max_tokens = $MaxTokens
} | ConvertTo-Json -Depth 10

# Call OpenAI API
try {
    $response = Invoke-RestMethod -Uri "https://api.openai.com/v1/chat/completions" -Method Post -Headers @{
        "Content-Type" = "application/json"
        "Authorization" = "Bearer $ApiKey"
    } -Body $body

    # Get analysis text
    $analysis = $response.choices[0].message.content

    # Output to console
    Write-Output $analysis

    # Save to text file
    if ($OutputFilePath) {
        $analysis | Out-File -FilePath $OutputFilePath -Encoding UTF8
        Write-Output "Analysis saved to $OutputFilePath"
    }
}
catch {
    Write-Error "API request failed: $_"
}
