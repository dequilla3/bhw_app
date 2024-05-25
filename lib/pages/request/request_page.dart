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

const List<String> list = <String>['PENDING', 'APPROVED', 'REJECTED'];

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  ScrollController? scrollController;
  final searchController = TextEditingController();
  final searchFocus = FocusNode();
  String dropdownValue = list.first;

  void scrollListener() {
    if (scrollController!.position.extentAfter < 500) {
      _loadRequest();
    }
  }

  Future<void> _loadRequest() async {
    context.read<RequestProvider>().getUserRequest(
        context.read<UserProvider>().loggedInUserId!, dropdownValue);
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
    final userProvider = context.read<UserProvider>();
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

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
      appBar: DefaultToolBar(
        title: "My Requests",
        userName: context.read<UserProvider>().userName,
      ),
      body: RefreshIndicator(
        onRefresh: () => _loadRequest(),
        child: Consumer<RequestProvider>(
          builder: (context, reqProvider, child) {
            var users = userProvider.filterUserByName(searchController.text);
            return Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          DropdownMenu<String>(
                            initialSelection: list.first,
                            onSelected: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                                reqProvider.filterRequest(
                                    searchController.text,
                                    users,
                                    dropdownValue,
                                    context
                                        .read<UserProvider>()
                                        .loggedInUserId!,
                                    false);
                              });
                            },
                            dropdownMenuEntries: list
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList(),
                            width: screenWidth / 3,
                            textStyle: const TextStyle(fontSize: 9),
                          ),
                          const SizedBox(width: 4)
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount: reqProvider.filteredRequests.length,
                          itemBuilder: (context, index) {
                            var request = reqProvider.filteredRequests[index];
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
                                  reqProvider.userRequest = request;
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
                                AppDataContext.getMedicines()[
                                        request.medRequestId]
                                    .toString()
                                    .split("-")[1],
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
