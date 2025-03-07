# Tarhana App

Tarhana, geleneksel Türk tarhanalarını keşfetmek, paylaşmak ve kaydetmek için tasarlanmış bir mobil uygulamadır.

## Özellikler

- Tarhana tariflerini görüntüleme
- Kendi tarhana tariflerinizi paylaşma
- Tarifleri favorilere ekleme
- Kullanıcı profili oluşturma ve yönetme
- Tarhana tariflerini arama ve filtreleme

## Mimari

Bu uygulama Clean Architecture prensiplerine göre geliştirilmiştir:

- **Presentation Layer**: UI bileşenleri, sayfalar ve state yönetimi (Riverpod)
- **Domain Layer**: İş mantığı, entity'ler ve repository arayüzleri
- **Data Layer**: Repository implementasyonları, veri kaynakları ve model sınıfları

### Klasör Yapısı

```
lib/
  ├── core/                  # Çekirdek bileşenler
  │   ├── constants/         # Sabitler
  │   ├── di/                # Dependency Injection
  │   ├── network/           # Ağ işlemleri
  │   ├── router/            # Routing
  │   ├── storage/           # Yerel depolama
  │   ├── theme/             # Tema
  │   ├── utils/             # Yardımcı fonksiyonlar
  │   └── widgets/           # Ortak widget'lar
  │
  ├── features/              # Uygulama özellikleri
  │   ├── auth/              # Kimlik doğrulama
  │   │   ├── data/          # Veri katmanı
  │   │   ├── domain/        # Domain katmanı
  │   │   └── presentation/  # Sunum katmanı
  │   │
  │   ├── home/              # Ana sayfa
  │   ├── profile/           # Profil
  │   └── settings/          # Ayarlar
  │
  └── main.dart              # Uygulama giriş noktası
```

## Kullanılan Teknolojiler

- **State Management**: Riverpod
- **Routing**: AutoRoute
- **Dependency Injection**: GetIt
- **Network**: Dio, Retrofit
- **Local Storage**: Hive, SharedPreferences
- **Code Generation**: Freezed, JSON Serializable
- **UI**: Material Design

## Kurulum

1. Flutter SDK'yı yükleyin
2. Projeyi klonlayın
3. Bağımlılıkları yükleyin:
   ```
   flutter pub get
   ```
4. Code generation için:
   ```
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
5. Uygulamayı çalıştırın:
   ```
   flutter run
   ```

## Geliştirme

- Yeni bir özellik eklemek için `features` klasörü altında yeni bir klasör oluşturun
- Her özellik için data, domain ve presentation katmanlarını oluşturun
- Ortak bileşenler için `core` klasörünü kullanın
