class CartOrderDetailsArgs {
  final bool isItVisa;
  final bool isItWallet;
  final bool isItFawry;
  final String? walletNumber;

  CartOrderDetailsArgs({
    required this.isItVisa,
    required this.isItWallet,
    required this.isItFawry,
    this.walletNumber,
  });
}
