enum PaymentType {
  cash,
  bankCard,
  wallet,
  fawry,
}

extension PaymentTypeX on PaymentType {
  int get id {
    switch (this) {
      case PaymentType.cash:
        return 1;
      case PaymentType.bankCard:
        return 2;
      case PaymentType.wallet:
        return 3;
      case PaymentType.fawry:
        return 4;
    }
  }

  static PaymentType? fromId(int? id) {
    switch (id) {
      case 1:
        return PaymentType.cash;
      case 2:
        return PaymentType.bankCard;
      case 3:
        return PaymentType.wallet;
      case 4:
        return PaymentType.fawry;
      default:
        return null;
    }
  }
}

class PaymentVisibilityResponseModel {
  int? id;
  int? type;
  bool? visible;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  PaymentVisibilityResponseModel({
    this.id,
    this.type,
    this.visible,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  PaymentVisibilityResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    visible = json['visible'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
  }
}

class PaymentVisibilityMapper {
  final PaymentType type;
  final bool visible;

  PaymentVisibilityMapper({required this.type, required this.visible});
}
