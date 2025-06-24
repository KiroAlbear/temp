class CartOrderDetailsArgs {
  final bool isItVisa;
  final bool isItWallet;
  final String? walletNumber;

  CartOrderDetailsArgs({
    required this.isItVisa,
    required this.isItWallet,
    this.walletNumber,
  });
}