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

  Future<Map<String, dynamic>> addMedicine(int itemCode, int newCnt) async {
    return await AddMedicineService(itemCode: itemCode, newCnt: newCnt).call();
  }
}
