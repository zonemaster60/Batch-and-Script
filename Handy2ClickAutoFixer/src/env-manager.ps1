#requires -version 5.1

<#
.SYNOPSIS
  Backup, edit, and restore Windows environment variables.

.DESCRIPTION
  Exports User and/or Machine environment variables to a JSON file. Supports an
  edit workflow (open JSON in editor), plus restore/diff/validate and PATH-focused
  utilities.

  This script uses .NET's [Environment] API, which persists variables at the
  proper scope.

.PARAMETER Backup
  Create a backup JSON file.

.PARAMETER Restore
  Restore from a backup JSON file.

.PARAMETER Edit
  Opens a backup JSON for editing (creates one if missing) and optionally opens
  a PATH-only "sidecar" file you can edit line-by-line.

.PARAMETER List
  Print current environment variables (optionally as JSON).

.PARAMETER Diff
  Compare current environment variables vs a backup JSON.

.PARAMETER Validate
  Validate that a JSON backup is well-formed.

.PARAMETER Path
  Path to the backup JSON file.

.PARAMETER Scopes
  Which scopes to backup/restore: user, machine, or both.

.PARAMETER Mode
  Restore behavior:
    merge - only set keys present in backup
    full  - also remove keys not present in backup (within selected scopes)

.PARAMETER Force
  Do not prompt for confirmation.

.PARAMETER Editor
  Editor command to use for -Edit (optional). Examples:
    notepad
    code

.PARAMETER AsJson
  For -List: output JSON instead of a table.

.PARAMETER PathScope
  For PATH helpers: which PATH scope (user/machine).

.PARAMETER PathFile
  Path to a path-entries text file (one entry per line).

.PARAMETER PathExport
  Export PATH entries (one per line) to -PathFile.

.PARAMETER PathImport
  Import PATH entries from -PathFile and apply to that scope.

.PARAMETER Normalize
  For PATH import/export: normalize + de-duplicate entries.

.EXAMPLE
  # Backup both scopes
  .\env-manager.ps1 -Backup -Path .\backup.json -Scopes both

.EXAMPLE
  # Edit JSON in an editor (creates backup if missing)
  .\env-manager.ps1 -Edit -Path .\backup.json -Scopes both -Editor notepad

.EXAMPLE
  # Export PATH entries to a text file
  .\env-manager.ps1 -PathExport -PathScope user -PathFile .\path.user.txt -Normalize

.EXAMPLE
  # Import PATH entries from a text file (applies immediately)
  .\env-manager.ps1 -PathImport -PathScope user -PathFile .\path.user.txt -Normalize

.EXAMPLE
  # Restore only keys present in backup (safer)
  .\env-manager.ps1 -Restore -Path .\backup.json -Scopes both -Mode merge

.EXAMPLE
  # Full restore (dangerous): also delete keys missing from backup
  .\env-manager.ps1 -Restore -Path .\backup.json -Scopes both -Mode full

.EXAMPLE
  # Diff current env vars vs a backup
  .\env-manager.ps1 -Diff -Path .\backup.json -Scopes both
#>

[CmdletBinding(DefaultParameterSetName = 'Help', SupportsShouldProcess = $true, ConfirmImpact = 'High')]
param(
  [Parameter(ParameterSetName = 'Backup', Mandatory = $true)]
  [switch] $Backup,

  [Parameter(ParameterSetName = 'Restore', Mandatory = $true)]
  [switch] $Restore,

  [Parameter(ParameterSetName = 'Edit', Mandatory = $true)]
  [switch] $Edit,

  [Parameter(ParameterSetName = 'List', Mandatory = $true)]
  [switch] $List,

  [Parameter(ParameterSetName = 'Diff', Mandatory = $true)]
  [switch] $Diff,

  [Parameter(ParameterSetName = 'Validate', Mandatory = $true)]
  [switch] $Validate,

  [Parameter(ParameterSetName = 'PathExport', Mandatory = $true)]
  [switch] $PathExport,

  [Parameter(ParameterSetName = 'PathImport', Mandatory = $true)]
  [switch] $PathImport,

  [Parameter(ParameterSetName = 'Menu', Mandatory = $true)]
  [switch] $Menu,

  [Parameter(Mandatory = $true, ParameterSetName = 'Backup')]
  [Parameter(Mandatory = $true, ParameterSetName = 'Restore')]
  [Parameter(Mandatory = $true, ParameterSetName = 'Edit')]
  [Parameter(Mandatory = $true, ParameterSetName = 'Diff')]
  [Parameter(Mandatory = $true, ParameterSetName = 'Validate')]
  [string] $Path,

  [Parameter(ParameterSetName = 'Backup')]
  [Parameter(ParameterSetName = 'Restore')]
  [Parameter(ParameterSetName = 'Edit')]
  [Parameter(ParameterSetName = 'Diff')]
  [ValidateSet('user', 'machine', 'both')]
  [string] $Scopes = 'both',

  [Parameter(ParameterSetName = 'Restore')]
  [ValidateSet('merge', 'full')]
  [string] $Mode = 'merge',

  [Parameter(ParameterSetName = 'Restore')]
  [switch] $Force,

  [Parameter(ParameterSetName = 'Edit')]
  [string] $Editor,

  [Parameter(ParameterSetName = 'List')]
  [ValidateSet('user', 'machine', 'both')]
  [string] $ListScopes = 'both',

  [Parameter(ParameterSetName = 'List')]
  [switch] $AsJson,

  [Parameter(ParameterSetName = 'PathExport')]
  [Parameter(ParameterSetName = 'PathImport')]
  [ValidateSet('user', 'machine')]
  [string] $PathScope = 'user',

  [Parameter(ParameterSetName = 'PathExport', Mandatory = $true)]
  [Parameter(ParameterSetName = 'PathImport', Mandatory = $true)]
  [string] $PathFile,

  [Parameter(ParameterSetName = 'PathExport')]
  [Parameter(ParameterSetName = 'PathImport')]
  [switch] $Normalize
)

function Test-IsAdmin {
  $id = [Security.Principal.WindowsIdentity]::GetCurrent()
  $p = New-Object Security.Principal.WindowsPrincipal($id)
  return $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Read-EnvMap {
  param(
    [Parameter(Mandatory = $true)] [ValidateSet('User', 'Machine')] [string] $Scope
  )

  $out = @{}
  $vars = [Environment]::GetEnvironmentVariables($Scope)
  foreach ($k in $vars.Keys) {
    $name = [string]$k
    $out[$name] = [string]$vars[$k]
  }

  return $out
}

function New-BackupObject {
  param(
    [Parameter(Mandatory = $true)] [ValidateSet('user', 'machine', 'both')] [string] $Scopes
  )

  $metaObj = [ordered]@{
    createdAt = (Get-Date).ToString('o')
    host = $env:COMPUTERNAME
    user = $env:USERNAME
    source = 'env-manager.ps1'
    notes = ''
  }

  $backup = [ordered]@{
    type = 'windows-env-backup-v1'
    meta = $metaObj
    user = @{}
    machine = @{}
  }

  if ($Scopes -eq 'user' -or $Scopes -eq 'both') {
    $backup.user = Read-EnvMap -Scope User
  }

  if ($Scopes -eq 'machine' -or $Scopes -eq 'both') {
    $backup.machine = Read-EnvMap -Scope Machine
  }

  return $backup
}

function Write-BackupJson {
  param(
    [Parameter(Mandatory = $true)] [string] $Path,
    [Parameter(Mandatory = $true)] [ValidateSet('user', 'machine', 'both')] [string] $Scopes
  )

  $obj = New-BackupObject -Scopes $Scopes

  $dir = Split-Path -Parent $Path
  if ($dir -and -not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Path $dir | Out-Null
  }

  $json = $obj | ConvertTo-Json -Depth 10
  Set-Content -LiteralPath $Path -Value $json -Encoding UTF8

  Write-Host "Wrote backup: $Path" -ForegroundColor Green
}

function Read-BackupJson {
  param(
    [Parameter(Mandatory = $true)] [string] $Path
  )

  if (-not (Test-Path -LiteralPath $Path)) {
    throw "Backup file not found: $Path"
  }

  $raw = Get-Content -LiteralPath $Path -Raw -ErrorAction Stop
  $b = $raw | ConvertFrom-Json -ErrorAction Stop

  if (-not $b -or $b.type -ne 'windows-env-backup-v1') {
    throw 'Not a recognized backup format (expected type windows-env-backup-v1).'
  }

  return $b
}

function ConvertTo-Hashtable {
  param([Parameter(Mandatory = $true)] $Obj)

  $ht = @{}
  if (-not $Obj) { return $ht }

  # Allow "comments" arrays, etc. Only interpret PSObject properties as keys.
  foreach ($p in $Obj.PSObject.Properties) {
    if ($p.Name -eq '__comment' -or $p.Name -eq '__comments') { continue }
    if ($p.Name -eq 'meta' -or $p.Name -eq 'type') { continue }
    $ht[$p.Name] = [string]$p.Value
  }

  return $ht
}

function Set-EnvVarsFromMap {
  param(
    [Parameter(Mandatory = $true)] [hashtable] $Map,
    [Parameter(Mandatory = $true)] [ValidateSet('User', 'Machine')] [string] $Scope
  )

  foreach ($k in $Map.Keys) {
    [Environment]::SetEnvironmentVariable([string]$k, [string]$Map[$k], $Scope)
  }
}

function Remove-EnvVarsNotInMap {
  param(
    [Parameter(Mandatory = $true)] [hashtable] $Map,
    [Parameter(Mandatory = $true)] [ValidateSet('User', 'Machine')] [string] $Scope
  )

  $current = [Environment]::GetEnvironmentVariables($Scope)
  foreach ($k in $current.Keys) {
    $name = [string]$k
    if (-not $Map.ContainsKey($name)) {
      [Environment]::SetEnvironmentVariable($name, $null, $Scope)
    }
  }
}

function Broadcast-EnvChange {
  try {
    Add-Type -Namespace Win32 -Name Native -MemberDefinition @"
      [System.Runtime.InteropServices.DllImport(\"user32.dll\", SetLastError=true, CharSet=System.Runtime.InteropServices.CharSet.Auto)]
      public static extern System.IntPtr SendMessageTimeout(System.IntPtr hWnd, int Msg, System.IntPtr wParam, string lParam, int fuFlags, int uTimeout, out System.IntPtr lpdwResult);
"@

    $HWND_BROADCAST = [IntPtr]0xffff
    $WM_SETTINGCHANGE = 0x1A
    $result = [IntPtr]::Zero

    # SMTO_ABORTIFHUNG = 0x2
    [void][Win32.Native]::SendMessageTimeout($HWND_BROADCAST, $WM_SETTINGCHANGE, [IntPtr]::Zero, 'Environment', 2, 5000, [ref]$result)
  } catch {
    # best-effort
  }
}

function Normalize-WindowsPathEntry {
  param([Parameter(Mandatory = $true)] [string] $Entry)

  $s = $Entry.Trim()
  if (-not $s) { return '' }

  $s = $s -replace '/', '\\'

  # keep C:\ but trim other trailing backslashes
  if ($s -match '^[A-Za-z]:\\$') { return $s }
  $s = $s -replace '\\+$', ''
  return $s
}

function Split-PathEntries {
  param([string] $Value)

  return @(
    ([string]$(if ($null -ne $Value) { $Value } else { '' })).Split(';') |
      ForEach-Object { $_.Trim() } |
      Where-Object { $_ }
  )
}

function Unique-PreserveOrder {
  param(
    [Parameter(Mandatory = $true)] [string[]] $Values
  )

  $seen = New-Object 'System.Collections.Generic.HashSet[string]'
  $out = New-Object 'System.Collections.Generic.List[string]'

  foreach ($v in $Values) {
    $k = $v.ToLowerInvariant()
    if ($seen.Add($k)) {
      [void]$out.Add($v)
    }
  }

  return ,$out.ToArray()
}

function Export-PathFile {
  param(
    [Parameter(Mandatory = $true)] [ValidateSet('user', 'machine')] [string] $Scope,
    [Parameter(Mandatory = $true)] [string] $PathFile,
    [switch] $Normalize
  )

  $psScope = if ($Scope -eq 'machine') { 'Machine' } else { 'User' }
  $raw = [Environment]::GetEnvironmentVariable('PATH', $psScope)
  $entries = Split-PathEntries -Value $raw

  if ($Normalize) {
    $entries = $entries | ForEach-Object { Normalize-WindowsPathEntry -Entry $_ } | Where-Object { $_ }
    $entries = Unique-PreserveOrder -Values $entries
  }

  $dir = Split-Path -Parent $PathFile
  if ($dir -and -not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Path $dir | Out-Null
  }

  Set-Content -LiteralPath $PathFile -Value ($entries -join "`r`n") -Encoding UTF8
  Write-Host "Wrote PATH file: $PathFile" -ForegroundColor Green
}

function Import-PathFile {
  param(
    [Parameter(Mandatory = $true)] [ValidateSet('user', 'machine')] [string] $Scope,
    [Parameter(Mandatory = $true)] [string] $PathFile,
    [switch] $Normalize
  )

  if (-not (Test-Path -LiteralPath $PathFile)) {
    throw "PATH file not found: $PathFile"
  }

  $lines = (Get-Content -LiteralPath $PathFile) | ForEach-Object { $_.Trim() } | Where-Object { $_ }
  $entries = @($lines)

  if ($Normalize) {
    $entries = $entries | ForEach-Object { Normalize-WindowsPathEntry -Entry $_ } | Where-Object { $_ }
    $entries = Unique-PreserveOrder -Values $entries
  }

  $joined = ($entries -join ';')
  $psScope = if ($Scope -eq 'machine') { 'Machine' } else { 'User' }

  if ($Scope -eq 'machine' -and -not (Test-IsAdmin)) {
    Write-Warning 'Updating MACHINE PATH usually requires running as Administrator.'
  }

  if ($PSCmdlet.ShouldProcess("PATH ($Scope)", "Set PATH from $PathFile")) {
    [Environment]::SetEnvironmentVariable('PATH', $joined, $psScope)
    Broadcast-EnvChange
  }

  Write-Host "Applied PATH for $Scope." -ForegroundColor Green
}

function Get-BackupMaps {
  param(
    [Parameter(Mandatory = $true)] $Backup
  )

  return @{
    user = ConvertTo-Hashtable -Obj $Backup.user
    machine = ConvertTo-Hashtable -Obj $Backup.machine
  }
}

function Get-Diff {
  param(
    [Parameter(Mandatory = $true)] [hashtable] $Desired,
    [Parameter(Mandatory = $true)] [hashtable] $Current
  )

  $keys = New-Object 'System.Collections.Generic.HashSet[string]'
  foreach ($k in $Desired.Keys) { [void]$keys.Add([string]$k) }
  foreach ($k in $Current.Keys) { [void]$keys.Add([string]$k) }

  $out = @()

  foreach ($k in ($keys | Sort-Object)) {
    $hasDesired = $Desired.ContainsKey($k)
    $hasCurrent = $Current.ContainsKey($k)

    if (-not $hasDesired -and $hasCurrent) {
      $out += [pscustomobject]@{ Key = $k; Change = 'Remove'; Current = $Current[$k]; Desired = $null }
      continue
    }

    if ($hasDesired -and -not $hasCurrent) {
      $out += [pscustomobject]@{ Key = $k; Change = 'Add'; Current = $null; Desired = $Desired[$k] }
      continue
    }

    if ($hasDesired -and $hasCurrent -and [string]$Desired[$k] -ne [string]$Current[$k]) {
      $out += [pscustomobject]@{ Key = $k; Change = 'Update'; Current = $Current[$k]; Desired = $Desired[$k] }
      continue
    }
  }

  return $out
}

function Confirm-Restore {
  param(
    [Parameter(Mandatory = $true)] [ValidateSet('merge', 'full')] [string] $Mode,
    [Parameter(Mandatory = $true)] [ValidateSet('user', 'machine', 'both')] [string] $Scopes,
    [Parameter(Mandatory = $true)] [string] $Path,
    [Parameter(Mandatory = $true)] [hashtable] $Maps
  )

  if ($Mode -eq 'merge') {
    $msg = "About to RESTORE (merge) from: $Path`nScopes: $Scopes`nThis will set keys present in the backup (does NOT delete extras)."
    return $PSCmdlet.ShouldContinue($msg, 'Confirm restore?')
  }

  $dangerMsg = "About to RESTORE (FULL) from: $Path`nScopes: $Scopes`nFULL restore will also DELETE keys not present in the backup for selected scopes."
  if (-not $PSCmdlet.ShouldContinue($dangerMsg, 'Confirm FULL restore?')) { return $false }

  # Optional extra: show approximate delete counts.
  if ($Scopes -eq 'user' -or $Scopes -eq 'both') {
    $currentUser = Read-EnvMap -Scope User
    $diffUser = Get-Diff -Desired $Maps.user -Current $currentUser
    $removeCount = ($diffUser | Where-Object { $_.Change -eq 'Remove' }).Count
    if ($removeCount -gt 0) {
      Write-Warning ("FULL restore would remove {0} USER keys not present in backup." -f $removeCount)
    }
  }

  if ($Scopes -eq 'machine' -or $Scopes -eq 'both') {
    $currentMachine = Read-EnvMap -Scope Machine
    $diffMachine = Get-Diff -Desired $Maps.machine -Current $currentMachine
    $removeCount = ($diffMachine | Where-Object { $_.Change -eq 'Remove' }).Count
    if ($removeCount -gt 0) {
      Write-Warning ("FULL restore would remove {0} SYSTEM keys not present in backup." -f $removeCount)
    }
  }

  return $PSCmdlet.ShouldContinue('Proceed with FULL restore now?', 'Last chance')
}

function Restore-FromBackup {
  param(
    [Parameter(Mandatory = $true)] [string] $Path,
    [Parameter(Mandatory = $true)] [ValidateSet('user', 'machine', 'both')] [string] $Scopes,
    [Parameter(Mandatory = $true)] [ValidateSet('merge', 'full')] [string] $Mode,
    [switch] $Force
  )

  $b = Read-BackupJson -Path $Path
  $maps = Get-BackupMaps -Backup $b

  if (($Scopes -eq 'machine' -or $Scopes -eq 'both') -and -not (Test-IsAdmin)) {
    Write-Warning 'Restoring MACHINE scope may require running PowerShell as Administrator.'
  }

  if (-not $Force) {
    if (-not (Confirm-Restore -Mode $Mode -Scopes $Scopes -Path $Path -Maps $maps)) {
      Write-Host 'Cancelled.' -ForegroundColor Yellow
      return
    }
  }

  if ($Scopes -eq 'user' -or $Scopes -eq 'both') {
    if ($PSCmdlet.ShouldProcess('User environment', "Restore ($Mode)")) {
      Write-Host 'Applying USER environment variables...' -ForegroundColor Cyan
      Set-EnvVarsFromMap -Map $maps.user -Scope User
      if ($Mode -eq 'full') { Remove-EnvVarsNotInMap -Map $maps.user -Scope User }
    }
  }

  if ($Scopes -eq 'machine' -or $Scopes -eq 'both') {
    if ($PSCmdlet.ShouldProcess('Machine environment', "Restore ($Mode)")) {
      Write-Host 'Applying SYSTEM environment variables...' -ForegroundColor Cyan
      Set-EnvVarsFromMap -Map $maps.machine -Scope Machine
      if ($Mode -eq 'full') { Remove-EnvVarsNotInMap -Map $maps.machine -Scope Machine }
    }
  }

  Broadcast-EnvChange
  Write-Host 'Done.' -ForegroundColor Green
}

function Show-Env {
  param(
    [Parameter(Mandatory = $true)] [ValidateSet('user', 'machine', 'both')] [string] $Scopes,
    [switch] $AsJson
  )

  $obj = New-BackupObject -Scopes $Scopes

  if ($AsJson) {
    $obj | ConvertTo-Json -Depth 10
    return
  }

  $rows = @()

  if ($Scopes -eq 'user' -or $Scopes -eq 'both') {
    foreach ($k in ($obj.user.Keys | Sort-Object)) {
      $rows += [pscustomobject]@{ Scope = 'User'; Key = $k; Value = $obj.user[$k] }
    }
  }

  if ($Scopes -eq 'machine' -or $Scopes -eq 'both') {
    foreach ($k in ($obj.machine.Keys | Sort-Object)) {
      $rows += [pscustomobject]@{ Scope = 'Machine'; Key = $k; Value = $obj.machine[$k] }
    }
  }

  $rows | Format-Table -AutoSize
}

function Show-Diff {
  param(
    [Parameter(Mandatory = $true)] [string] $Path,
    [Parameter(Mandatory = $true)] [ValidateSet('user', 'machine', 'both')] [string] $Scopes
  )

  $b = Read-BackupJson -Path $Path
  $maps = Get-BackupMaps -Backup $b

  $out = @()

  if ($Scopes -eq 'user' -or $Scopes -eq 'both') {
    $currentUser = Read-EnvMap -Scope User
    $diffUser = Get-Diff -Desired $maps.user -Current $currentUser
    foreach ($d in $diffUser) {
      $out += [pscustomobject]@{ Scope = 'User'; Key = $d.Key; Change = $d.Change; Current = $d.Current; Desired = $d.Desired }
    }
  }

  if ($Scopes -eq 'machine' -or $Scopes -eq 'both') {
    $currentMachine = Read-EnvMap -Scope Machine
    $diffMachine = Get-Diff -Desired $maps.machine -Current $currentMachine
    foreach ($d in $diffMachine) {
      $out += [pscustomobject]@{ Scope = 'Machine'; Key = $d.Key; Change = $d.Change; Current = $d.Current; Desired = $d.Desired }
    }
  }

  if ($out.Count -eq 0) {
    Write-Host 'No differences.' -ForegroundColor Green
    return
  }

  $out | Sort-Object Scope, Change, Key | Format-Table -AutoSize
}

function Validate-Backup {
  param([Parameter(Mandatory = $true)] [string] $Path)

  $b = Read-BackupJson -Path $Path

  # Ensure user/machine are objects if present.
  if ($null -ne $b.user -and -not ($b.user -is [psobject])) {
    throw 'Backup.user must be an object (map of key->value).'
  }
  if ($null -ne $b.machine -and -not ($b.machine -is [psobject])) {
    throw 'Backup.machine must be an object (map of key->value).'
  }

  Write-Host "OK: $Path" -ForegroundColor Green
  if ($b.meta -and $b.meta.createdAt) {
    Write-Host ("CreatedAt: {0}" -f $b.meta.createdAt)
  }
}

function Open-Editor {
  param(
    [Parameter(Mandatory = $true)] [string] $Path,
    [string] $Editor
  )

  if ($Editor) {
    Start-Process -FilePath $Editor -ArgumentList @($Path) | Out-Null
    return
  }

  if (Get-Command code -ErrorAction SilentlyContinue) {
    Start-Process -FilePath 'code' -ArgumentList @($Path) | Out-Null
  } else {
    Start-Process -FilePath 'notepad.exe' -ArgumentList @($Path) | Out-Null
  }
}

function Read-MenuChoice {
  param([Parameter(Mandatory = $true)] [string] $Prompt)

  Write-Host ''
  $inputValue = Read-Host $Prompt
  if ($null -eq $inputValue) { return '' }
  return ([string]$inputValue).Trim()
}

function Get-ScriptDir {
  $p = $MyInvocation.MyCommand.Path
  if ($p) { return (Split-Path -Parent $p) }
  return (Get-Location).Path
}

function Get-MenuConfigPath {
  $dir = Get-ScriptDir
  return (Join-Path $dir 'env-manager.config.json')
}

function Load-MenuConfig {
  $cfgPath = Get-MenuConfigPath
  if (-not (Test-Path -LiteralPath $cfgPath)) { return $null }

  try {
    $raw = Get-Content -LiteralPath $cfgPath -Raw -ErrorAction Stop
    return ($raw | ConvertFrom-Json -ErrorAction Stop)
  } catch {
    return $null
  }
}

function Save-MenuConfig {
  param(
    [Parameter(Mandatory = $true)] [string] $BackupPath,
    [Parameter(Mandatory = $true)] [string] $PathUserFile,
    [Parameter(Mandatory = $true)] [string] $PathMachineFile
  )

  $cfgPath = Get-MenuConfigPath
  $obj = [ordered]@{
    type = 'env-manager-menu-config-v1'
    updatedAt = (Get-Date).ToString('o')
    backupPath = $BackupPath
    pathUserFile = $PathUserFile
    pathMachineFile = $PathMachineFile
  }

  $json = $obj | ConvertTo-Json -Depth 5
  Set-Content -LiteralPath $cfgPath -Value $json -Encoding UTF8
  Write-Host "Saved menu config: $cfgPath" -ForegroundColor Green
}

function Resolve-MenuPath {
  param(
    [Parameter(Mandatory = $true)] [string] $InputPath,
    [Parameter(Mandatory = $true)] [string] $BaseDir
  )

  $p = $InputPath.Trim()
  if (-not $p) { return '' }

  if ([IO.Path]::IsPathRooted($p)) { return $p }
  return (Join-Path $BaseDir $p)
}

function Invoke-Menu {
  param([string] $Editor)

  $dir = Get-ScriptDir

  $backupPath = Join-Path $dir 'backup.json'
  $pathUserFile = Join-Path $dir 'path.user.txt'
  $pathMachineFile = Join-Path $dir 'path.machine.txt'

  $cfg = Load-MenuConfig
  if ($cfg -and $cfg.type -eq 'env-manager-menu-config-v1') {
    if ($cfg.backupPath) { $backupPath = Resolve-MenuPath -InputPath ([string]$cfg.backupPath) -BaseDir $dir }
    if ($cfg.pathUserFile) { $pathUserFile = Resolve-MenuPath -InputPath ([string]$cfg.pathUserFile) -BaseDir $dir }
    if ($cfg.pathMachineFile) { $pathMachineFile = Resolve-MenuPath -InputPath ([string]$cfg.pathMachineFile) -BaseDir $dir }
  }

  while ($true) {
    Clear-Host
    Write-Host 'Windows Env Manager' -ForegroundColor Cyan
    Write-Host '===================' -ForegroundColor Cyan
    Write-Host "Backup file:      $backupPath"
    Write-Host "PATH user file:   $pathUserFile"
    Write-Host "PATH system file: $pathMachineFile"
    Write-Host ''
    Write-Host '1) Backup (user/machine/both)'
    Write-Host '2) Edit backup.json (and export PATH sidecars)'
    Write-Host '3) Validate backup.json'
    Write-Host '4) Diff current vs backup.json'
    Write-Host '5) Restore (merge) from backup.json'
    Write-Host '6) Restore (full) from backup.json  (DANGEROUS)'
    Write-Host '7) Export PATH entries to file'
    Write-Host '8) Import PATH entries from file'
    Write-Host '9) List current env vars'
    Write-Host '10) Change active file paths'
    Write-Host '11) Save file paths as defaults'
    Write-Host '12) Open script folder'
    Write-Host '13) Reset paths to defaults'
    Write-Host '14) Reset + forget saved defaults'
    Write-Host '0) Exit'

    $choice = Read-MenuChoice -Prompt 'Select an option'

    try {
      switch ($choice) {
        '1' {
          $scopes = Read-MenuChoice -Prompt 'Scopes (user/machine/both)'
          if (-not $scopes) { $scopes = 'both' }
          Write-BackupJson -Path $backupPath -Scopes $scopes
          Read-MenuChoice -Prompt 'Press Enter to continue' | Out-Null
        }
        '2' {
          if (-not (Test-Path -LiteralPath $backupPath)) {
            Write-Host "Backup missing; creating $backupPath" -ForegroundColor Yellow
            Write-BackupJson -Path $backupPath -Scopes both
          }

          Open-Editor -Path $backupPath -Editor $Editor

          Export-PathFile -Scope user -PathFile $pathUserFile -Normalize
          Export-PathFile -Scope machine -PathFile $pathMachineFile -Normalize

          Write-Host ''
          Write-Host 'JSON + PATH files opened/exported.' -ForegroundColor Green
          Write-Host 'When done editing:' -ForegroundColor Yellow
          Write-Host "  Restore: .\\env-manager.ps1 -Restore -Path \"$backupPath\" -Scopes both -Mode merge"
          Write-Host "  Apply PATH user:   .\\env-manager.ps1 -PathImport -PathScope user -PathFile \"$pathUserFile\" -Normalize"
          Write-Host "  Apply PATH system: .\\env-manager.ps1 -PathImport -PathScope machine -PathFile \"$pathMachineFile\" -Normalize"

          Read-MenuChoice -Prompt 'Press Enter to continue' | Out-Null
        }
        '3' {
          Validate-Backup -Path $backupPath
          Read-MenuChoice -Prompt 'Press Enter to continue' | Out-Null
        }
        '4' {
          Show-Diff -Path $backupPath -Scopes both
          Read-MenuChoice -Prompt 'Press Enter to continue' | Out-Null
        }
        '5' {
          Restore-FromBackup -Path $backupPath -Scopes both -Mode merge
          Read-MenuChoice -Prompt 'Press Enter to continue' | Out-Null
        }
        '6' {
          Restore-FromBackup -Path $backupPath -Scopes both -Mode full
          Read-MenuChoice -Prompt 'Press Enter to continue' | Out-Null
        }
        '7' {
          $scope = Read-MenuChoice -Prompt 'PATH scope (user/machine)'
          if (-not $scope) { $scope = 'user' }

          $file = if ($scope -eq 'machine') { $pathMachineFile } else { $pathUserFile }
          Export-PathFile -Scope $scope -PathFile $file -Normalize

          Read-MenuChoice -Prompt 'Press Enter to continue' | Out-Null
        }
        '8' {
          $scope = Read-MenuChoice -Prompt 'PATH scope (user/machine)'
          if (-not $scope) { $scope = 'user' }

          $file = if ($scope -eq 'machine') { $pathMachineFile } else { $pathUserFile }
          Import-PathFile -Scope $scope -PathFile $file -Normalize

          Read-MenuChoice -Prompt 'Press Enter to continue' | Out-Null
        }
        '9' {
          $asJson = Read-MenuChoice -Prompt 'Output as JSON? (y/N)'
          Show-Env -Scopes both -AsJson:($asJson -match '^(y|yes)$')
          Read-MenuChoice -Prompt 'Press Enter to continue' | Out-Null
        }
        '10' {
          $b = Read-MenuChoice -Prompt "Backup path (current: $backupPath)"
          if ($b) { $backupPath = Resolve-MenuPath -InputPath $b -BaseDir $dir }

          $pu = Read-MenuChoice -Prompt "PATH user file (current: $pathUserFile)"
          if ($pu) { $pathUserFile = Resolve-MenuPath -InputPath $pu -BaseDir $dir }

          $pm = Read-MenuChoice -Prompt "PATH system file (current: $pathMachineFile)"
          if ($pm) { $pathMachineFile = Resolve-MenuPath -InputPath $pm -BaseDir $dir }

          Write-Host 'Updated active paths.' -ForegroundColor Green
          Read-MenuChoice -Prompt 'Press Enter to continue' | Out-Null
        }
        '11' {
          Save-MenuConfig -BackupPath $backupPath -PathUserFile $pathUserFile -PathMachineFile $pathMachineFile
          Read-MenuChoice -Prompt 'Press Enter to continue' | Out-Null
        }
        '12' {
          Start-Process -FilePath 'explorer.exe' -ArgumentList @($dir) | Out-Null
          Read-MenuChoice -Prompt 'Press Enter to continue' | Out-Null
        }
        '13' {
          $backupPath = Join-Path $dir 'backup.json'
          $pathUserFile = Join-Path $dir 'path.user.txt'
          $pathMachineFile = Join-Path $dir 'path.machine.txt'
          Write-Host 'Reset active paths to defaults (session only).' -ForegroundColor Green
          Read-MenuChoice -Prompt 'Press Enter to continue' | Out-Null
        }
        '14' {
          $backupPath = Join-Path $dir 'backup.json'
          $pathUserFile = Join-Path $dir 'path.user.txt'
          $pathMachineFile = Join-Path $dir 'path.machine.txt'

          $cfgPath = Get-MenuConfigPath
          if (Test-Path -LiteralPath $cfgPath) {
            Remove-Item -LiteralPath $cfgPath -Force
            Write-Host "Deleted saved config: $cfgPath" -ForegroundColor Green
          } else {
            Write-Host 'No saved config found.' -ForegroundColor Yellow
          }

          Write-Host 'Reset active paths to defaults.' -ForegroundColor Green
          Read-MenuChoice -Prompt 'Press Enter to continue' | Out-Null
        }
        '0' { return }
        default {
          Write-Host 'Invalid option.' -ForegroundColor Yellow
          Start-Sleep -Milliseconds 800
        }
      }
    } catch {
      Write-Host ''
      $msg = if ($_.Exception -and $_.Exception.Message) { $_.Exception.Message } else { [string]$_ }
      Write-Host $msg -ForegroundColor Red
      Read-MenuChoice -Prompt 'Press Enter to continue' | Out-Null
    }
  }
}

switch ($PSCmdlet.ParameterSetName) {
  'Backup' {
    Write-BackupJson -Path $Path -Scopes $Scopes
  }
  'Restore' {
    Restore-FromBackup -Path $Path -Scopes $Scopes -Mode $Mode -Force:$Force
  }
  'Edit' {
    if (-not (Test-Path -LiteralPath $Path)) {
      Write-Host "Backup missing; creating $Path" -ForegroundColor Yellow
      Write-BackupJson -Path $Path -Scopes $Scopes
    }

    Open-Editor -Path $Path -Editor $Editor

    # Also offer a PATH editing file that is easier to work with.
    $pathUserFile = [IO.Path]::ChangeExtension($Path, $null) + '.path.user.txt'
    $pathMachineFile = [IO.Path]::ChangeExtension($Path, $null) + '.path.machine.txt'

    if ($Scopes -eq 'user' -or $Scopes -eq 'both') {
      Export-PathFile -Scope user -PathFile $pathUserFile -Normalize
      Write-Host "PATH (user) exported to: $pathUserFile" -ForegroundColor Yellow
    }

    if ($Scopes -eq 'machine' -or $Scopes -eq 'both') {
      Export-PathFile -Scope machine -PathFile $pathMachineFile -Normalize
      Write-Host "PATH (system) exported to: $pathMachineFile" -ForegroundColor Yellow
    }

    Write-Host "Edit JSON and/or PATH files, then apply:" -ForegroundColor Yellow
    Write-Host "  .\\env-manager.ps1 -Restore -Path \"$Path\" -Scopes $Scopes -Mode merge" -ForegroundColor Yellow
    Write-Host "  .\\env-manager.ps1 -PathImport -PathScope user -PathFile \"$pathUserFile\" -Normalize" -ForegroundColor Yellow
    Write-Host "  .\\env-manager.ps1 -PathImport -PathScope machine -PathFile \"$pathMachineFile\" -Normalize" -ForegroundColor Yellow
  }
  'List' {
    Show-Env -Scopes $ListScopes -AsJson:$AsJson
  }
  'Diff' {
    Show-Diff -Path $Path -Scopes $Scopes
  }
  'Validate' {
    Validate-Backup -Path $Path
  }
  'PathExport' {
    Export-PathFile -Scope $PathScope -PathFile $PathFile -Normalize:$Normalize
  }
  'PathImport' {
    Import-PathFile -Scope $PathScope -PathFile $PathFile -Normalize:$Normalize
  }
  'Menu' {
    Invoke-Menu -Editor $Editor
  }
  default {
    # If no parameter set matched (eg. no args), show menu.
    Invoke-Menu -Editor $Editor
  }
}
