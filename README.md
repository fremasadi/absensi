# Absensi App

Absensi App adalah aplikasi absensi berbasis **Flutter** yang memungkinkan pengguna untuk melakukan absensi dengan menggunakan **track location** (berbasis GPS), mengambil foto sebagai bukti kehadiran, dan mencatat status absensi seperti **Sakit**, **Masuk**, atau **Ijin**. Aplikasi ini juga memiliki fitur **riwayat absensi** serta halaman **profil pengguna**. Dibangun menggunakan **GetX** untuk manajemen state dan navigasi, **Firebase** sebagai backend, dan **Google Maps API** untuk pelacakan lokasi.

## Fitur

- **Absensi dengan Lokasi**: Pengguna dapat melakukan absensi dengan verifikasi lokasi menggunakan Google Maps API.
- **Foto Bukti Kehadiran**: Pengguna diwajibkan mengirimkan foto sebagai bukti absensi.
- **Input Status**: Pengguna dapat memilih status absensi seperti:
  - **Masuk**
  - **Sakit**
  - **Ijin**
- **Riwayat Absensi**: Menyimpan riwayat absensi pengguna, sehingga mereka bisa melihat data absensi sebelumnya.
- **Profil Pengguna**: Halaman profil yang menampilkan informasi pengguna.
- **GetX State Management**: Untuk mengelola state aplikasi dan mempermudah navigasi antar halaman.
- **Firebase Authentication**: Untuk login dan registrasi pengguna.
- **Firebase Realtime Database**: Untuk menyimpan data absensi dan pengguna secara real-time.
- **Firebase Storage**: Untuk menyimpan foto bukti absensi.
- **Google Maps API**: Untuk pelacakan lokasi dan memastikan pengguna melakukan absensi di lokasi yang ditentukan.

## Teknologi yang Digunakan

- **Flutter**: Framework untuk membangun aplikasi mobile cross-platform.
- **GetX**: Library untuk state management, dependensi, dan navigasi yang efisien.
- **Firebase**: Backend untuk autentikasi dan penyimpanan data.
  - **Firebase Authentication**: Untuk autentikasi pengguna.
  - **Firebase Realtime Database**: Untuk menyimpan data absensi dan pengguna secara real-time.
  - **Firebase Storage**: Untuk menyimpan foto bukti absensi.
- **Google Maps API**: Digunakan untuk melacak lokasi pengguna selama absensi.
- **Dart**: Bahasa pemrograman utama yang digunakan untuk mengembangkan aplikasi.

## Persyaratan Sistem

- **Flutter SDK**: Versi terbaru.
- **Dart**: Terintegrasi dengan Flutter SDK.
- **Firebase Project**: Untuk autentikasi dan penyimpanan data absensi.
- **Google Maps API Key**: Untuk fitur pelacakan lokasi.

## Instalasi

1. **Clone repository** ini ke mesin lokal Anda:

   ```bash
   git clone https://github.com/username/absensi_app.git
   cd absensi_app
