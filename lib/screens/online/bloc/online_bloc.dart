import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_registration_api/data/remote/api_helper.dart';
import 'package:user_registration_api/models/user_model.dart';
import 'package:user_registration_api/screens/online/bloc/bloc_event.dart';
import 'package:user_registration_api/screens/online/bloc/bloc_state.dart';

class OnlineBloc extends Bloc<OnlineEventClass, OnlineBlocState> {
  ApiHelper apiHelper;

  OnlineBloc({required this.apiHelper}) :super(InitialState()) {
    on<GetOnlineData>((event, emit) async {
      emit(LoadingState());
      var data = await apiHelper.getApi(
          url: "https://673034d566e42ceaf15faac7.mockapi.io/users");
      List<UserModel> allData = [];
      for(Map<String,dynamic> eachMap in data){
        allData.add(UserModel.fromMap(map: eachMap));
      }
      if (data != null) {
        emit(LoadedState(mList:allData));
      } else {
        emit(ErrorState(errorMsg: "No Data Loaded"));
      }
    });

    on<PostOnlineData>((event, emit)async {
      emit(LoadingState());
      await apiHelper.postApi(
          url: "https://673034d566e42ceaf15faac7.mockapi.io/users",
          mBody: event.mBody);

    });
  }
}