# SepatuKu App
SepatuKu App merupakan sebuah aplikasi yang berisi artikel-artikel seputar sepatu. SepatuKu App membamntu pengguna dalam menentukan pilihan ketika hendak membeli sepatu dengan informasi-informasi yang diberikan pada aplikasi. Informasi yang diberikan antara lain: review produk, ukuran sepatu, bahan sepatu, tahun produksi, harga dan link online shop.

## Asynchronus Programming
Asynchronous programming adalah metode pemrograman yang memungkinkan suatu program untuk menjalankan tugas-tugas atau operasi secara bersamaan (concurrent), tanpa menunggu satu tugas selesai sebelum memulai tugas berikutnya. Ini sangat berguna dalam aplikasi yang membutuhkan responsivitas tinggi, seperti aplikasi berbasis web dan mobile, di mana menunggu operasi yang lama (misalnya, pemanggilan API, operasi I/O, atau database) dapat menyebabkan aplikasi tidak responsif.

Pada SepatuKu App salah satu penerapan Asychronus programming adalah berikut:
![image](https://github.com/XerOz94/SepatukuApp/assets/105989241/88f1af8f-1d79-46f1-a8c4-4ee2fff39ef4)

## Local Database menggunakan SQFLite
SQFlite adalah plugin untuk Flutter yang memungkinkan pengembang aplikasi menggunakan SQLite, sebuah sistem manajemen basis data relasional yang ringan, untuk menyimpan data secara lokal pada perangkat. SQLite dipilih karena efisiensinya dalam mengelola data yang tidak terlalu besar dan tidak memerlukan server terpisah.
SQFLite pada aplikasi ini digunakan untuk membantu dalam penyimpanan data favorite.

![image](https://github.com/XerOz94/SepatukuApp/assets/105989241/1c688e18-4499-406a-9ac8-879cfab29d8a)

  ![image](https://github.com/XerOz94/SepatukuApp/assets/105989241/d611f678-f76c-4acf-8084-b9113a45e881)
  ![image](https://github.com/XerOz94/SepatukuApp/assets/105989241/1aa4678c-5448-4ba9-90d4-73e505e9d8e8)


## Dark/Light Mode menggunakan Shared Preference
SharedPreferences adalah sebuah class yang memiliki kemampuan ataupun fungsi untuk menampung data dalam key/value yang berpasangan. Data dalam SharedPreferences nantinya dapat digunakan dalam aktivitas apa saja dalam android studio.
Key or Value pair digunakan untuk melihat suatu informasi. Key lebih condong ke string sedangkan value lebih condong kepada integer, Boolean, string, ataupun tipe lainnya.

Pada aplikasi ini Shared Preferences digunakan untuk menyimpan preferensi tema yang dipilih pengguna, dalam hal ini tema Gelap atau Terang.
![image](https://github.com/XerOz94/SepatukuApp/assets/105989241/250ae31c-29cf-4234-bd15-de74f51de343)

### Contoh light mode dan darkmode
![image](https://github.com/XerOz94/SepatukuApp/assets/105989241/f2fb1af3-a985-4911-a04d-b3d640c4e9cc)
![image](https://github.com/XerOz94/SepatukuApp/assets/105989241/7f34a521-6dd3-49ad-8734-96fda81b2ab5)

## Upload Photo Profile dari Camera dan Gallery Device
Pada halaman Profile_Page kami menambahkan fitur edit photo profile yang menerima inputan dari Camera dan Gallery device pengguna, image/photo yang diupload akan otomotis tersimpan di Firebase Storage dengan nama folder UID pengguna tersebut, sehingga setiap pengguna bisa memiliki photo profilenya masing-masing.

Untuk menerapkan hal tersebut kami menggunakan plugin Image_Picker, Image_picker merupakan Plugin Flutter untuk iOS dan Android untuk memilih gambar dari galeri, dan mengambil gambar baru dengan kamera.

![image](https://github.com/XerOz94/SepatukuApp/assets/105989241/77beb7e7-4891-40e6-94e3-9681e452c655)
![image](https://github.com/XerOz94/SepatukuApp/assets/105989241/826c5885-1b50-4a78-8590-0ac98e0abdef)
![image](https://github.com/XerOz94/SepatukuApp/assets/105989241/c556699d-9cb0-4b41-b56a-02651ca27406)
![image](https://github.com/XerOz94/SepatukuApp/assets/105989241/feba7111-8908-4d53-83e4-1250082b844a)

## Local Notification
Local Notification dalam aplikasi Flutter adalah pemberitahuan yang dipicu oleh aplikasi itu sendiri, tanpa mengandalkan server atau layanan notifikasi push. Kami menerapkan local notification untuk memunculkan pesan berhasil login, berhasil logout, berhasil mengedit profil pengguna, dan juga notifikasi ketika menambah atau menghapus artikel favorit.

![image](https://github.com/XerOz94/SepatukuApp/assets/105989241/c676bf4a-cf7e-4d2a-9d07-4237dbddfda6)
![image](https://github.com/XerOz94/SepatukuApp/assets/105989241/08457948-68a8-4bec-918e-cce3b573a394)
![image](https://github.com/XerOz94/SepatukuApp/assets/105989241/224a21bf-21cd-488d-ada3-0ee9287b2ddf)




This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.






