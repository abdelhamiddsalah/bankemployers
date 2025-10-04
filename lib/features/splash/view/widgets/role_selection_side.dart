import 'package:bankemployers/features/splash/view/widgets/role_card.dart';
import 'package:flutter/material.dart';

class RoleSelectionSide extends StatefulWidget {
  const RoleSelectionSide({super.key, required this.isMobile, required this.fadeAnimation, required this.slideAnimation, required this.onRoleSelected ,});
  final bool isMobile;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final Function(String) onRoleSelected;
  @override
  State<RoleSelectionSide> createState() => _RoleSelectionSideState();
}
 bool _isHoveringEmployer = false;
  bool _isHoveringAdmin = false;
class _RoleSelectionSideState extends State<RoleSelectionSide> {
  @override
  Widget build(BuildContext context) {
    return widget.isMobile
        ? Container(
            color: Colors.white,
            padding: EdgeInsets.all(30),
            child: SlideTransition(
              position: widget.slideAnimation,
              child: FadeTransition(
                opacity: widget.fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Header
                    Text(
                      'Welcome to Bank System',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Please select your role to continue',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),

                    // Role Selection Cards
                    RoleCard(
                      title: 'Employee/Employer',
                      subtitle:
                          'Access employee portal and manage your account',
                      icon: Icons.business_center,
                      role: 'employer',
                      isHovering: _isHoveringEmployer,
                      onHover: (hovering) =>
                          setState(() => _isHoveringEmployer = hovering),
                      isMobile: widget.isMobile,
                      onRoleSelected:widget.onRoleSelected ,
                    ),
                    SizedBox(height: 20),
                    RoleCard(
                      title: 'Administrator',
                      subtitle:
                          'Full system access and administrative controls',
                      icon: Icons.admin_panel_settings,
                      role: 'admin',
                      isHovering: _isHoveringAdmin,
                      onHover: (hovering) =>
                          setState(() => _isHoveringAdmin = hovering),
                      isMobile: widget.isMobile,
                      onRoleSelected: widget.onRoleSelected,
                    ),

                    SizedBox(height: 30),

                    // Help Text
                    Text(
                      'Need help? Contact your system administrator',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          )
        : Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: SlideTransition(
                position: widget.slideAnimation,
                child: FadeTransition(
                  opacity: widget.fadeAnimation,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Header
                          Text(
                            'Welcome to Bank System',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Please select your role to continue',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 60),

                          // Role Selection Cards
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: RoleCard(
                                  title: 'Employer',
                                  subtitle: 'Access your account',
                                  icon: Icons.business_center,
                                  role: 'employer',
                                  isHovering: _isHoveringEmployer,
                                  onHover: (hovering) => setState(
                                    () => _isHoveringEmployer = hovering,
                                  ),
                                  isMobile: widget.isMobile,
                                  onRoleSelected: widget.onRoleSelected,
                                ),
                              ),
                              SizedBox(width: 30),
                              Expanded(
                                child: RoleCard(
                                  title: 'Administrator',
                                  subtitle:
                                      'Full system access and administrative controls',
                                  icon: Icons.admin_panel_settings,
                                  role: 'admin',
                                  isHovering: _isHoveringAdmin,
                                  onHover: (hovering) => setState(
                                    () => _isHoveringAdmin = hovering,
                                  ),
                                  isMobile: widget.isMobile,
                                  onRoleSelected: widget.onRoleSelected,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          // Help Text
                          Text(
                            'Need help? Contact your system administrator',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
