import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_registration_api/screens/offline/bloc/bloc_events.dart';
import 'package:user_registration_api/screens/offline/bloc/bloc_states.dart';
import 'package:user_registration_api/screens/offline/bloc/user_bloc.dart';
import 'package:user_registration_api/screens/online/online_data.dart';

class OfflineData extends StatefulWidget {
  @override
  State<OfflineData> createState() => _OfflineDataState();
}

class _OfflineDataState extends State<OfflineData> {
  @override
  void initState() {
    context.read<OfflineUserBloc>().add(GetOfflineDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offline submitted data"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return OnlineDataPage();
              }));
            },
              child: Icon(Icons.navigate_next_rounded)),
        ],
      ),
      body: BlocBuilder<OfflineUserBloc, BlocState>(builder: (_, state) {
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
