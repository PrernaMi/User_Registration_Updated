

import '../../../models/user_model.dart';

abstract class OnlineBlocState{}

class InitialState extends OnlineBlocState{}
class LoadingState extends OnlineBlocState{}
class LoadedState extends OnlineBlocState{
  List<UserModel> mList;
  LoadedState({required this.mList});
}
class ErrorState extends OnlineBlocState{
  String errorMsg;
  ErrorState({required this.errorMsg});
}