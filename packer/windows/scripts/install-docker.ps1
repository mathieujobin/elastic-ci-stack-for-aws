# Stop script execution when a non-terminating error occurs
$ErrorActionPreference = "Stop"

$docker_version="19.03.5"

Write-Output "Upgrading DockerMsftProvider module"
Update-Module -Name DockerMsftProvider -Force

Write-Output "Installing docker enterprise edition"
Stop-Service docker
Install-Package -Name docker -ProviderName DockerMsftProvider -Force -RequiredVersion $docker_version
Start-Service docker

Write-Output "Installing docker-compose"
choco install -y docker-compose
If ($lastexitcode -ne 0) { Exit $lastexitcode }

Write-Output "Installing jq"
choco install -y jq
If ($lastexitcode -ne 0) { Exit $lastexitcode }
