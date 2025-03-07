class Validators {
  static String? required(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'Bu alan gereklidir';
    }
    return null;
  }

  static String? email(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'E-posta adresi gereklidir';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return message ?? 'Geçerli bir e-posta adresi giriniz';
    }
    
    return null;
  }

  static String? password(String? value, {String? message, int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return message ?? 'Şifre gereklidir';
    }
    
    if (value.length < minLength) {
      return 'Şifre en az $minLength karakter olmalıdır';
    }
    
    return null;
  }

  static String? confirmPassword(String? value, String password, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'Şifre tekrarı gereklidir';
    }
    
    if (value != password) {
      return message ?? 'Şifreler eşleşmiyor';
    }
    
    return null;
  }

  static String? name(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'Ad soyad gereklidir';
    }
    
    if (value.length < 3) {
      return 'Ad soyad en az 3 karakter olmalıdır';
    }
    
    return null;
  }

  static String? phone(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'Telefon numarası gereklidir';
    }
    
    final phoneRegex = RegExp(r'^\d{10}$');
    if (!phoneRegex.hasMatch(value.replaceAll(RegExp(r'\D'), ''))) {
      return message ?? 'Geçerli bir telefon numarası giriniz';
    }
    
    return null;
  }

  static String? url(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'URL gereklidir';
    }
    
    final urlRegex = RegExp(
      r'^(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    
    if (!urlRegex.hasMatch(value)) {
      return message ?? 'Geçerli bir URL giriniz';
    }
    
    return null;
  }

  static String? minLength(String? value, int minLength, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'Bu alan gereklidir';
    }
    
    if (value.length < minLength) {
      return message ?? 'En az $minLength karakter giriniz';
    }
    
    return null;
  }

  static String? maxLength(String? value, int maxLength, {String? message}) {
    if (value == null || value.isEmpty) {
      return null; // Not required
    }
    
    if (value.length > maxLength) {
      return message ?? 'En fazla $maxLength karakter giriniz';
    }
    
    return null;
  }

  static String? numeric(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'Bu alan gereklidir';
    }
    
    final numericRegex = RegExp(r'^\d+$');
    if (!numericRegex.hasMatch(value)) {
      return message ?? 'Sadece rakam giriniz';
    }
    
    return null;
  }

  static String? decimal(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'Bu alan gereklidir';
    }
    
    final decimalRegex = RegExp(r'^\d+(\.\d+)?$');
    if (!decimalRegex.hasMatch(value)) {
      return message ?? 'Geçerli bir sayı giriniz';
    }
    
    return null;
  }

  static String? combine(String? value, List<String? Function(String?)> validators) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) {
        return error;
      }
    }
    
    return null;
  }
} 