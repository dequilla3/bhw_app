import 'package:bhw_app/components/new_request_modal.dart';
import 'package:bhw_app/config/app_routes.dart';
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
  Widget _statusIcon(String status) {
    if (status == 'APPROVED') {
      return const Icon(
        Icons.check,
        color: Colors.green,
        size: 16,
      );
    } else if (status == 'PENDING') {
      return const Icon(
        Icons.pending_actions,
        color: Colors.amber,
        size: 16,
      );
    } else {
      return const Icon(
        Icons.close,
        color: Colors.red,
        size: 16,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final RequestController requestController = Get.put(RequestController());

    var height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: height * 0.02),
          SizedBox(
            height: height * 0.75,
            child: Stack(
              children: [
                ListView.builder(
                    itemCount: requestController.requests.length,
                    itemBuilder: (context, index) {
                      var request = requestController.requests[index];
                      var isEmerg = request.isEmergency;

                      return ListTile(
                          onTap: () {
                            requestController.setUserRequest(request);

                            Navigator.of(context)
                                .pushNamed(AppRoutes.requestDetailsRoute);
                          },
                          leading: CircleAvatar(
                            backgroundColor:
                                isEmerg ? Colors.red : Colors.green,
                            child: isEmerg
                                ? const Text(
                                    'EMERG',
                                    style: TextStyle(fontSize: 10),
                                  )
                                : const Text(
                                    'NORM',
                                    style: TextStyle(fontSize: 10),
                                  ),
                          ),
                          title: Text(
                            request.details,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.font2,
                            ),
                          ),
                          trailing: _statusIcon(request.status));
                    }),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      showModalBottomSheet(
                        elevation: 1,
                        backgroundColor: Colors.transparent,
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return const NewRequestModal();
                        },
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
