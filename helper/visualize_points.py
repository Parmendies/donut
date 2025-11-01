import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# o.txt dosyasını oku
file_name = 'core/o.txt'

# Koordinatları saklamak için liste
coordinates = []

# Dosyayı aç ve verileri oku
with open(file_name, 'r') as file:
    lines = file.readlines()
    for line in lines:
        # Satırı temizle ve köşeli parantezleri çıkar
        line = line.strip().strip('[]')  # Köşeli parantezleri temizle
        # Noktaları virgülle ayır ve her birini tuple'a dönüştür
        coords = line.split('), (')  # Koordinatları ayır
        for coord in coords:
            coord = coord.strip('()')  # Parantezleri temizle
            point = tuple(map(float, coord.split(',')))  # Noktayı float'a dönüştür
            coordinates.append(point)

# 3D grafiği çiz
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

# Koordinatları x, y, z olarak ayır
x_vals = [coord[0] for coord in coordinates]
y_vals = [coord[1] for coord in coordinates]
z_vals = [coord[2] for coord in coordinates]

# Ensure equal scaling so distances are fixed across axes
x_min, x_max = (min(x_vals), max(x_vals)) if x_vals else (0, 1)
y_min, y_max = (min(y_vals), max(y_vals)) if y_vals else (0, 1)
z_min, z_max = (min(z_vals), max(z_vals)) if z_vals else (0, 1)
max_range = max(x_max - x_min, y_max - y_min, z_max - z_min)
x_mid = (x_max + x_min) / 2
y_mid = (y_max + y_min) / 2
z_mid = (z_max + z_min) / 2
half = max_range / 2 if max_range > 0 else 0.5
ax.set_xlim(x_mid - half, x_mid + half)
ax.set_ylim(y_mid - half, y_mid + half)
ax.set_zlim(z_mid - half, z_mid + half)
try:
    ax.set_box_aspect((1, 1, 1))
except Exception:
    pass

# 3D scatter plot
ax.scatter(x_vals, y_vals, z_vals, c='r', marker='o')

# Başlık ve etiketler
ax.set_title('3D Points')
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')

# Grafiği göster
plt.show()
