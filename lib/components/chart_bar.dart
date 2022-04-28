import 'package:flutter/material.dart';
import 'package:personal_expense/core/app_colors.dart';

class ChartBarWidget extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBarWidget({
    required this.label,
    required this.value,
    required this.percentage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constrainsts) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              height: constrainsts.maxHeight * 0.15,
              child: FittedBox(
                child: Text('${value.toStringAsFixed(2)} '),
              ),
            ),
            SizedBox(height: constrainsts.maxHeight * 0.05),
            Container(
              padding: EdgeInsets.zero,
              height: constrainsts.maxHeight * 0.6,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        color: const Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.ligthColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: constrainsts.maxHeight * 0.05),
            Container(
              child: FittedBox(child: Text(label)),
              height: constrainsts.maxHeight * 0.15,
              padding: EdgeInsets.zero,
            ),
          ],
        );
      },
    );
  }
}
