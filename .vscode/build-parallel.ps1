# Parallel LaTeX Build Script
Write-Host "=== Parallel LaTeX Build Script ===" -ForegroundColor Magenta

# Find all TeX files in main directory
$texFiles = Get-ChildItem -Path ".\main\*.tex"
Write-Host "Found $($texFiles.Count) TeX files to compile in parallel..." -ForegroundColor Cyan

# Create main/pdfs directory if it doesn't exist
if (!(Test-Path ".\main\pdfs")) {
    New-Item -ItemType Directory -Path ".\main\pdfs" -Force | Out-Null
    Write-Host "Created main/pdfs directory" -ForegroundColor Yellow
}

# Start compilation pass
$processes = @()
foreach ($file in $texFiles) {
    Write-Host "Starting compilation of $($file.Name)..." -ForegroundColor Yellow
    $process = Start-Process -FilePath "tectonic" -ArgumentList "-Z", "search-path=.", "-Z", "search-path=sty/moloch", "-Z", "continue-on-errors", "-o", ".\main\pdfs", $file.FullName -PassThru -NoNewWindow -Wait:$false
    $processes += @{Process=$process; FileName=$file.Name; FilePath=$file.FullName}
}

# Wait for compilation to complete and report results
Write-Host "Waiting for compilation to complete..." -ForegroundColor Cyan
foreach ($procInfo in $processes) {
    $procInfo.Process.WaitForExit()
    if ($procInfo.Process.ExitCode -eq 0) {
        Write-Host "Successfully compiled $($procInfo.FileName)" -ForegroundColor Green
    } else {
        Write-Host "Failed compilation for $($procInfo.FileName)" -ForegroundColor Red
    }
}

# Clean up temporary files
Write-Host "Cleaning up temporary files..." -ForegroundColor Cyan
Get-ChildItem -Path "." -Include "*.aux","*.log","*.nav","*.out","*.snm","*.toc","*.atfi","*.fls","*.fdb_latexmk","*.synctex.gz","*.bbl","*.blg" -Recurse | Remove-Item -Force

Write-Host "Cleanup completed!" -ForegroundColor Green
Write-Host "=== Build process finished ===" -ForegroundColor Magenta
