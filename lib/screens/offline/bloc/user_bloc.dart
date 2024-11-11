import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/local/db_helper.dart';
import 'bloc_events.dart';
import 'bloc_states.dart';

class OfflineUserBloc extends Bloc<BlocEvent,BlocState>{
  DbHelper mainDb;
  OfflineUserBloc({required this.mainDb}):super(InitialState()){
    on<GetOfflineDataEvent>((event, emit)async{
      emit(LoadingState());
      var data = await mainDb.getOfflineData();
      if(data != null)emit(LoadedState(mList: data));
      else emit(ErrorState(errorMsg: "No Data Loaded"));
    });
  }
}