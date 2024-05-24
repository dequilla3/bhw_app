import 'package:bhw_app/components/default_toolbar.dart';
import 'package:bhw_app/config/app_data_context.dart';
import 'package:bhw_app/pages/request/new_request_modal.dart';
import 'package:bhw_app/pages/request/request_details_screen.dart';
import 'package:bhw_app/provider/request_provider.dart';
import 'package:bhw_app/provider/user_provider.dart';
import 'package:bhw_app/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  ScrollController? scrollController;

  void scrollListener() {
    if (scrollController!.position.extentAfter < 500) {
      _loadRequest();
    }
  }

  Future<void> _loadRequest() async {
    context
        .read<RequestProvider>()
        .getUserRequest(context.read<UserProvider>().loggedInUserId!);
  }

  @override
  void initState() {
    super.initState();
    _loadRequest();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController?.removeListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    Widget statusIcon(String status) {
      if (status == 'APPROVED') {
        return const FaIcon(
          FontAwesomeIcons.thumbsUp,
          color: Colors.green,
          size: 16,
        );
      } else if (status == 'PENDING') {
        return const FaIcon(
          FontAwesomeIcons.clock,
          color: Colors.amber,
          size: 16,
        );
      } else {
        return const FaIcon(
          FontAwesomeIcons.xmark,
          color: Colors.red,
          size: 16,
        );
      }
    }

    return Scaffold(
      appBar: const DefaultToolBar(),
      body: RefreshIndicator(
        onRefresh: () => _loadRequest(),
        child: Consumer<RequestProvider>(
          builder: (context, value, child) {
            return Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount: value.requests.length,
                          itemBuilder: (context, index) {
                            var request = value.requests[index];
                            var isEmerg = request.requestType == "EMERGENCY";
                            String status = request.isApprove == null
                                ? "PENDING"
                                : request.isApprove!
                                    ? "APPROVED"
                                    : "REJECTED";

                            return ListTile(
                              onTap: () {
                                Future.delayed(
                                    const Duration(milliseconds: 150), () {
                                  value.userRequest = request;
                                  showModalBottomSheet(
                                    elevation: 1,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return const RequestDetailsScreen();
                                    },
                                  );
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
                                "${AppDataContext.getMedicines()[request.medRequestId].toString().split("-")[1]}",
                              ),
                              subtitle: Text(
                                request.reasonRequest,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.font2,
                                ),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: statusIcon(status),
                              ),
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
                      child: const FaIcon(FontAwesomeIcons.plus)),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
