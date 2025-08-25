import 'package:bankemployers/features/home/widgets/employee_list_card.dart';
import 'package:flutter/material.dart';

class ListViewEmployeeCard extends StatelessWidget {
  const ListViewEmployeeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) {
     
        return EmployeeListCard( );
      },
    );
  }
}
