import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../data/mock_orders.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  String? _selectedProductType = productTypes.first;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _customerNameController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text('إضافة طلب جديد'),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: FilledButton(
          onPressed: _handleSaveOrder,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: const Text('حفظ الطلب'),
        ),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double horizontalPadding = constraints.maxWidth >= 900
                ? 32
                : constraints.maxWidth >= 600
                ? 24
                : 16;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 850),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    8,
                    horizontalPadding,
                    120,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: AppColors.cardShadow,
                          blurRadius: 24,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'بيانات الطلب',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'املأ الحقول التالية لإدخال طلب جديد بشكل منظم وواضح.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 24),
                          const _FieldLabel(title: 'اسم العميل'),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _customerNameController,
                            textInputAction: TextInputAction.next,
                            decoration: _inputDecoration(
                              hintText: 'أدخل اسم العميل',
                              prefixIcon: Icons.person_outline_rounded,
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'يرجى إدخال اسم العميل';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          const _FieldLabel(title: 'نوع المنتج'),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedProductType,
                            decoration: _inputDecoration(
                              hintText: 'اختر نوع المنتج',
                              prefixIcon: Icons.category_outlined,
                            ),
                            items: productTypes
                                .map(
                                  (String type) => DropdownMenuItem<String>(
                                    value: type,
                                    child: Text(type),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedProductType = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          const _FieldLabel(title: 'تاريخ التسليم'),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: _pickDate,
                            borderRadius: BorderRadius.circular(18),
                            child: InputDecorator(
                              decoration: _inputDecoration(
                                hintText: 'اختر تاريخ التسليم',
                                prefixIcon: Icons.calendar_today_outlined,
                              ),
                              child: Text(
                                _selectedDate == null
                                    ? 'حدد تاريخ التسليم المتوقع'
                                    : _formatDate(_selectedDate!),
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: _selectedDate == null
                                          ? AppColors.textSecondary
                                          : AppColors.textPrimary,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const _FieldLabel(title: 'التفاصيل أو المقاسات'),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _detailsController,
                            minLines: 4,
                            maxLines: 6,
                            decoration: _inputDecoration(
                              hintText:
                                  'اكتب تفاصيل الطلب أو المقاسات المطلوبة',
                              prefixIcon: Icons.notes_rounded,
                              alignLabelWithHint: true,
                            ),
                            validator: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'يرجى إدخال التفاصيل';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    bool alignLabelWithHint = false,
  }) {
    return InputDecoration(
      hintText: hintText,
      alignLabelWithHint: alignLabelWithHint,
      prefixIcon: Icon(prefixIcon, color: AppColors.textSecondary),
      filled: true,
      fillColor: AppColors.background,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year, now.month, now.day);
    final DateTime lastDate = DateTime(now.year + 2);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: const Locale('ar'),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _handleSaveOrder() {
    final bool isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار تاريخ التسليم')),
      );
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.textPrimary,
          content: Text(
            'تم حفظ الطلب بنجاح (عرض تجريبي فقط)',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ),
      );
  }

  String _formatDate(DateTime date) {
    const List<String> months = <String>[
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }
}
