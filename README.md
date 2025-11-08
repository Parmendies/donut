# Terminal Donut - Dart

Bu proje terminal üzerinde 3D bir donut (torus) nokta bulutu oluşturan basit bir Dart uygulamasıdır. Kod, torus yüzeyindeki noktaları hesaplar ve koordinatları terminale yazdırır.  

## Dosyalar

- `main.dart` → Ana program 
- `config.dart` → Donut parametreleri 
- `core/point3d.dart` → 3D noktaları temsil eden basit bir sınıf 
- `core/math_utils.dart` → torus noktalarını hesaplar eksenler etrafında rotasyon yapar.
- `core/visualize.dart` → perspektif ve derinlik hesaplamalarını yapar 
- `core/data_proccess.dart` → verileri yuvarlayan ve arkada kalan noktaları çıkartan yardımcı fonksiyonlar 



## Kullanım

```bash
dart core/main.dart 
```
