import 'package:bankemployers/core/databases/api/dio_consumer.dart';
import 'package:bankemployers/core/styling/colors.dart';
import 'package:bankemployers/features/admin/data/models/all_cvs_model.dart';
import 'package:bankemployers/features/admin/data/repos/admin_repo.dart';
import 'package:bankemployers/features/admin/view/list_header.dart';
import 'package:bankemployers/features/admin/view/widgets/cv_datiles.dart';
import 'package:bankemployers/features/admin/view/widgets/stat_card.dart';
import 'package:bankemployers/features/admin/view/widgets/status_chip.dart';
import 'package:bankemployers/features/admin/viewmodel/cvs/cubit/cvs_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class AllCVsScreen extends StatefulWidget {
  const AllCVsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AllCVsScreenState createState() => _AllCVsScreenState();
}

class _AllCVsScreenState extends State<AllCVsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  String selectedFilter = 'All';
  TextEditingController searchController = TextEditingController();
  AllCvSModel? selectedCV;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CvsCubit(AdminRepo(dioConsumer: DioConsumer(dio: Dio()))),

      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: Transform.translate(
                offset: Offset(0, _slideAnimation.value),
                child: BlocBuilder<CvsCubit, CvsState>(
                  builder: (context, state) {
                    if (state is CvsSuccess) {
                      final List<AllCvSModel> cvs = state.allCvSModel;
                      List<AllCvSModel> filteredCVs = selectedFilter == 'All'
                          ? cvs
                          : cvs
                                .where((cv) => cv.resultCv == selectedFilter)
                                .toList();
                      return Row(
                        children: [
                          // Left Panel - CV List
                          Expanded(
                            flex: 5,
                            child: _buildCVListPanel(cvs, filteredCVs),
                          ),
                          // Right Panel - CV Details
                          Expanded(flex: 7, child: CVDetails(cv: selectedCV,)),
                        ],
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCVListPanel(
    List<AllCvSModel> cvs,
    List<AllCvSModel> filteredCVs,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [maincolor, Color(0xFF8B5CF6)],
        ),
      ),
      child: Column(
        children: [
          ListHeader(cvs: cvs),

          _buildStatsCards(cvs),
          Expanded(child: _buildCVList(filteredCVs)),
        ],
      ),
    );
  }

  Widget _buildStatsCards(List<AllCvSModel> cvs) {
    final approvedCount = cvs.where((cv) => cv.resultCv == 'approved').length;
    final waitingCount = cvs.where((cv) => cv.resultCv == 'Waiting').length;
    final rejectedCount = cvs.where((cv) => cv.resultCv == 'rejected').length;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: StatCard(title: 'approved', count: approvedCount, icon: Icons.check_circle, onTap: () => setState(() => selectedFilter = 'approved')),
          ),
          SizedBox(width: 8),
          Expanded(
            child: StatCard(title: 'Waiting', count: waitingCount, icon: Icons.pending, onTap: () => setState(() => selectedFilter = 'Waiting')),
          ),
          SizedBox(width: 8),
          Expanded(
            child: StatCard(title: 'Rejected', count: rejectedCount, icon: Icons.pending, onTap: () => setState(() => selectedFilter = 'rejected')),
          ),
        ],
      ),
    );
  }

  Widget _buildCVList(List<AllCvSModel> filteredCVs) {
    if (filteredCVs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description_outlined,
              size: 64,
              color: Colors.white.withOpacity(0.5),
            ),
            SizedBox(height: 16),
            Text(
              'No CVs found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: filteredCVs.length,
      itemBuilder: (context, index) {
        final cv = filteredCVs[index];
        final isSelected = selectedCV?.id == cv.id;
        return _buildCVListItem(cv, isSelected);
      },
    );
  }

  Widget _buildCVListItem(AllCvSModel cv, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected
                ? maincolor.withOpacity(0.2)
                : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.description,
            color: isSelected ? maincolor : Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          cv.file,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.black87 : Colors.white,
            fontSize: 14,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID: ${cv.id}',
              style: TextStyle(
                color: isSelected
                    ? Colors.grey[600]
                    : Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
            SizedBox(height: 4),
            StatusChip(status: cv.resultCv, isSelected: isSelected),
          ],
        ),
        onTap: () {
          setState(() {
            selectedCV = cv;
          });
          HapticFeedback.selectionClick();
        },
      ),
    );
  }


}
