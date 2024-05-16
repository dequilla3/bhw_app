import 'package:bhw_app/data/model/medicine.dart';
import 'package:bhw_app/data/service/service_base.dart';

class MedicineService extends ServiceBase<List<Medicine>> {
  @override
  Future<List<Medicine>> call() async {
    final result = await get('inventory/allStocks', null);
    return List.generate(
      result['data'] != null ? result['data'].length : 0,
      (index) {
        return Medicine.fromJson(result['data'][index]);
      },
    );
  }
}
