# Terminal Donut - Dart

Bu proje terminal üzerinde 3D bir donut (torus) nokta bulutu oluşturan basit bir Dart uygulamasıdır. Kod, torus yüzeyindeki noktaları hesaplar ve koordinatları terminale yazdırır.  

## Dosyalar

- `core/` → 3D noktaları temsil eden sınıf ve yardımcı fonksiyonlar.
- `core/main.dart` → torus noktalarını hesaplayan ve yazdıran ana dosya.
- `helper/visualize_points.py.dart` → torus noktalarını görselleştiren dosya.


## Kullanım

```bash
dart core/main.dart > core/o.txt
python3 helper/visualize_points.py
```
