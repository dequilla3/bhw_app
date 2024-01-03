import 'package:bhw_app/components/new_request_modal.dart';
import 'package:bhw_app/config/app_routes.dart';
import 'package:bhw_app/provider/request_provider.dart';
import 'package:bhw_app/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

  getScreenHeight(height) {
    if (height > 900) {
      return height * 0.85;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Consumer<RequestProvider>(
      builder: (context, value, child) {
        return Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 8),
                SizedBox(
                  height: height * 0.75,
                  child: ListView.builder(
                      itemCount: value.requests.length,
                      itemBuilder: (context, index) {
                        var request = value.requests[index];
                        var isEmerg = request.isEmergency;

                        return ListTile(
                          onTap: () {
                            Future.delayed(const Duration(milliseconds: 150),
                                () {
                              value.userRequest = request;
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.requestDetailsRoute);
                            });
                          },
                          leading: CircleAvatar(
                            foregroundColor: Colors.white,
                            backgroundColor: isEmerg
                                ? const Color.fromARGB(255, 218, 96, 87)
                                : Colors.blue,
                            child: isEmerg
                                ? const Text(
                                    'EMERG',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  )
                                : const Text(
                                    'NORM',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                          ),
                          isThreeLine: true,
                          title: Text(
                              DateFormat.yMMMd().format(request.dateCreated)),
                          subtitle: Text(
                            request.details,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.font2,
                            ),
                          ),
                          trailing: _statusIcon(request.status),
                        );
                      }),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    elevation: 1,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return const NewRequestModal();
                    },
                  );
                },
                child: const Icon(Icons.add),
              ),
            )
          ],
        );
      },
    );
  }
}
