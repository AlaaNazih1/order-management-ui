import '../models/order_model.dart';

const List<String> productTypes = <String>[
  'محفظة جلد',
  'حزام',
  'حقيبة',
  'حافظة بطاقات',
  'ميدالية جلد',
];

final List<OrderModel> mockOrders = <OrderModel>[
  OrderModel(
    customerName: 'سارة محمد',
    productType: 'محفظة جلد',
    status: OrderStatus.pending,
    expectedDelivery: DateTime(2026, 5, 14),
    details: 'لون بني داكن مع حفر الاسم بالأحرف الأولى.',
  ),
  OrderModel(
    customerName: 'أحمد خالد',
    productType: 'حزام',
    status: OrderStatus.inProgress,
    expectedDelivery: DateTime(2026, 5, 16),
    details: 'مقاس 42 مع إبزيم معدني كلاسيكي.',
  ),
  OrderModel(
    customerName: 'ريم عادل',
    productType: 'حقيبة',
    status: OrderStatus.completed,
    expectedDelivery: DateTime(2026, 5, 12),
    details: 'حقيبة عملية للاستخدام اليومي بجيوب داخلية متعددة.',
  ),
  OrderModel(
    customerName: 'محمود حسن',
    productType: 'محفظة جلد',
    status: OrderStatus.inProgress,
    expectedDelivery: DateTime(2026, 5, 18),
    details: 'إضافة خانة مخصصة للبطاقات مع خياطة بارزة.',
  ),
  OrderModel(
    customerName: 'نور سامي',
    productType: 'حافظة بطاقات',
    status: OrderStatus.pending,
    expectedDelivery: DateTime(2026, 5, 20),
    details: 'تصميم نحيف مناسب للجيب مع لون جملي.',
  ),
  OrderModel(
    customerName: 'ياسمين علي',
    productType: 'ميدالية جلد',
    status: OrderStatus.completed,
    expectedDelivery: DateTime(2026, 5, 11),
    details: 'حفر شعار بسيط مع حلقة معدنية مطفية.',
  ),
];
