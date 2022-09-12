import 'package:bloc_api_project/blocs/userscreen_bloc.dart';
import 'package:bloc_api_project/model/user_model.dart';
import 'package:bloc_api_project/repocitory/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Apis',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: //MyHome(),
      RepositoryProvider(
        create: (context) => UserRepository(),
        child: MyHome(),
      ),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserscreenBloc(RepositoryProvider.of<UserRepository>(context),)..add(LoadedUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Load Data Using Bloc"),
        ),
        body: BlocBuilder<UserscreenBloc , UserscreenState>(
          builder: (context,state){
            if(state is DataLoagingState){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if(state is DataLoadedState){
              List<UserModel> userdata = state.useres;
              return ListView.builder(
                itemCount: userdata.length,
                itemBuilder: (_,index){
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetaildScreen(model: userdata[index],)));
                      },
                      child: Card(
                        elevation: 4,
                        color: Colors.red,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(userdata[index].firstName,style: TextStyle(fontSize: 20),),
                          subtitle: Text(userdata[index].email,style: TextStyle(fontSize: 20),),
                          trailing: CircleAvatar(
                            backgroundImage: NetworkImage(userdata[index].avatar),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            if(state is DataLoagingError){
              return const Center(
                child: Text("ERROR OCCURE"),
              );
            }
            return Container(
              color: Colors.green,
            );
          },
        ),
      ),
    );
  }
}

class DetaildScreen extends StatelessWidget {
  const DetaildScreen({Key? key,required this.model}) : super(key: key);

  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("On Tap DATA"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  maxRadius: 60,
                  backgroundImage: NetworkImage(model.avatar),
                ),
              ),
              SizedBox(height: 15,),
              Text(model.firstName + "  " + model.lastName,style: TextStyle(fontSize: 25),),
              SizedBox(height: 8,),
              Text(model.email,style: TextStyle(fontSize: 15),),
            ],
          ),
        ),
      ),
    );
  }
}

