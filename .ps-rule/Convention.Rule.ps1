
$Global:InstalledBicep = $True

# Synopsis: Install Bicep for expansion of .bicep files within GitHub Actions.
Export-PSRuleConvention 'Azure.BicepInstall' -If { $Configuration.AZURE_BICEP_FILE_EXPANSION -eq $True -and $Env:GITHUB_ACTION -eq '__Microsoft_ps-rule' } -Initialize {

    # Skip if already installed
    if (Test-Path -Path '/usr/local/bin/bicep') {
        Write-Warning -Message "Bicep is already installed."
        return
    }

    # Install the latest Bicep CLI binary for alpine
    Invoke-WebRequest -Uri 'https://github.com/Azure/bicep/releases/latest/download/bicep-linux-musl-x64' -OutFile $Env:GITHUB_WORKSPACE/bicep.bin

    # Set executable
    chmod +x $Env:GITHUB_WORKSPACE/bicep.bin

    # Copy to PATH environment
    Move-Item $Env:GITHUB_WORKSPACE/bicep.bin /usr/local/bin/bicep
}

