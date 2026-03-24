ResetWindowsUpdateComponents.bat

Purpose
- Resets common Windows Update components, cache folders, policy keys, and network state.
- Stops the related services first, performs the reset steps, starts services again, then runs validation checks.

What the script does
1. Verifies that it is running as administrator.
2. Stops these services when present:
   - BITS (`bits`)
   - Windows Update (`wuauserv`)
   - Application Identity (`appidsvc`)
   - Cryptographic Services (`cryptsvc`)
3. Flushes DNS and deletes BITS queue files (`qmgr*.dat`).
4. Clears Windows Update log files under `%SystemRoot%\Logs\WindowsUpdate`.
5. Backs up these items when they exist:
   - `%SystemRoot%\winsxs\pending.xml` -> `pending.xml.bak`
   - `%SystemRoot%\SoftwareDistribution` -> `SoftwareDistribution.bak`
   - `%SystemRoot%\System32\Catroot2` -> `Catroot2.bak`
6. Deletes common Windows Update policy keys from `HKCU` and `HKLM`.
7. Refreshes Group Policy with `gpupdate /force`.
8. Resets the security descriptors for `bits` and `wuauserv`.
9. Re-registers a legacy list of Windows Update related DLLs when each DLL exists.
10. Resets Winsock and the Winsock proxy configuration.
11. Starts the related services again.
12. Runs validation checks and then prompts for restart.

Logging
- The script writes a timestamped log file to `%temp%`.
- File name format:
  `ResetWindowsUpdateComponents_YYYY-MM-DD_HH-MM-SS-cc.log`
- The console prints the log path at the end of the run.

Startup checks
- Before making changes, the script prints a small compatibility banner.
- It shows the detected OS string, the native tool directory in use, and whether core tools are present.
- It also reports which fallback modes will be used for prompts, delays, and timestamp generation.
- Startup warnings are informational; they help identify older or unusual Windows environments before the reset continues.

What is logged
- Start time, Windows version, and processor architecture.
- Each major reset step.
- Command output for service control, file operations, registry actions, DLL registration, and network resets.
- Validation results and warnings.

Validation checks
- Confirms these services are running after the reset:
  - `bits`
  - `wuauserv`
  - `cryptsvc`
- Checks `appidsvc` as optional and logs a note instead of treating it as a warning.
- Confirms expected backup items exist when the script created them.
- Confirms the log file itself exists.

Warnings vs failures
- A failure stops the reset early. Example: a required service cannot be stopped, or a critical `sc.exe sdset` or `netsh winsock reset` command fails.
- A warning means the script completed, but something may need review. Examples:
  - A required service is not running during validation.
  - A backup path expected from this run was not found.
  - `gpupdate /force` reports an error.
  - `netsh winsock reset proxy` is unavailable on that Windows version.

Compatibility notes
- The script falls back to `ping` if `timeout` is unavailable.
- The script falls back to `set /p` if `choice` is unavailable.
- Missing DLLs are skipped because some older reset lists include files not present on newer Windows builds.
- Missing optional services are logged and skipped.

How to use
- Right-click `ResetWindowsUpdateComponents.bat` and choose "Run as administrator".
- Let the script complete.
- If validation reports warnings, open the log file from the path shown in the console.
- Restart the computer when prompted, or restart later if needed.

Interpreting the result
- "Validation checks passed." means the post-reset checks found no warnings.
- "Validation completed with warnings." means the reset completed, but the log should be reviewed.
- "Windows Update reset did not complete." means the script exited early and the log should be checked first.
