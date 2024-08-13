class OffersMapper {
  final String userId;
  String profileLogo;
  final String accountBalance;

  OffersMapper(
      {required this.userId,
      required this.profileLogo,
      this.accountBalance = '-1190 ج.م.'});

  void updateImage(String imageUrl) {
    profileLogo = imageUrl;
  }
}
