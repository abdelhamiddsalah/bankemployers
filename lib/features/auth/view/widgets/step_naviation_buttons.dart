// widgets/step_navigation_buttons.dart
import 'package:bankemployers/core/styling/colors.dart';
import 'package:flutter/material.dart';

class StepNavigationButtons extends StatelessWidget {
  final int currentStep;
  final bool isLoading;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onSubmit;

  const StepNavigationButtons({
    super.key,
    required this.currentStep,
    required this.isLoading,
    required this.onPrevious,
    required this.onNext,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Row(
        children: [
          // Previous Button
          if (currentStep > 0) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: onPrevious,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: maincolor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Previous',
                  style: TextStyle(color: maincolor, fontSize: 16),
                ),
              ),
            ),
            SizedBox(width: 16),
          ],
          
          // Next/Submit Button
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: isLoading ? null : (currentStep == 2 ? onSubmit : onNext),
              style: ElevatedButton.styleFrom(
                backgroundColor: maincolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: _buildButtonContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ),
          SizedBox(width: 12),
          Text(
            'Creating Account...',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      );
    }

    return Text(
      currentStep == 2 ? 'Create Account' : 'Next',
      style: TextStyle(fontSize: 16, color: Colors.white),
    );
  }
}