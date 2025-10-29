import math
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

class Point3D:
    _counter = 0
    
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z
        self.id = Point3D._counter
        Point3D._counter += 1
    
    def __str__(self):
        return f"({self.x}, {self.y}, {self.z}) id: {self.id}"

R = 10
r = 5
alpha = 0.1
beta = 0.1

def main():
    points = []
    
    tempA = 0
    while tempA < 2 * math.pi:
        tempB = 0
        while tempB < 2 * math.pi:
            x = round((R + (r * math.cos(tempA))) * math.cos(tempB))
            y = round((R + (r * math.cos(tempA))) * math.sin(tempB))
            z = round(r * math.sin(tempA))
            points.append(Point3D(x,y,z ))
            tempB += beta
        tempA += alpha
    
    printPoints(points)
    visualize_3d(points)

def printPoints(points):
    for p in points:
        print(str(p))

def visualize_3d(points):
    """3D noktaları MATLAB tarzında görselleştir"""
    
    # Noktaları listelere dönüştür
    xs = [p.x for p in points]
    ys = [p.y for p in points]
    zs = [p.z for p in points]
    
    # 3D figure oluştur
    fig = plt.figure(figsize=(12, 9))
    ax = fig.add_subplot(111, projection='3d')
    
    # 3D scatter plot
    scatter = ax.scatter(xs, ys, zs, 
                        c=ys,  # Z değerine göre renklendirme
                        cmap='viridis',  # MATLAB benzeri renk paleti
                        s=30,  # Nokta boyutu
                        alpha=0.8,  # Şeffaflık
                        edgecolors='black',  # Nokta kenarları
                        linewidth=0.5)
    
    # Eksen etiketleri
    ax.set_xlabel('X', fontsize=12, fontweight='bold')
    ax.set_ylabel('Z', fontsize=12, fontweight='bold')
    ax.set_zlabel('Y', fontsize=12, fontweight='bold')
    
    # Başlık
    ax.set_title('3D Torus (Donut) Noktaları', fontsize=14, fontweight='bold')
    
    # Renk çubuğu ekle
    colorbar = plt.colorbar(scatter, ax=ax, pad=0.1, shrink=0.8)
    colorbar.set_label('Z Değeri', fontsize=10)
    
    # Grid ekle
    ax.grid(True, alpha=0.3)
    
    # Eksen oranlarını eşitle
    max_range = max(max(xs) - min(xs), max(ys) - min(ys), max(zs) - min(zs)) / 2
    mid_x = (max(xs) + min(xs)) / 2
    mid_y = (max(ys) + min(ys)) / 2
    mid_z = (max(zs) + min(zs)) / 2
    ax.set_xlim(mid_x - max_range, mid_x + max_range)
    ax.set_ylim(mid_y - max_range, mid_y + max_range)
    ax.set_zlim(mid_z - max_range, mid_z + max_range)
    
    # Görünüm açısını ayarla (MATLAB benzeri)
    ax.view_init(elev=20, azim=45)
    
    # Arka plan rengi
    ax.xaxis.pane.fill = False
    ax.yaxis.pane.fill = False
    ax.zaxis.pane.fill = False
    
    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    main()