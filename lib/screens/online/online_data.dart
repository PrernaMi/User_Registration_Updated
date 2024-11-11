import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_registration_api/screens/online/bloc/bloc_event.dart';
import 'package:user_registration_api/screens/online/bloc/bloc_state.dart';
import 'package:user_registration_api/screens/online/bloc/online_bloc.dart';

import '../offline/offline_data.dart';

class OnlineDataPage extends StatefulWidget{
  @override
  State<OnlineDataPage> createState() => _OnlineDataPageState();
}

class _OnlineDataPageState extends State<OnlineDataPage> {

  @override
  void initState() {
    context.read<OnlineBloc>().add(GetOnlineData());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios_new_rounded)),
        title: Text("Online Submitted Data"),
        centerTitle: true,
      ),
      body: BlocBuilder<OnlineBloc, OnlineBlocState>(builder: (_, state) {
        if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ErrorState) {
          return Text(state.errorMsg);
        }
        if (state is LoadedState) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.mList.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(state.mList[index].name),
                    subtitle: Text(state.mList[index].email),
                  ),
                );
              });
        }
        return Container();
      }),
    );
  }
}