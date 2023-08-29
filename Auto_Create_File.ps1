$folder_path = Read-Host "Enter folder path"
$file_size_str = Read-Host "Enter file size with unit (KB, MB, GB, TB)"
$file_count = Read-Host "Enter number of files to create"
$file_name = Read-Host "Enter file name"

# 解析檔案大小
$file_size = 0
if ($file_size_str -match '^(\d+)\s*(KB|MB|GB|TB)$') {
    $file_size_value = [int]$matches[1]
    $file_size_unit = $matches[2]
    switch ($file_size_unit) {
        "KB" { $file_size = $file_size_value * 1KB }
        "MB" { $file_size = $file_size_value * 1MB }
        "GB" { $file_size = $file_size_value * 1GB }
        "TB" { $file_size = $file_size_value * 1TB }
    }
} else {
    Write-Host "Invalid file size format. Please enter a number followed by a unit (KB, MB, GB, TB)."
    Exit 1
}

echo "Creating $file_count files in $folder_path with name $file_name and size $file_size_str each..."

for ($i = 1; $i -le $file_count; $i++) {
    $file_path = Join-Path $folder_path "$file_name-$i.txt"
    Write-Host "Creating file $file_path with size $file_size_str..."
    $stream = New-Object IO.FileStream ($file_path, [IO.FileMode]::Create, [IO.FileAccess]::Write)
    $stream.SetLength($file_size)
    $stream.Close()
}

Write-Host "All files created successfully."
Pause