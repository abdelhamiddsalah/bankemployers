// ignore_for_file: must_be_immutable

import 'package:bankemployers/core/styling/colors.dart';
import 'package:flutter/material.dart';

class RoleCard extends StatelessWidget {
  RoleCard({
    super.key, required this.title,
     required this.subtitle,
      required this.icon, 
      required this.role, 
      required this.isHovering, 
      required this.onHover, 
      required this.isMobile, required this.onRoleSelected,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final String role;
  final bool isHovering;
  final Function(bool) onHover;
  final bool isMobile;
  String? _selectedRole;
  final Function(String) onRoleSelected;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: () => onRoleSelected(role),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          constraints: BoxConstraints(
            minHeight: isMobile ? 200 : 260,
            maxHeight: isMobile ? 220 : 300,
          ),
          width: isMobile ? double.infinity : null,
          padding: EdgeInsets.all(isMobile ? 20 : 30),
          decoration: BoxDecoration(
            color: _selectedRole == role
                ? maincolor.withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _selectedRole == role
                  ? maincolor
                  : isHovering
                      ? maincolor.withOpacity(0.3)
                      : Colors.grey[300]!,
              width: _selectedRole == role ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovering
                    ? maincolor.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                blurRadius: isHovering ? 20 : 10,
                offset: Offset(0, isHovering ? 10 : 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: isMobile ? 60 : 80,
                height: isMobile ? 60 : 80,
                decoration: BoxDecoration(
                  color: _selectedRole == role
                      ? maincolor
                      : isHovering
                          ? maincolor.withOpacity(0.1)
                          : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  icon,
                  size: isMobile ? 30 : 40,
                  color: _selectedRole == role
                      ? Colors.white
                      : isHovering
                          ? maincolor
                          : Colors.grey[600],
                ),
              ),
              SizedBox(height: isMobile ? 12 : 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 20,
                  fontWeight: FontWeight.bold,
                  color: _selectedRole == role ? maincolor : Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 8 : 12),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: isMobile ? 12 : 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: isMobile ? 12 : 20),
              _selectedRole == role
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: maincolor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Selected',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }
}