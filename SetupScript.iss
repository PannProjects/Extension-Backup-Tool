; --- Script Inno Setup untuk Extension Backup Tool ---

[Setup]
; ID unik untuk aplikasi Anda (jangan diubah agar saat update/uninstall terbaca dengan benar)
AppId={{5A8D2F8A-9B3C-4D1E-8F2A-7C3B6E4A1D9F}
AppName=Extension Backup Tool
AppVersion=1.0
AppPublisher=PannProjects
AppPublisherURL=https://github.com/PannProjects
AppSupportURL=https://github.com/PannProjects
AppUpdatesURL=https://github.com/PannProjects

; Lokasi default instalasi (Akan masuk ke C:\Program Files\PannProjects\Extension Backup Tool)
DefaultDirName={autopf}\PannProjects\Extension Backup Tool
DisableProgramGroupPage=yes

; Menentukan letak hasil file Setup.exe nanti (terkumpul di folder "Output")
OutputDir=.\Output
OutputBaseFilename=setup_extension-backup-tool

; (Opsional) Hapus tanda titik koma (;) di bawah ini jika Anda punya logo.ico untuk ikon Installernya
SetupIconFile=logo.ico

Compression=lzma2
SolidCompression=yes
WizardStyle=modern

[Tasks]
; Memberikan opsi centang "Create a desktop icon" saat instalasi
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; PERHATIAN: Pastikan nama file .exe di bawah ini SAMA PERSIS dengan yang ada di folder Anda
Source: "Extension Backup Tool.exe"; DestDir: "{app}"; Flags: ignoreversion
; Jika Anda punya file logo.ico, tambahkan baris di bawah ini dengan menghapus titik komanya:
; Source: "logo.ico"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
; Membuat shortcut di Start Menu
Name: "{autoprograms}\Extension Backup Tool"; Filename: "{app}\Extension Backup Tool.exe"
; Membuat shortcut di Desktop (jika user mencentang opsi)
Name: "{autodesktop}\Extension Backup Tool"; Filename: "{app}\Extension Backup Tool.exe"; Tasks: desktopicon

[Run]
; Menampilkan centang "Launch Extension Backup Tool" di akhir instalasi
Filename: "{app}\Extension Backup Tool.exe"; Description: "{cm:LaunchProgram,Extension Backup Tool}"; Flags: nowait postinstall skipifsilent