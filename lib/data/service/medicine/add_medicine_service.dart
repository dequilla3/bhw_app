import 'package:bhw_app/data/service/service_base.dart';

class AddMedicineService extends ServiceBase<void> {
  final int itemCode;
  final int newCnt;

  AddMedicineService({required this.itemCode, required this.newCnt});
  @override
  Future<Map<String, dynamic>> call() async {
    Map<String, dynamic> body = {
      'itemCode': itemCode.toString(),
      'newCnt': newCnt.toString(),
    };

    return await put('inventory/updateStocks', body: body);
  }
}
