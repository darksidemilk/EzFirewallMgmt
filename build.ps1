
<#PSScriptInfo

.VERSION 2.0.0.0

.GUID 473e8205-f9ee-4185-9daa-096fb36cf0b6

.AUTHOR JJ Fullmer

.COMPANYNAME DarkSidePwnGramming

.COPYRIGHT 2020

.TAGS firewall

.LICENSEURI

.PROJECTURI

.ICONURI

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES

		2.0.0.0
			Updated with documentation integrations

		1.0.0.0
			Updated script to proper format

.PRIVATEDATA

#>

#Requires -Modules PlatyPS

<# 

.DESCRIPTION 
 Script to manually build the module, this will install the third party platyps module 
 This is a light version of the build script I use, but it should be enough for basic testing
 of new features. The original contains propietary code that can't be shared.

 .PARAMETER releaseNote
 A string explaining what was done in the build to be added to the release notes

#> 
[CmdletBinding()]
Param(
	$releaseNote = "general updates and bug fixes"
)

$moduleName = 'EzFirewallMgmt'
$modulePath = "$PSScriptRoot\$moduleName";

mkdir $modulePath -EA 0;
# mkdir "$modulePath\tools" -EA 0;
# mkdir "$modulePath\docs" -EA 0;
mkdir "$modulePath\lib" -EA 0;
mkdir "$modulePath\bin" -EA 0;
mkdir "$modulePath\Public" -EA 0;
mkdir "$modulePath\Private" -EA 0;
mkdir "$modulePath\Classes" -EA 0;

#update documentation

# try {
# 	$ses = New-PsSession -EA Stop;
# } catch {
# 	$credential = Get-Credential -Message "input local credentials for new local session"
# 	$ses = New-PsSession -Credential $credential;
# }
$docsPth = "$PSScriptRoot\docs" 

# Invoke-Command -Session $ses -ScriptBlock {
	# $moduleName = $Using:moduleName 
	# $modulePath = $Using:modulePath
	# $docsPth = $Using:docsPth 
	mkdir $docsPth -EA 0;
	Remove-Module $moduleName -force -EA 0;
	Import-Module "$modulePath\$moduleName.psm1" -force;
	#import any classes so they are recognized and do it twice to resolve classes with dependencies
	$classPth = "$modulePath\classes";
	$classPth | Get-ChildItem | ForEach-Object { Import-Module $_.Fullname -force -EA 0;}
	$classPth | Get-ChildItem | ForEach-Object { Import-Module $_.Fullname -force;}
	# Remove old markdown files
	"$docsPth\commands" | Get-ChildItem -Filter '*.md' | Remove-Item -Force;
	Remove-Item -Path "$docsPth\ReleaseNotes.md"
	New-MarkdownHelp -module $moduleName -Force -OutputFolder "$docsPth\commands";
	
	
	
	# Add Online Versions to each commands markdown file
	$indexFile = "$docsPth\commands\index.md"
	$mkdocsYml = "$PSScriptRoot\mkdocs.yml";
	$mkdocs = @"
site_name: EzFirewallMgmt
nav:
  - Home: index.md
  - About: about_EzFirewallMgmt.md
  - Release Notes: ReleaseNotes.md
  - Commands: 
    - 'Index': 'commands/index.md'
"@
	$mkdocs += "`n";
	$index = "# EzFirewallMgmt`n`n"
	Get-ChildItem "$docsPth\commands" | Where-Object name -NotMatch 'index' | Foreach-Object {
		#add online version
		$name = $_.Name;
		$baseName = $_.BaseName
		$file = $_.FullName;
		$link = "https://EzFirewallMgmt.readthedocs.io/en/latest/commands/$basename";
		#insert in onlineVersion at top
		$content = Get-Content $file;
		$onlineStr = ($content | Select-String "online version:*").tostring();
		$newOnlineStr = "$onlineStr $link";
		$content = $content.replace($onlineStr,$newOnlineStr);
		$links = ($content | Select-String -Pattern "\[*\]\(\)");
		$links | ForEach-Object {
			$str = $_.toString();
			if ( ($str.split("`[").split("`]").split("-")[2]) -match "NetFirewallRule" ) {
				$baseLink = "https://docs.microsoft.com/en-us/powershell/module/netsecurity"
			} else {
				$baseLink = "https://EzFirewallMgmt.readthedocs.io/en/latest/commands"
			}
			$linkName = $str.split("`[").split("`]")[1];
			$linkUri = "$baseLink/$linkName";
			$newStr = "[$linkName]($linkUri)"
			$content = $content.Replace($str,$newStr);
		}
		Set-Content -Path $file -Value $content;
		
		#Update commands index
		$index += "## [$basename]($name)`n`n"
		#Update readthedocs nav index
		$mkdocs += "    - '$basename': 'commands/$name'`n";
		#maybe later add something that converts any functions in .link to related links

	}

	$mkdocs += "`ntheme: readthedocs"

	Set-Content $mkdocsYml -value $mkdocs;
	Set-Content $indexFile -Value $index;

	try {
		New-ExternalHelp -Path $docsPth -OutputPath "$docsPth\en-us" -Force;
		New-ExternalHelp -Path "$docsPth\commands" -OutputPath "$docsPth\en-us" -Force;
	} catch {
		Write-Warning "There was an error creating the external help from the markdown. $($error) Removing current external help and trying again"
		Remove-Item -Force -Recurse "$docsPth\en-us";
		mkdir "$docsPth\en-us"
		New-ExternalHelp -Path $docsPth -OutputPath "$docsPth\en-us" -EA 0 -Force;
		New-ExternalHelp -Path "$docsPth\commands" -OutputPath "$docsPth\en-us" -Force;
	}
# }

# $ses | Remove-PsSession;

$PublicFunctions = Get-ChildItem "$modulePath\Public" -Recurse -Filter '*.ps1' -EA 0;
$Classes = Get-ChildItem "$modulePath\Classes" -Recurse -Filter '*.ps1' -EA 0;
$PrivateFunctions = Get-ChildItem "$modulePath\Private" -Recurse -Filter '*.ps1' -EA 0;
# mkdir "$PSSCriptRoot\ModuleBuild" -EA 0;
$buildPth = "$Home\ModuleBuild\$moduleName";
$moduleFile = "$buildPth\$moduleName.psm1";

# Create the build output folder
if (Test-Path $buildPth) {
	Remove-Item $buildPth -force -recurse;
}
mkdir $buildPth | Out-Null;

New-Item $moduleFile -Force | Out-Null;
Copy-Item "$docsPth\en-us" "$buildPth\en-us" -Recurse -Exclude '*.md';
Add-Content -Path $moduleFile -Value "`$PSModuleRoot = `$PSScriptRoot";
if ((Get-ChildItem "$modulePath\lib").count -gt 0) {
	Copy-Item "$modulePath\lib" "$buildPth\lib" -Recurse;
	Add-Content -Path $moduleFile -Value "`$lib = `"`$PSModuleRoot\lib`"";
}
if ((Get-ChildItem "$modulePath\bin").count -gt 0) {
	Copy-Item "$modulePath\bin" "$buildPth\bin" -Recurse;
	Add-Content -Path $moduleFile -Value "`$bin = `"`$PSModuleRoot\bin`"";
}
# Copy-Item "$modulePath\tools" "$buildPth\tools" -Recurse;
Add-Content -Path $moduleFile -Value "`$tools = `"`$PSModuleRoot\tools`"";


#Build the psm1 file


#Add Classes
if ($null -ne $Classes) {

	$Classes | ForEach-Object {
		Add-Content -Path $moduleFile -Value (Get-Content $_.FullName);
	}

}
# Add-PublicFunctions
Add-Content -Path $moduleFile -Value $heading
        # $PublicFunctions;
        $PublicFunctions | ForEach-Object { # Replace the comment block with external help link
            $rawContent = (Get-Content $_.FullName -Raw);
            $commentStartIdx = $rawContent.indexOf('<#');
            if ($commentStartIdx -ge 0) {
                $commentEndIdx = $rawContent.IndexOf('#>');
                $commentLength = $commentEndIdx - ($commentStartIdx-2); #-2 to adjust for the # in front of > and the index starting at 0
                $comment = $rawContent.Substring($commentStartIdx,$commentLength);
                $newComment = "# .ExternalHelp $moduleName-help.xml"
                $Function = $rawContent.Replace($comment,$newComment);
            } else {
                $Function = $rawContent;
            }
            Add-Content -Path $moduleFile -Value $Function
        }
#Add Private Functions
if ($null -ne $PrivateFunctions) {
	$PrivateFunctions | ForEach-Object {
		Add-Content -Path $moduleFile -Value (Get-Content $_.FullName);            
	}
}

#Update The Manifest

$manifest = "$PSScriptRoot\$moduleName\$moduleName.psd1"
$cur = test-ModuleManifest -Path $manifest;

[System.Version]$oldVer = (Test-ModuleManifest $manifest).Version
$verArgs = New-Object System.Collections.Generic.list[system.object];
$verArgs.Add($oldVer.Major)
$verArgs.Add($oldVer.Minor)
$verArgs.Add($oldVer.Build)
$verArgs.Add(($oldVer.Revision + 1))
if($verArgs[-1] -eq 0) {$verArgs[-1] += 1}
$newVer = New-Object version -ArgumentList $verArgs;
$releaseNotes = "`n# $newVer`n`n`t$releaseNote`n$($cur.ReleaseNotes)"

$manifestBlob = @{
	path = $manifest;
	ReleaseNotes = $releaseNotes
	ModuleVersion = $newVer
	RootModule = "$moduleName.psm1"
	FunctionsToExport = $PublicFunctions.BaseName
	LicenseUri = "https://github.com/darksidemilk/EzFirewallMgmt/blob/master/LICENSE"
	ProjectUri = "https://github.com/darksidemilk/EzFirewallMgmt"
	HelpInfoUri = "https://EzFirewallMgmt.readthedocs.io/en/latest/"
	Tags = "Firewall","Windows-Firewall","Windows-control-panel","Windows-Defender","Firewall-Management","Admin-Tools","Security","networkSecurity","network"
	PowershellVersion = '3.0'
}

Update-ModuleManifest @manifestBlob


Copy-Item $manifest "$buildPth\$moduleName.psd1";

#create release notes markdown
Set-Content -Path "$docsPth\ReleaseNotes.md" -value ((Test-ModuleManifest $manifest).ReleaseNotes)

#Sign the built module file if cert exists
$cert = (Get-ChildItem cert:\CurrentUser\My -CodeSigningCert)

if ($null -ne $cert) {
	if ($null -ne $cert.count) {
		if ($cert.count -gt 1) {
			$i = 1;
			$cert | ForEach-Object {
				"Cert $i : $($_.Subject)" | Out-Host;
				$i++;
			}
			$selection = Read-Host -Prompt "Multiple code signing certs exist, Which cert would you like to use? Please input cert number";
			$cert = $cert[($selection-1)];
		}
	}
	Set-AuthenticodeSignature $moduleFile -Certificate $cert -IncludeChain All -Force;
}