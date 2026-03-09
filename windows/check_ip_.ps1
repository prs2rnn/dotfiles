# Fetch IP information from ipinfo.io
try {
    $url = "https://ipinfo.io/json"
    $response = Invoke-RestMethod -Uri $url -Method Get
    
    # Display each property line by line
    foreach ($property in $response.PSObject.Properties) {
        Write-Host "$($property.Name): $($property.Value)"
    }
} catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
} finally {
    # Prevent console from closing
    Read-Host -Prompt "Press Enter to exit"
}