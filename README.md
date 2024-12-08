# Smart Home Controller: Alat Otomatisasi Rumah Pintar

## 1. Latar Belakang Kehadiran Alat

Alat ini hadir sebagai bagian dari sistem otomatisasi rumah pintar yang bertujuan untuk meningkatkan kenyamanan, efisiensi energi, dan keamanan penghuni rumah. Sistem rumah pintar menggunakan sensor untuk memantau kondisi lingkungan, seperti suhu dan pencahayaan, serta perangkat lainnya seperti kipas, lampu, dan alarm. Dengan alat ini, pengendalian perangkat rumah dapat dilakukan secara otomatis tanpa intervensi manual, berdasarkan kondisi yang terdeteksi oleh sensor.

### Faktor Pendorong Kehadiran Alat:
- **Kenyamanan Penghuni**: Pengaturan otomatis suhu, pencahayaan, dan perangkat lainnya sesuai dengan preferensi pengguna, mengurangi kebutuhan untuk pengaturan manual.
- **Efisiensi Energi**: Mengurangi pemborosan energi dengan menyalakan perangkat hanya ketika dibutuhkan.
- **Keamanan**: Sistem alarm dapat memberi peringatan jika terdeteksi kondisi berbahaya, seperti suhu tinggi atau lingkungan yang tidak aman.

---

## 2. Cara Kerja Alat

Alat ini bekerja dengan memanfaatkan beberapa komponen sensor suhu (temperature sensor), sensor cahaya (light sensor), dan perangkat kendali untuk kipas, lampu, dan alarm. Berikut adalah penjelasan cara kerja dari sistem alat ini:

### Komponen Utama:
- **Sensor Suhu** digunakan untuk mengukur suhu lingkungan dan mengirimkan data ke sistem. Berdasarkan suhu yang terdeteksi, alat ini akan mengatur kipas untuk menyala atau mati. Jika suhu lebih dari 30°C, kipas akan menyala untuk menurunkan suhu.
- **Sensor Cahaya** digunakan untuk mengukur intensitas cahaya di dalam ruangan. Jika pencahayaan kurang dari ambang batas tertentu (misalnya 50 unit), alat ini akan menyalakan lampu.
- **Kontrol Kipas dan Lampu** digunakan berdasarkan data dari sensor suhu dan cahaya, alat ini secara otomatis mengontrol kipas dan lampu. Kipas menyala saat suhu tinggi, dan lampu menyala jika cahaya rendah.
- **Alarm** digunakan jika suhu melebihi ambang batas (misalnya lebih dari 40°C), alarm akan aktif untuk memberikan peringatan kepada penghuni rumah.
- **Display** digunakan untuk sistem tampilan memberikan umpan balik visual mengenai status perangkat. Jika kipas atau lampu menyala, tampilan akan memperlihatkan status tersebut.

### Diagram Alur Kerja:
1. **Sensor Suhu dan Cahaya** mendeteksi kondisi lingkungan.
2. Berdasarkan data sensor, **Kipas** dan **Lampu** diatur otomatis.
3. Jika kondisi berbahaya (misalnya suhu tinggi), **Alarm** akan terpicu.
4. **Display** menunjukkan status perangkat yang aktif.

---

## 3. Cara Penggunaan Alat

## a. **Instalasi dan Pemasangan Komponen**

Sebelum alat digunakan dalam simulasi atau implementasi fisik, semua komponen sistem harus terhubung dengan benar. Dalam VHDL, kita menggunakan **entity** dan **architecture** untuk mendefinisikan komponen-komponen seperti sensor suhu, sensor cahaya, kipas, lampu, alarm, dan display. Setiap komponen ini akan terhubung melalui port yang telah didefinisikan.

### Langkah-langkah Instalasi:
- **Entity** mendefinisikan antarmuka antara perangkat dengan dunia luar (misalnya sensor atau output perangkat).
- **Arsitektur** mendefinisikan bagaimana sinyal atau port berinteraksi di dalam sistem, mengatur bagaimana pembacaan sensor suhu atau cahaya digunakan untuk mengendalikan kipas atau lampu.

## b. **Pengoperasian Otomatis Berdasarkan Sensor**

Setelah alat dijalankan, sistem akan memonitor kondisi dari sensor dan memberikan kontrol otomatis terhadap perangkat rumah seperti kipas, lampu, dan alarm berdasarkan kondisi yang terdeteksi.

### b.1 **Sensor Suhu (Temperature Sensor)**

Pembacaan dari sensor suhu diterima melalui port **temperature** (tipe `STD_LOGIC_VECTOR(7 downto 0)`). Berdasarkan nilai sensor suhu yang diterima, sistem mengendalikan kipas:

```vhdl
if to_integer(unsigned(temperature)) > 30 then
    fan_control <= '1';  -- Kipas menyala
else
    fan_control <= '0';  -- Kipas mati
end if;
```

### b.2 **Sensor Cahaya (Light Sensor)**

Sensor cahaya berfungsi untuk mendeteksi tingkat pencahayaan di dalam ruangan. Berdasarkan nilai sensor cahaya, alat akan mengendalikan lampu:

```vhdl
if to_integer(unsigned(light_sensor)) < 50 then
    light_control <= '1';  -- Lampu menyala jika pencahayaan rendah
else
    light_control <= '0';  -- Lampu mati jika pencahayaan cukup
end if;
```

### b.3 **Alarm**

Sistem alarm akan terpicu jika suhu mencapai nilai tertentu, misalnya 40°C. Proses ini dijelaskan melalui kode berikut di dalam **Device Control**:

```vhdl
if to_integer(unsigned(temperature)) > 40 then
    alarm_control <= '1';  -- Alarm menyala jika suhu terlalu tinggi
else
    alarm_control <= '0';  -- Alarm mati jika suhu normal
end if;
```

## c. **Penggunaan Manual**

Dalam konteks VHDL, penggunaan manual tidak diimplementasikan dalam sistem otomatis ini secara langsung. Namun, jika diperlukan, kita bisa menambahkan logika atau sinyal manual untuk mengubah status perangkat.

Misalnya, dalam arsitektur VHDL, kita bisa menambahkan kondisi manual:

```vhdl
if manual_control = '1' then
    fan_control <= '1';  -- Kipas menyala manual
else
    fan_control <= '0';  -- Kipas mati manual
end if;
```

## d. **Reset dan Perawatan**

- **Reset** digunakan untuk memulai ulang seluruh sistem, mengembalikan semua perangkat ke keadaan awal (misalnya mematikan kipas, lampu, dan alarm). Reset dilakukan dengan mengatur sinyal `reset` ke '1', kemudian ke '0' setelah beberapa waktu.
- **Perawatan sistem** dilakukan dengan memeriksa nilai-nilai sinyal yang diterima dan memastikan bahwa tidak ada kesalahan dalam logika pengontrolan perangkat. Dalam VHDL, kita dapat memonitor sinyal dan kondisi logika selama simulasi untuk memastikan sistem bekerja sesuai harapan.

## e. **Display dan Feedback**

Alat ini juga dapat memberikan feedback visual mengenai status perangkat (seperti kipas atau lampu yang menyala). Feedback ini ditampilkan melalui **Display System**, yang mengubah nilai sinyal `display` berdasarkan kondisi kipas dan lampu.

```vhdl
if fan_signal = '1' then
    display <= "1111110"; -- Menampilkan status "Fan ON"
elsif light_signal = '1' then
    display <= "0111111"; -- Menampilkan status "Light ON"
else
    display <= "0000000"; -- Menampilkan status "Both OFF"
end if;
```

## f. **Proses dan Simulasi**

Seluruh sistem dikendalikan oleh proses **Device_Control**, **State_Monitoring**, **Alarm**, dan **Display** yang bekerja berdasarkan sinyal clock (`clk`) dan reset (`reset`). Setiap proses memeriksa kondisi perangkat dan mengontrol status sinyal terkait pada setiap siklus clock. Proses ini terus berulang hingga simulasi selesai atau sistem di-reset.
