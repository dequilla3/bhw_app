import 'package:bhw_app/provider/request_provider.dart';
import 'package:bhw_app/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appRepo = Provider.of<RequestProvider>(context);

    Widget renderRequestBadge(isEmerg) {
      return Padding(
        padding: const EdgeInsets.only(left: 16, top: 16),
        child: Container(
          decoration: BoxDecoration(
            color: isEmerg ? Colors.red : Colors.green,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              isEmerg ? 'EMERGENCY REQUEST' : 'NORMAL REQUEST',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      );
    }

    Widget renderApprovalBadge(status) {
      if (status == "PENDING") {
        return Padding(
          padding: const EdgeInsets.only(left: 8, top: 16),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'PENDING',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        );
      } else if (status == 'APPROVED') {
        return Padding(
          padding: const EdgeInsets.only(left: 8, top: 16),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'APPROVED',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(left: 8, top: 16),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'REJECTED',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Details'),
        // backgroundColor: AppColors.bgLight,
        foregroundColor: AppColors.font2,
      ),
      body: Column(
        children: [
          Row(
            children: [
              renderRequestBadge(appRepo.userRequest!.isEmergency),
              renderApprovalBadge(appRepo.userRequest!.status),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(appRepo.userRequest!.details),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
