import 'package:bhw_app/components/app_text_field.dart';
import 'package:bhw_app/provider/medicine_provider.dart';
import 'package:bhw_app/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AddStocksPage extends StatefulWidget {
  final int itemCode;
  final int currentQty;

  const AddStocksPage(
      {Key? key, required this.itemCode, required this.currentQty})
      : super(key: key);

  @override
  State<AddStocksPage> createState() => _AddStocksPageState();
}

class _AddStocksPageState extends State<AddStocksPage> {
  final qtyController = TextEditingController();

  Future<void> loadMedicine() async {
    context.read<MedicineProvider>().getMedicines();
  }

  @override
  Widget build(BuildContext context) {
    final medProvider = context.read<MedicineProvider>();

    showAlertModal(QuickAlertType type, String text, {bool isPop = false}) {
      Future.delayed(Duration.zero, () {
        QuickAlert.show(
          context: context,
          type: type,
          text: text,
          onConfirmBtnTap: () {
            if (isPop) {
              Navigator.pop(context);
              loadMedicine().then((value) => Navigator.pop(context));
            }
          },
        );
      });
    }

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          )),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text(
              "Add Stock for ITEMCODE: ${widget.itemCode}",
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 24),
            AppTextField(
              hint: "Qty",
              controller: qtyController,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    EasyLoading.show(status: "Updating Stock . . .");

                    await medProvider.updateMeds(widget.itemCode,
                        int.parse(qtyController.text) + widget.currentQty);

                    showAlertModal(
                      QuickAlertType.success,
                      "Successfully updated stock.",
                      isPop: true,
                    );

                    EasyLoading.dismiss();
                  } catch (e) {
                    print(e);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
