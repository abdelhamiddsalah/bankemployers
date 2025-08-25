import 'package:bankemployers/features/home/widgets/list_view_employee_card.dart';
import 'package:flutter/material.dart';

class SectionEmployee extends StatelessWidget {
  const SectionEmployee({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Employees (${12})',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.refresh, color: Colors.grey[600]),
                    onPressed: () {
                   
                    },
                  ),
                  IconButton(
                    icon: Icon(
                   Icons.view_module,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                    
                   
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
    
     
        
          ListViewEmployeeCard(),
        ],
      ),
    );
  }
}
