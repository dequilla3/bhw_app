import 'package:bhw_app/components/app_text_field.dart';
import 'package:bhw_app/config/app_data_context.dart';
import 'package:bhw_app/config/app_routes.dart';
import 'package:bhw_app/data/model/user.dart';
import 'package:bhw_app/provider/request_provider.dart';
import 'package:bhw_app/provider/user_provider.dart';
import 'package:bhw_app/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RequestApprovalPage extends StatefulWidget {
  const RequestApprovalPage({super.key});

  @override
  State<RequestApprovalPage> createState() => _RequestApprovalPageState();
}

class _RequestApprovalPageState extends State<RequestApprovalPage> {
  final searchController = TextEditingController();
  final searchFocus = FocusNode();

  ScrollController? scrollController;

  Future<void> _loadPendingRequests() async {
    context
        .read<UserProvider>()
        .getUsers()
        .then((value) => context.read<RequestProvider>().getMedecineRequest());
  }

  void scrollListener() {
    if (scrollController!.position.extentAfter < 500) {
      _loadPendingRequests();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPendingRequests();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

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
      body: RefreshIndicator(
        onRefresh: () => _loadPendingRequests(),
        child: Consumer<RequestProvider>(
          builder: (context, reqProvider, child) {
            return SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: screenWidth,
                      child: AppTextField(
                        hint: "Search . . .",
                        controller: searchController,
                        focusNode: searchFocus,
                        onChange: (value) {
                        
                          var users = userProvider
                              .filterUserByName(searchController.text);

                          reqProvider.filterRequestForApproval(
                              searchController.text, users);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        searchFocus.unfocus();
                      },
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
                            User user =
                                userProvider.getUserById(request.userId);

                            return ListTile(
                              onTap: () {
                                reqProvider.userRequest = request;
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.approveRequestPage);
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
                                "${user.firstName} ${user.lastName}"
                                    .toUpperCase(),
                              ),
                              subtitle: Text(
                                "${AppDataContext.getMedicines()[request.medRequestId]} | ${request.reasonRequest}",
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
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
