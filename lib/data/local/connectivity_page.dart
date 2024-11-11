import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:user_registration_api/data/local/db_helper.dart';
import 'package:user_registration_api/data/remote/api_helper.dart';
import 'package:user_registration_api/models/user_model.dart';

class ConnectivityPage {
  final Connectivity connectivity = Connectivity();
  DbHelper? dbHelper;
  ApiHelper? apiHelper;

  ConnectivityServices() {
    connectivity.onConnectivityChanged.listen(( event) async{
      var connectivityStatus = await Connectivity().checkConnectivity();
      if (connectivityStatus == ConnectivityResult.mobile ||
          connectivityStatus == ConnectivityResult.wifi) {
        _submitOfflineData();
      }
    });
  }

  void _submitOfflineData() async {
    var data = await dbHelper!.getOfflineData();
    for (UserModel eachUser in data) {
      bool success = await _submitToApi(eachUser);
      if(success){
        dbHelper!.updateInDb(newUser: eachUser);
      }
    }
  }

  Future<bool> _submitToApi(UserModel newUser) async {
    bool status = await apiHelper!.postApi(url: "https://673034d566e42ceaf15faac7.mockapi.io/users", mBody: newUser.toMap());
    return status;
  }
}
