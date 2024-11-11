import '../../../models/user_model.dart';


abstract class BlocState {}

class InitialState extends BlocState {}

class LoadedState extends BlocState {
  List<UserModel> mList;

  LoadedState({required this.mList});
}

class LoadingState extends BlocState {}

class ErrorState extends BlocState {
  String errorMsg;

  ErrorState({required this.errorMsg});
}
