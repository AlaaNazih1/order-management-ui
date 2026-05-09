enum OrderStatus { pending, inProgress, completed }

class OrderModel {
  const OrderModel({
    required this.customerName,
    required this.productType,
    required this.status,
    required this.expectedDelivery,
    required this.details,
  });

  final String customerName;
  final String productType;
  final OrderStatus status;
  final DateTime expectedDelivery;
  final String details;
}

extension OrderStatusX on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.pending:
        return 'قيد الانتظار';
      case OrderStatus.inProgress:
        return 'جاري التنفيذ';
      case OrderStatus.completed:
        return 'مكتمل';
    }
  }
}
