import 'package:bhw_app/data/model/medicine.dart';
import 'package:bhw_app/data/service/medicine/add_medicine_service.dart';
import 'package:bhw_app/data/service/medicine/medicine_service.dart';
import 'package:bhw_app/provider/provider_base.dart';

class MedicineProvider extends ProviderBase {
  List<Medicine> medicines = [];

  Future<List<Medicine>> getMedicines() async {
    var res = await MedicineService().call();
    res.sort((a, b) => a.itemCode.compareTo(b.itemCode));

    medicines = [];
    medicines.addAll(res);

    notifyListeners();

    return res;
  }

  Medicine? getMedicineByItemCode(int itemCode) {
    // Find the medicine with the specified item code
    Medicine? medicine;
    try {
      medicine = medicines.firstWhere(
        (medicine) => medicine.itemCode == itemCode,
      );
    } catch (e) {
      // Handle the case where no medicine is found
      medicine = null;
    }

    return medicine;
  }

  Future<Map<String, dynamic>> updateMeds(int itemCode, int newCnt) async {
    return await AddMedicineService(itemCode: itemCode, newCnt: newCnt).call();
  }
}
