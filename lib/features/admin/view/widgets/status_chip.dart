
import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.status,
    required this.isSelected,
  });

  final String status;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    Color color = status == 'approved'
        ? Colors.green
        : status == 'Waiting'
        ? Colors.orange
        : Colors.red;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected
            ? color.withOpacity(0.1)
            : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status == 'approved'
            ? 'approved'
            : status == 'Waiting'
            ? 'waiting'
            : 'rejected',
        style: TextStyle(
          color: isSelected ? color : Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
