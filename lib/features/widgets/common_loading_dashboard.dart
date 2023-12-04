import 'package:flutter/material.dart';
import 'package:live_chat_app/routes/route.dart';
import 'package:skeleton_text/skeleton_text.dart';

class CommonLoadingDashboard extends StatefulWidget {
  const CommonLoadingDashboard({super.key});

  @override
  State<CommonLoadingDashboard> createState() => _CommonLoadingDashboardState();
}

class _CommonLoadingDashboardState extends State<CommonLoadingDashboard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonAnimation(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                height: Go.height / 3,
                width: Go.width / 4,
              )),
              SkeletonAnimation(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                height: Go.height / 3,
                width: Go.width / 4,
              )),
              SkeletonAnimation(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                height: Go.height / 3,
                width: Go.width / 4,
              ))
            ],
          ),
          const SizedBox(height: 30),
          SkeletonAnimation(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade200,
            ),
            height: Go.height / 8,
            width: Go.width / 1,
          )),
          const SizedBox(height: 20),
          SkeletonAnimation(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade200,
            ),
            height: Go.height / 8,
            width: Go.width / 1,
          )),
        ],
      ),
    );
  }
}
