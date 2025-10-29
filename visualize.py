import math
import numpy as np
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

R = 100
r = 50
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
            points.append(Point3D(x, z, y))
            tempB += beta
        tempA += alpha
    
    newPoints = givePerspective(points)
    printPoints(newPoints)
    
    # MATLAB görselleştirme
    visualize_with_matplotlib(newPoints)

def givePerspective(points):
    newPoints = []
    for p in points:
        try:
            z = p.z + R + r + 1
            z = z // 10
            
            x = p.x // z
            y = p.y // z
            
            index = -1
            for i, np in enumerate(newPoints):
                if np.x == x and np.y == y:
                    index = i
                    break
            
            if index == -1:
                newPoints.append(Point3D(x, y, p.z))
            else:
                if newPoints[index].z < p.z:
                    newPoints[index] = Point3D(x, y, p.z)
        except Exception as e:
            print(e)
    
    return newPoints

def cakisanlariTemizle(points):
    pass

def printPoints(points):
    for p in points:
        print(str(p))

def calculateMinMax(points):
    maxX = -1000000
    maxY = -1000000
    maxZ = -1000000
    minX = 1000000
    minY = 1000000
    minZ = 1000000
    
    for p in points:
        if p.x > maxX:
            maxX = p.x
        if p.y > maxY:
            maxY = p.y
        if p.z > maxZ:
            maxZ = p.z
        if p.x < minX:
            minX = p.x
        if p.y < minY:
            minY = p.y
        if p.z < minZ:
            minZ = p.z
    
    print(maxX)
    print(minX)
    print('***************')
    print(maxY)
    print(minY)
    print('***************')
    print(maxZ)
    print(minZ)

def visualize_with_matplotlib(points):
    """MATLAB benzeri görselleştirme"""
    if not points:
        print("Görselleştirilecek nokta yok")
        return
    
    # Noktaları dizilere dönüştür
    xs = [p.x for p in points]
    ys = [p.y for p in points]
    zs = [p.z for p in points]
    
    # 2D scatter plot
    plt.figure(figsize=(12, 5))
    
    # Sol taraf: X-Y düzlemi
    plt.subplot(1, 2, 1)
    scatter = plt.scatter(xs, ys, c=zs, cmap='viridis', s=50, alpha=0.6)
    plt.colorbar(scatter, label='Z değeri')
    plt.xlabel('X')
    plt.ylabel('Y')
    plt.title('2D Projeksiyon (X-Y) - Renk: Z derinliği')
    plt.grid(True, alpha=0.3)
    plt.axis('equal')
    
    # Sağ taraf: 3D scatter plot
    ax = plt.subplot(1, 2, 2, projection='3d')
    scatter = ax.scatter(xs, ys, zs, c=zs, cmap='viridis', s=20, alpha=0.6)
    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_zlabel('Z')
    ax.set_title('3D Görünüm')
    plt.colorbar(scatter, ax=ax, label='Z değeri', shrink=0.5)
    
    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    main()