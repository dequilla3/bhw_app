import 'package:bhw_app/data/model/medicine.dart';
import 'package:bhw_app/pages/inventory/add_stocks_page.dart';
import 'package:bhw_app/provider/medicine_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  ScrollController? scrollController;

  void scrollListener() {
    if (scrollController!.position.extentAfter < 500) {
      loadMedicine();
    }
  }

  @override
  void initState() {
    super.initState();
    loadMedicine();
  }

  @override
  void dispose() {
    scrollController?.removeListener(scrollListener);
    super.dispose();
  }

  Future<void> loadMedicine() async {
    context.read<MedicineProvider>().getMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () => loadMedicine(),
          child: Consumer<MedicineProvider>(
            builder: (context, value, child) {
              return SizedBox(
                  height: 500,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: value.medicines.length,
                    itemBuilder: (context, index) {
                      Medicine medicine = value.medicines[index];

                      return ListTile(
                        onTap: () {
                          showModalBottomSheet(
                            elevation: 1,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return AddStocksPage(
                                itemCode: medicine.itemCode,
                                currentQty: medicine.stockCount,
                              );
                            },
                          );
                        },
                        leading: CircleAvatar(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          child: Text(medicine.medName[0].toUpperCase()),
                        ),
                        title: Text(medicine.medName),
                        subtitle: Text(medicine.description),
                        trailing: Text(
                            "ITEM CODE: ${medicine.itemCode.toString()} | QTY: ${medicine.stockCount.toString()}"),
                      );
                    },
                  ));
            },
          ),
        ),
      ),
    );
  }
}
