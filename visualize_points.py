import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Dosyadan noktaları oku
noktalar = []
with open('o.txt', 'r') as dosya:
    for satir in dosya:
        # Satırı temizle ve parantezleri kaldır
        satir = satir.strip().strip('()')
        if satir:
            # Virgülle ayrılmış değerleri al
            degerler = satir.split(',')
            x = float(degerler[0])
            y = float(degerler[1])
            z = float(degerler[2])
            noktalar.append([x, y, z])

# NumPy dizisine çevir
noktalar = np.array(noktalar)

# 3D grafik oluştur
fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(111, projection='3d')

# Noktaları çiz
ax.scatter(noktalar[:, 0], noktalar[:, 1], noktalar[:, 2], 
           c='blue', marker='o', s=50, alpha=0.6)

# Noktaları çizgi ile birleştir (opsiyonel)
ax.plot(noktalar[:, 0], noktalar[:, 1], noktalar[:, 2], 
        'r-', linewidth=1, alpha=0.5)

# Eksen etiketleri
ax.set_xlabel('X ekseni')
ax.set_ylabel('Y ekseni')
ax.set_zlabel('Z ekseni')
ax.set_title('3D Nokta Bulutu')

# Görünümü ayarla
ax.view_init(elev=20, azim=45)

# Grid ekle
ax.grid(True)

plt.tight_layout()
plt.show()

# Nokta sayısını yazdır
print(f"Toplam nokta sayısı: {len(noktalar)}")
print(f"İlk 3 nokta:\n{noktalar[:3]}")