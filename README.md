# 📱 Tugas 2: Teknologi Pemrograman Mobile IF-E

---

# 👥 Anggota Kelompok

1. Cindy Nabella Susanto / 123230058
2. Sachio Devana Putera M P / 123230064
3. Amnan Budi Kusuma / 123230078
4. Al Faarray / 123230109

---

# 🔗 Link Penting

**Link ZIP Project**
> https://drive.google.com/file/d/1ImgiDyooKtCElKVbwWVR7hIJDJx9JBh6/view?usp=sharing

**Link PPT Presentasi**
> (soon)

---

# ✨ Fitur Aplikasi

Aplikasi ini memiliki beberapa fitur utama:

### 🧮 1. Calculator
Fitur kalkulator sederhana yang dapat melakukan operasi matematika dasar:

- Penjumlahan
- Pengurangan

Fitur ini juga memiliki **validasi input** menggunakan `TextInputFormatter` dan `RegExp` untuk mencegah kesalahan input seperti:
- dua operator berturut-turut
- lebih dari satu titik desimal
- jumlah digit terlalu panjang

---

### 🔢 2. Number Checker
Fitur ini digunakan untuk mengecek sifat suatu bilangan:

- Menentukan apakah bilangan **genap atau ganjil**
- Menentukan apakah bilangan **prima**

Algoritma pengecekan bilangan prima menggunakan metode **trial division**.

---

### 🔍 3. Total Digit Counter
Fitur ini menghitung jumlah digit dari suatu angka yang dimasukkan oleh pengguna.

Contoh:
```
Input : 12345
Output: Jumlah digit = 5
```

Fitur ini menggunakan **Regular Expression (Regex)** untuk memfilter karakter non-angka.

---

### ⏱️ 4. Stopwatch
Fitur stopwatch sederhana untuk mengukur waktu.

Fitur ini menggunakan:

- `Stopwatch` class dari Dart
- `Timer.periodic` untuk memperbarui UI secara real-time

---

### 🔺 5. Pyramid Calculator

Fitur ini menghitung:

1️⃣ **Volume Piramida**

$$
V = \frac{1}{3} a^2 h
$$

2️⃣ **Luas Permukaan Piramida**

$$
L = a^2 + 2as
$$

dimana

$$
s = \sqrt{(a/2)^2 + h^2}
$$

---

# 🧠 Struktur Proyek

Struktur proyek menggunakan pendekatan **feature-based architecture**.

```
lib/
 ├ core/
 │   ├ theme/
 │   │   └ app_colors.dart
 │   └ utils/
 │       └ number_checker.dart
 │
 ├ feature/
 │   ├ auth/
 │   ├ calculator/
 │   ├ number_checker/
 │   ├ pyramid/
 │   ├ stopwatch/
 │   ├ field_counter/
 │   └ group_profile/
 │
 └ main.dart
```

### Penjelasan Struktur

**core/**
Berisi komponen reusable seperti:

- tema warna aplikasi
- utilitas matematika

**feature/**
Berisi implementasi setiap fitur aplikasi secara terpisah.

Pendekatan ini mempermudah:

- maintenance
- pengembangan fitur baru
- pengelolaan kode

---

# ⚙️ Teknologi yang Digunakan

- **Flutter**
- **Dart**
- **Material UI**
- **Intl Package** (untuk formatting angka)

---

# ▶️ Cara Menjalankan Program

Pastikan perangkat sudah terinstall:

- **Flutter SDK**
- **Android Studio / VS Code**
- **Android Emulator / Physical Device**

---

## 1️⃣ Jika menggunakan Clone Repository

Clone repository terlebih dahulu:

```bash
git clone https://github.com/AmnanBK/tpm-tugas-modul-4
```

Masuk ke folder project:

```bash
cd tpm-tugas-modul-4

```

Install dependencies:

```bash
flutter pub get
```

Jalankan aplikasi:

```bash
flutter run
```

---

## 2️⃣ Jika menggunakan Download ZIP

1. Download repository dalam bentuk **ZIP**
2. Extract file ZIP
3. Buka folder project menggunakan **VS Code atau Android Studio**
4. Jalankan perintah berikut pada terminal:

```bash
flutter pub get
```

5. Jalankan aplikasi:

```bash
flutter run
```

---
