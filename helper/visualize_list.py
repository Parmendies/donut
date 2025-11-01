import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# o_list.txt dosyasından veri oku ve parse et
def parse_dart_output(filename="o_list.txt"):
    """o_list.txt çıktısını parse eder"""
    points = []
    
    with open(filename, 'r') as f:
        content = f.read()
        
    # (x, y, z) formatındaki tüm noktaları bul
    import re
    pattern = r'\((\d+\.?\d*),\s*(\d+\.?\d*),\s*(\d+\.?\d*)\)'
    matches = re.findall(pattern, content)
    
    for match in matches:
        x, y, z = float(match[0]), float(match[1]), float(match[2])
        points.append([x, y, z])
    
    return np.array(points)

# 3D Görselleştirme
def visualize_3d_points(points, title="3D Nokta Bulutu"):
    """3D noktaları görselleştirir"""
    
    fig = plt.figure(figsize=(15, 10))
    
    # 1. Subplot: Scatter plot (Y değerine göre renkli)
    ax1 = fig.add_subplot(221, projection='3d')
    scatter = ax1.scatter(points[:, 0], points[:, 1], points[:, 2],
                         c=points[:, 1], cmap='viridis', s=20, alpha=0.6)
    
    ax1.set_xlabel('X')
    ax1.set_ylabel('Y (Derinlik)')
    ax1.set_zlabel('Z')
    ax1.set_title('Y Değerine Göre Renklendirilmiş')
    plt.colorbar(scatter, ax=ax1, label='Y Değeri')
    
    # 2. Subplot: Surface benzeri görünüm
    ax2 = fig.add_subplot(222, projection='3d')
    x_unique = np.unique(points[:, 0])
    z_unique = np.unique(points[:, 2])
    grid = np.full((len(x_unique), len(z_unique)), np.nan)
    
    for i, x in enumerate(x_unique):
        for j, z in enumerate(z_unique):
            mask = (points[:, 0] == x) & (points[:, 2] == z)
            if np.any(mask):
                grid[i, j] = np.max(points[mask, 1])
    
    X, Z = np.meshgrid(x_unique, z_unique)
    surf = ax2.plot_surface(X, Z, grid.T, cmap='coolwarm', alpha=0.8)
    ax2.set_xlabel('X')
    ax2.set_ylabel('Z')
    ax2.set_zlabel('Y (Derinlik)')
    ax2.set_title('Yüzey Görünümü')
    plt.colorbar(surf, ax=ax2, label='Y Değeri')
    
    # 3. Subplot: Yukarıdan bakış
    ax3 = fig.add_subplot(223)
    scatter2d = ax3.scatter(points[:, 0], points[:, 2],
                           c=points[:, 1], cmap='viridis', s=10, alpha=0.6)
    ax3.set_xlabel('X')
    ax3.set_ylabel('Z')
    ax3.set_title('Yukarıdan Bakış (X-Z Düzlemi)')
    ax3.grid(True, alpha=0.3)
    plt.colorbar(scatter2d, ax=ax3, label='Y Değeri')
    
    # 4. Subplot: Histogram
    ax4 = fig.add_subplot(224)
    ax4.hist(points[:, 1], bins=20, color='skyblue', edgecolor='black')
    ax4.set_xlabel('Y Değeri (Derinlik)')
    ax4.set_ylabel('Nokta Sayısı')
    ax4.set_title('Y Değeri Dağılımı')
    ax4.grid(True, alpha=0.3)
    
    plt.tight_layout()
    plt.suptitle(title, fontsize=16, y=1.02)
    plt.show()
    
    # İstatistikler
    print("\n" + "="*50)
    print("NOKTA BULUTU İSTATİSTİKLERİ")
    print("="*50)
    print(f"Toplam nokta sayısı: {len(points)}")
    print(f"\nX aralığı: {points[:, 0].min():.2f} - {points[:, 0].max():.2f}")
    print(f"Y aralığı: {points[:, 1].min():.2f} - {points[:, 1].max():.2f}")
    print(f"Z aralığı: {points[:, 2].min():.2f} - {points[:, 2].max():.2f}")
    print(f"\nOrtalama Y değeri: {points[:, 1].mean():.2f}")
    print(f"Y standart sapması: {points[:, 1].std():.2f}")

# İnteraktif 3D görselleştirme
def visualize_interactive_3d(points):
    """Döndürülebilir 3D görselleştirme"""
    fig = plt.figure(figsize=(12, 9))
    ax = fig.add_subplot(111, projection='3d')
    scatter = ax.scatter(points[:, 0], points[:, 1], points[:, 2],
                        c=points[:, 1], cmap='plasma',
                        s=30, alpha=0.7, edgecolors='w', linewidth=0.5)
    ax.set_xlabel('X Ekseni')
    ax.set_ylabel('Y Ekseni (Derinlik)')
    ax.set_zlabel('Z Ekseni')
    ax.set_title('3D Torus Nokta Bulutu')
    plt.colorbar(scatter, ax=ax, pad=0.1, shrink=0.8, label='Y Değeri (Derinlik)')
    ax.grid(True, alpha=0.3)
    ax.view_init(elev=20, azim=45)
    plt.tight_layout()
    plt.show()

# Ana program
if __name__ == "__main__":
    try:
        points = parse_dart_output("o_list.txt")
        print(f"{len(points)} nokta yüklendi o_list.txt'den.")
    except FileNotFoundError:
        print("⚠️ 'o_list.txt' bulunamadı! Lütfen dosyayı bu klasöre ekleyin.")
        exit()
    
    visualize_3d_points(points, "o_list.txt - 3D Nokta Bulutu Görselleştirmesi")
    visualize_interactive_3d(points)
