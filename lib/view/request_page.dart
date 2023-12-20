import 'package:bhw_app/components/circle.dart';
import 'package:bhw_app/controller/request_controller.dart';
import 'package:bhw_app/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestController>(
      init: RequestController(),
      builder: (requestController) {
        return Stack(
          children: [
            ListView.builder(
                itemCount: requestController.requests.length,
                itemBuilder: (context, index) {
                  var _request = requestController.requests[index];

                  return ListTile(
                    title: Text(
                      _request.details,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Circle(
                      color:
                          _request.isEmergency ? Colors.red : AppColors.primary,
                    ),
                  );
                }),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: AppColors.primary,
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
            )
          ],
        );
      },
    );
  }
}
