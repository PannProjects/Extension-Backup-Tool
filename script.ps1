Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[System.Windows.Forms.Application]::EnableVisualStyles()

# --- VARIABEL KONTROL ---
$global:isStopping = $false
$userProfile = $env:USERPROFILE

# --- KAMUS IDE (DIRECT FOLDER SCAN) ---
$ides = [ordered]@{ 
    "VS Code" = "$userProfile\.vscode\extensions"
    "Google Antigravity" = "$userProfile\.antigravity\extensions"
    "Windsurf" = "$userProfile\.windsurf\extensions"
    "Cursor AI" = "$userProfile\.cursor\extensions"
    "VSCodium" = "$userProfile\.vscode-oss\extensions"
}

# --- SETUP FONT ---
$fontFamily = "Segoe UI"
$installedFonts = New-Object System.Drawing.Text.InstalledFontCollection
if ($installedFonts.Families.Name -contains "Poppins") { $fontFamily = "Poppins" }

# --- PALET WARNA TAILWIND ---
$bgSlate900  = [System.Drawing.ColorTranslator]::FromHtml("#0f172a")
$bgSlate800  = [System.Drawing.ColorTranslator]::FromHtml("#1e293b")
$textSlate50 = [System.Drawing.ColorTranslator]::FromHtml("#f8fafc")
$textSlate400 = [System.Drawing.ColorTranslator]::FromHtml("#94a3b8")
$btnIndigo   = [System.Drawing.ColorTranslator]::FromHtml("#6366f1")
$btnRose     = [System.Drawing.ColorTranslator]::FromHtml("#f43f5e")
$btnGray     = [System.Drawing.ColorTranslator]::FromHtml("#475569")
$consoleBg   = [System.Drawing.ColorTranslator]::FromHtml("#020617")
$logSuccess  = [System.Drawing.ColorTranslator]::FromHtml("#34d399")
$logError    = [System.Drawing.ColorTranslator]::FromHtml("#fb7185")

# --- UI WINDOW ---
$form = New-Object System.Windows.Forms.Form
$form.Text = "Extension Backup Tool by PannProjects"
$form.Size = New-Object System.Drawing.Size(620, 680)
$form.StartPosition = "CenterScreen"
$form.BackColor = $bgSlate900
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

try {
    $form.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon([System.Windows.Forms.Application]::ExecutablePath)
} catch {}

# Header
$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text = "Universal Backup"
$lblTitle.Font = New-Object System.Drawing.Font($fontFamily, 18, [System.Drawing.FontStyle]::Bold)
$lblTitle.ForeColor = $textSlate50
$lblTitle.Location = New-Object System.Drawing.Point(25, 20)
$lblTitle.AutoSize = $true
$form.Controls.Add($lblTitle)

$lblDesc = New-Object System.Windows.Forms.Label
$lblDesc.Text = "Memindai ekstensi langsung dari direktori lokal untuk mencegah error."
$lblDesc.Font = New-Object System.Drawing.Font($fontFamily, 9)
$lblDesc.ForeColor = $textSlate400
$lblDesc.Location = New-Object System.Drawing.Point(28, 55)
$lblDesc.AutoSize = $true
$form.Controls.Add($lblDesc)

# --- TOMBOL AUTHOR (Baru) ---
$btnAuthor = New-Object System.Windows.Forms.Button
$btnAuthor.Text = "Tentang Author"
$btnAuthor.Location = New-Object System.Drawing.Point(440, 20)
$btnAuthor.Size = New-Object System.Drawing.Size(135, 30)
$btnAuthor.BackColor = $bgSlate800
$btnAuthor.ForeColor = $textSlate50
$btnAuthor.FlatStyle = "Flat"
$btnAuthor.FlatAppearance.BorderSize = 1
$btnAuthor.FlatAppearance.BorderColor = $textSlate400
$btnAuthor.Font = New-Object System.Drawing.Font($fontFamily, 8.5)
$btnAuthor.Cursor = [System.Windows.Forms.Cursors]::Hand
$form.Controls.Add($btnAuthor)

# Checklist Container
$panelCard = New-Object System.Windows.Forms.Panel
$panelCard.Location = New-Object System.Drawing.Point(25, 85)
$panelCard.Size = New-Object System.Drawing.Size(550, 110)
$panelCard.BackColor = $bgSlate800
$form.Controls.Add($panelCard)

$checkedListBox = New-Object System.Windows.Forms.CheckedListBox
$checkedListBox.Dock = "Fill"
$checkedListBox.CheckOnClick = $true
$checkedListBox.BackColor = $bgSlate800
$checkedListBox.ForeColor = $textSlate50
$checkedListBox.Font = New-Object System.Drawing.Font($fontFamily, 10)
$checkedListBox.BorderStyle = "None"

foreach ($k in $ides.Keys) { 
    $isFound = Test-Path $ides[$k]
    [void]$checkedListBox.Items.Add($k, $isFound) 
}
$panelCard.Controls.Add($checkedListBox)

# --- BUTTONS GRID ---
$btnCheck = New-Object System.Windows.Forms.Button
$btnCheck.Text = "1. Cek Ekstensi"
$btnCheck.Location = New-Object System.Drawing.Point(25, 210)
$btnCheck.Size = New-Object System.Drawing.Size(265, 45)
$btnCheck.BackColor = $btnIndigo
$btnCheck.ForeColor = $textSlate50
$btnCheck.FlatStyle = "Flat"
$btnCheck.FlatAppearance.BorderSize = 0
$btnCheck.Font = New-Object System.Drawing.Font($fontFamily, 9, [System.Drawing.FontStyle]::Bold)
$btnCheck.Cursor = [System.Windows.Forms.Cursors]::Hand
$form.Controls.Add($btnCheck)

$btnStart = New-Object System.Windows.Forms.Button
$btnStart.Text = "2. Mulai Backup"
$btnStart.Location = New-Object System.Drawing.Point(310, 210)
$btnStart.Size = New-Object System.Drawing.Size(265, 45)
$btnStart.BackColor = $btnGray 
$btnStart.ForeColor = $textSlate50
$btnStart.FlatStyle = "Flat"
$btnStart.FlatAppearance.BorderSize = 0
$btnStart.Enabled = $false
$btnStart.Font = New-Object System.Drawing.Font($fontFamily, 9, [System.Drawing.FontStyle]::Bold)
$btnStart.Cursor = [System.Windows.Forms.Cursors]::Hand
$form.Controls.Add($btnStart)

$btnStop = New-Object System.Windows.Forms.Button
$btnStop.Text = "Berhenti"
$btnStop.Location = New-Object System.Drawing.Point(25, 265)
$btnStop.Size = New-Object System.Drawing.Size(265, 45)
$btnStop.BackColor = $btnRose
$btnStop.ForeColor = $textSlate50
$btnStop.FlatStyle = "Flat"
$btnStop.FlatAppearance.BorderSize = 0
$btnStop.Enabled = $false
$btnStop.Font = New-Object System.Drawing.Font($fontFamily, 9, [System.Drawing.FontStyle]::Bold)
$btnStop.Cursor = [System.Windows.Forms.Cursors]::Hand
$form.Controls.Add($btnStop)

$btnExit = New-Object System.Windows.Forms.Button
$btnExit.Text = "Keluar Aplikasi"
$btnExit.Location = New-Object System.Drawing.Point(310, 265)
$btnExit.Size = New-Object System.Drawing.Size(265, 45)
$btnExit.BackColor = $bgSlate800
$btnExit.ForeColor = $textSlate400
$btnExit.FlatStyle = "Flat"
$btnExit.FlatAppearance.BorderSize = 0
$btnExit.Font = New-Object System.Drawing.Font($fontFamily, 9, [System.Drawing.FontStyle]::Bold)
$btnExit.Cursor = [System.Windows.Forms.Cursors]::Hand
$form.Controls.Add($btnExit)

# --- LOG CONSOLE ---
$txtLog = New-Object System.Windows.Forms.TextBox
$txtLog.Multiline = $true
$txtLog.ScrollBars = "Vertical"
$txtLog.Location = New-Object System.Drawing.Point(25, 330)
$txtLog.Size = New-Object System.Drawing.Size(550, 250)
$txtLog.BackColor = $consoleBg
$txtLog.ForeColor = $logSuccess
$txtLog.Font = New-Object System.Drawing.Font("Consolas", 9)
$txtLog.BorderStyle = "None"
$txtLog.ReadOnly = $true
$form.Controls.Add($txtLog)

$lblFooter = New-Object System.Windows.Forms.Label
$lblFooter.Text = "© $(Get-Date -Format 'yyyy') PannProjects"
$lblFooter.Location = New-Object System.Drawing.Point(25, 600)
$lblFooter.ForeColor = $textSlate400
$lblFooter.AutoSize = $true
$form.Controls.Add($lblFooter)

# --- LOGIKA CORE ---
function Get-ExtensionsFromDir($extDir) {
    $extList = @()
    if (Test-Path $extDir) {
        $folders = Get-ChildItem -Path $extDir -Directory
        foreach ($folder in $folders) {
            [System.Windows.Forms.Application]::DoEvents()
            if ($folder.Name.StartsWith(".")) { continue } 
            
            $pkgPath = Join-Path $folder.FullName "package.json"
            if (Test-Path $pkgPath) {
                try {
                    $pkg = Get-Content $pkgPath -Raw | ConvertFrom-Json
                    $pub = $pkg.publisher
                    $name = $pkg.name
                    if ($pub -and $name) {
                        $extList += "$pub.$name"
                    }
                } catch {}
            }
        }
    }
    return $extList | Select-Object -Unique
}

# --- EVENT HANDLERS ---

# Tombol Author
$btnAuthor.Add_Click({
    [System.Windows.Forms.MessageBox]::Show(
        "Extension Backup Tool`n`nDibuat oleh: PannProjects`nGitHub: https://github.com/PannProjects`n`nAlat ini membantu Anda membackup ekstensi dari berbagai IDE berbasis VS Code dengan mengekstrak langsung dari folder sistem untuk mencegah error CLI.",
        "Tentang Author",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Information
    )
})

# Tombol Cek Ekstensi (Diperbarui untuk menampilkan daftar nama)
$btnCheck.Add_Click({
    if ($checkedListBox.CheckedItems.Count -eq 0) {
        $txtLog.Text = "[!] Pilih minimal satu IDE untuk dicek."
        return
    }

    $txtLog.Clear()
    $txtLog.AppendText(">> Memindai direktori ekstensi lokal...`r`n")
    $successCount = 0

    foreach ($ide in $checkedListBox.CheckedItems) {
        [System.Windows.Forms.Application]::DoEvents()
        $path = $ides[$ide]
        if (-Not (Test-Path $path)) {
            $txtLog.AppendText("`r`n[-] ${ide}: Folder tidak ditemukan ($path)`r`n")
            continue
        }

        $exts = Get-ExtensionsFromDir $path
        $count = if ($null -eq $exts) { 0 } else { $exts.Count }
        
        $txtLog.AppendText("`r`n[=] ${ide}: Terdeteksi $count ekstensi [=]`r`n")
        
        if ($count -gt 0) { 
            $successCount++
            # Tampilkan 10 ekstensi pertama sebagai preview agar log tidak terlalu penuh
            $previewLimit = 10
            for ($i = 0; $i -lt $count; $i++) {
                if ($i -lt $previewLimit) {
                    $txtLog.AppendText("    - $($exts[$i])`r`n")
                } elseif ($i -eq $previewLimit) {
                    $txtLog.AppendText("    ... dan $($count - $previewLimit) ekstensi lainnya.`r`n")
                    break
                }
            }
        } else {
            $txtLog.AppendText("    (Folder kosong atau tidak ada package.json yang valid)`r`n")
        }
    }

    if ($successCount -gt 0) {
        $btnStart.Enabled = $true
        $btnStart.BackColor = $btnIndigo
        $txtLog.AppendText("`r`n>> Verifikasi Selesai. Tombol 'Mulai Backup' aktif.`r`n")
    } else {
        $txtLog.AppendText("`r`n>> Gagal menemukan ekstensi yang bisa di-backup.`r`n")
    }
    
    # Scroll ke paling bawah agar user selalu melihat log terbaru
    $txtLog.SelectionStart = $txtLog.Text.Length
    $txtLog.ScrollToCaret()
})

# Tombol Start Backup
$btnStart.Add_Click({
    $global:isStopping = $false
    $btnStart.Enabled = $false
    $btnCheck.Enabled = $false
    $btnStop.Enabled = $true
    $txtLog.AppendText("`r`n==========================================`r`n")
    $txtLog.AppendText(">> Memulai Proses Unduhan VSIX...`r`n")

    $backupFolder = "Backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    New-Item -ItemType Directory -Path $backupFolder -Force | Out-Null

    foreach ($ide in $checkedListBox.CheckedItems) {
        if ($global:isStopping) { break }
        
        $path = $ides[$ide]
        if (-Not (Test-Path $path)) { continue }
        
        $exts = Get-ExtensionsFromDir $path
        if ($exts.Count -eq 0) { continue }

        $sub = Join-Path $backupFolder $ide
        New-Item -ItemType Directory -Path $sub -Force | Out-Null
        
        $txtLog.AppendText("`r`n[#] Mengunduh Ekstensi ${ide}...`r`n")

        $total = $exts.Count
        $current = 0

        foreach ($ext in $exts) {
            if ($global:isStopping) { break }
            [System.Windows.Forms.Application]::DoEvents()
            
            $current++
            $txtLog.AppendText("   [$current/$total] $ext... ")
            $txtLog.SelectionStart = $txtLog.Text.Length
            $txtLog.ScrollToCaret()

            try {
                $parts = $ext -split '\.', 2
                $url = "https://$($parts[0]).gallery.vsassets.io/_apis/public/gallery/publisher/$($parts[0])/extension/$($parts[1])/latest/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
                $outFile = Join-Path $sub "$ext.vsix"
                
                $client = New-Object System.Net.WebClient
                $client.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) PowerShell")
                $uri = New-Object System.Uri($url)
                
                $task = $client.DownloadFileTaskAsync($uri, $outFile)
                
                while (-not $task.IsCompleted) {
                    if ($global:isStopping) { 
                        $client.CancelAsync()
                        break 
                    }
                    [System.Windows.Forms.Application]::DoEvents()
                    Start-Sleep -Milliseconds 50
                }
                
                $client.Dispose()
                
                if ($global:isStopping) { break }
                
                if ($task.Status -eq [System.Threading.Tasks.TaskStatus]::RanToCompletion) {
                    $txtLog.AppendText("OK`r`n")
                } elseif ($task.IsFaulted) {
                    throw $task.Exception.InnerException
                }
                
                # Jeda untuk mencegah Rate Limiting (HTTP 429), dengan DoEvents
                for ($j = 0; $j -lt 5; $j++) {
                    if ($global:isStopping) { break }
                    [System.Windows.Forms.Application]::DoEvents()
                    Start-Sleep -Milliseconds 50
                }
            } catch {
                $txtLog.SelectionColor = $logError
                $errMsg = $_.Exception.Message
                if ($null -ne $_.Exception.InnerException) { $errMsg = $_.Exception.InnerException.Message }
                $txtLog.AppendText("FAIL ($errMsg)`r`n")
                $txtLog.SelectionColor = $logSuccess
            }
        }
    }
    $txtLog.AppendText("`r`n>> PROSES SELESAI.`r`n")
    $txtLog.AppendText(">> Tersimpan di: $(Resolve-Path $backupFolder)`r`n")
    $btnStart.Enabled = $true
    $btnCheck.Enabled = $true
    $btnStop.Enabled = $false
    
    $txtLog.SelectionStart = $txtLog.Text.Length
    $txtLog.ScrollToCaret()
})

$btnStop.Add_Click({
    $global:isStopping = $true
    $btnStop.Enabled = $false
    $txtLog.AppendText("`r`n[!] Membatalkan proses...`r`n")
})

$btnExit.Add_Click({ $form.Close() })

[void]$form.ShowDialog()