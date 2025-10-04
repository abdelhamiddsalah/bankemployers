
import 'package:flutter/material.dart';

class RejectedWidget extends StatelessWidget {
  const RejectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.cancel_outlined,
              size: 80,
              color: Colors.red.shade600,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "Application Not Approved",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "Unfortunately, your CV doesn't meet our current requirements.\nDon't worry, you can try again!",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey.shade600,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // إعادة تحميل الصفحة أو العودة لرفع CV جديد
                },
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text(
                  "Try Again",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              OutlinedButton.icon(
                onPressed: () {
                  // التواصل مع الدعم
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Contact Support"),
                      content: const Text(
                        "For assistance, please contact HR at:\nhr@bankemployers.com\n\nOr call: +20 123 456 789",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.support_agent, color: Colors.grey.shade700),
                label: Text(
                  "Contact Support",
                  style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: Colors.grey.shade400),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
