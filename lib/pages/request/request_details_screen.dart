import 'package:bhw_app/config/app_data_context.dart';
import 'package:bhw_app/provider/request_provider.dart';
import 'package:bhw_app/style/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    String status = requestProvider.userRequest?.isApprove == null
        ? "PENDING"
        : requestProvider.userRequest!.isApprove!
            ? "APPROVED"
            : "REJECTED";

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

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        children: [
          const FaIcon(FontAwesomeIcons.gripLines),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Details",
                style: AppText.header3,
              ),
            ),
          ),
          Row(
            children: [
              renderRequestBadge(
                  requestProvider.userRequest!.requestType == "EMERGENCY"),
              renderApprovalBadge(status),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppDataContext.getMedicines()[requestProvider.userRequest!.medRequestId].toString().split("-")[1],
                    style: AppText.header3,
                  ),
                  Text(
                    requestProvider.userRequest!.reasonRequest,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
