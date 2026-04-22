# Universal Extension Backup Tool

*[Read in English](#-english) | [Baca dalam Bahasa Indonesia](#-bahasa-indonesia)*

---

<a id="-english"></a>
## EN English

A lightweight, powerful, and responsive Windows GUI utility designed to backup extensions from various VS Code-based IDEs directly from your local environment. 

By scanning your local system directories instead of relying on the IDE's Command Line Interface (CLI), this tool ensures a safe, error-free backup process even if your IDE environments are misconfigured or experiencing path issues.

### 🌟 Features
- **Direct Local Scan**: Directly reads local `.vscode`, `.cursor`, `.windsurf`, and other extension directories.
- **Multi-IDE Support**: Out-of-the-box support for popular IDEs: VS Code, VSCodium, Cursor AI, Windsurf, Google Antigravity.
- **Responsive UI**: Built with PowerShell Windows Forms featuring asynchronous processing. The UI remains fully responsive during heavy download operations.
- **Smart Downloading**: Includes rate-limit protection and connection timeouts to prevent IP blocking from Microsoft's VS Code Marketplace.
- **No External Dependencies**: Pure PowerShell script. No Node.js or Python required.

### 🚀 How to Use
**Option 1: Running the Script Directly (Recommended)**
1. Clone or download this repository.
2. Right-click the `script.ps1` file and select **Run with PowerShell**.
3. Select the IDEs you want to backup.
4. Click **Cek Ekstensi**, then click **Mulai Backup**.
5. The extensions (.vsix) will be downloaded into a timestamped folder.

**Option 2: Using the Executable**
1. Download the `.exe` installer from the **[Releases](../../releases)** page.
2. Install the tool and launch it from your Start Menu.
3. Select the IDEs and begin the backup.

### ⚠️ Disclaimer
Some antivirus programs or Windows Defender may flag PowerShell scripts compiled to `.exe` as false positives. If you encounter this, it is perfectly safe to run the raw `script.ps1` file instead.

---

<a id="-bahasa-indonesia"></a>
## ID Bahasa Indonesia

Sebuah utilitas Windows GUI yang ringan, responsif, dan tangguh, dirancang untuk mencadangkan (backup) ekstensi dari berbagai IDE berbasis VS Code langsung dari lingkungan lokal Anda.

Dengan memindai direktori sistem lokal alih-alih mengandalkan Command Line Interface (CLI) bawaan IDE, alat ini memastikan proses backup yang aman dan bebas dari *error*, bahkan jika pengaturan *path* CLI IDE Anda sedang bermasalah.

### 🌟 Fitur Utama
- **Pemindaian Lokal Langsung**: Membaca langsung direktori ekstensi lokal seperti `.vscode`, `.cursor`, `.windsurf`, dll.
- **Mendukung Banyak IDE**: Langsung mendukung IDE populer: VS Code, VSCodium, Cursor AI, Windsurf, Google Antigravity.
- **Antarmuka (UI) Responsif**: Dibangun dengan PowerShell Windows Forms dan pemrosesan asinkron. UI tetap mulus dan bisa digeser saat proses unduhan yang berat berlangsung.
- **Unduhan Cerdas**: Dilengkapi dengan pencegahan pembatasan *rate-limit* dan batas waktu (*timeout*) koneksi untuk mencegah pemblokiran IP oleh Microsoft VS Code Marketplace.
- **Tanpa Ketergantungan Eksternal**: Murni menggunakan skrip PowerShell. Tidak butuh Node.js atau Python.

### 🚀 Cara Penggunaan
**Opsi 1: Menjalankan Skrip Langsung (Rekomendasi)**
1. Unduh atau klon repositori ini.
2. Klik kanan pada file `script.ps1` lalu pilih **Run with PowerShell**.
3. Pilih IDE yang ingin di-backup.
4. Klik **Cek Ekstensi**, lalu klik **Mulai Backup**.
5. Ekstensi (.vsix) akan diunduh ke dalam folder dengan nama tanggal & waktu otomatis.

**Opsi 2: Menggunakan File Executable (.exe)**
1. Unduh installer `.exe` melalui halaman **[Releases](../../releases)**.
2. Instal aplikasinya dan jalankan dari Start Menu komputer Anda.
3. Pilih IDE dan mulai proses backup.

### ⚠️ Peringatan (Disclaimer)
Beberapa program antivirus atau Windows Defender mungkin mendeteksi skrip PowerShell yang dikompilasi menjadi `.exe` sebagai ancaman (*false positive*). Jika Anda menemui hal ini, abaikan peringatannya atau jalankan file mentah `script.ps1` secara langsung karena 100% aman.

---
*Developed by PannProjects*
