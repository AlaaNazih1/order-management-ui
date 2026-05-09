import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../data/mock_orders.dart';
import '../models/order_model.dart';
import '../widgets/order_card.dart';
import '../widgets/summary_card.dart';
import 'add_order_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int totalOrders = mockOrders.length;
    final int inProgressOrders = mockOrders
        .where((OrderModel order) => order.status == OrderStatus.inProgress)
        .length;

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const AddOrderScreen()),
          );
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('إضافة طلب'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double horizontalPadding = constraints.maxWidth >= 900
                ? 32
                : constraints.maxWidth >= 600
                ? 24
                : 16;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 12),
                      Text(
                        'إدارة الطلبات',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'تابع حالة الطلبات اليومية وابدأ طلباً جديداً بسهولة.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: SummaryCard(
                              title: 'إجمالي الطلبات',
                              value: '$totalOrders',
                              icon: Icons.receipt_long_rounded,
                              highlightColor: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: SummaryCard(
                              title: 'الطلبات قيد التنفيذ',
                              value: '$inProgressOrders',
                              icon: Icons.pending_actions_rounded,
                              highlightColor: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'قائمة الطلبات',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.only(bottom: 96),
                          itemCount: mockOrders.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 14),
                          itemBuilder: (BuildContext context, int index) {
                            return OrderCard(order: mockOrders[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
