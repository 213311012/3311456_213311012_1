class Hatalar {
  static String goster(String hataKodu) {
    switch (hataKodu) {
      case 'email-already-in-use':
        return "Bu mail adresi zaten kullanımda, lütfen farklı bir mail kullanınız";

      case 'user-not-found':
        return "Bu kullanıcı sistemde bulunmamaktadır. Lütfen önce kullanıcı oluşturunuz";
      case 'too-many-requests':
        return "Yavaş gırdın gırdın, az bekle sonra tekrar denersin";
      case 'wrong-password':
        return "Email veya şifre yanlış";
      default:
        return "Bir hata olustu";
    }
  }
}
