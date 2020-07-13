import 'package:ToDODataBase/models/task_model.dart';
import 'package:ToDODataBase/providers/db_provider.dart';
import 'package:ToDODataBase/ui/screens/tasbs_screens/all_tasks_tab.dart';
import 'package:ToDODataBase/ui/screens/tasbs_screens/complete_task_tab.dart';
import 'package:ToDODataBase/ui/screens/tasbs_screens/in_complete_tasks_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  String title;
  String description;
  setTitle(String value) {
    this.title = value;
  }

  setDescription(String value) {
    this.description = value;
  }

  submitTask(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        Provider.of<DBProvider>(context, listen: false).insertNewTask(Task(
          title: this.title,
        ));
        Navigator.pop(context);
      } catch (error) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(error.toString()),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('ok'))
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.pink,
        
        title: Text("Todo Application", style: TextStyle(color: Colors.white),),
        elevation: 0.0,
        leading: Icon(Icons.menu),
        
            
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
              Tab(
                icon: Icon(Icons.playlist_add),
                text: 'All Tasks',
              ),
              Tab(
                icon: Icon(Icons.done),
                text: 'complete Tasks',
              
              ),
              Tab(
              icon: Icon(Icons.short_text),
                text: 'inComplete Tasks',
              )
            ]),
          ),
          body:
           
          FutureBuilder<List<Task>>(
            future: Provider.of<DBProvider>(context).setAllLists(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TabBarView(
                  
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                  AllTasksTab(),
                  CompleteTasksTab(),
                  InCompleteTasksTab()
                ]);
              } else {
                return Center(child: CircularProgressIndicator(
                 backgroundColor: Colors.pink,
                 valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                ));
              }
            },
          ),
          floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
        backgroundColor: Colors.pink,
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: Colors.pink,
                builder: (BuildContext context) {
                  return Container(
                    // height: MediaQuery.of(context).size.height/2,
                    padding: MediaQuery.of(context).viewInsets,
                    child: Form(
                      key: formKey,
                      child: CupertinoActionSheet(

                        actions: <Widget>[
                          CupertinoActionSheetAction(

                            onPressed: () {},
                            child: Card(
                              
                              color: Colors.transparent,
                              elevation: 0.0,

                              child:Container(
                                child:TextFormField(


                                validator: (value) {
                                  // ignore: missing_return
                                  if (value.isEmpty) {
                                    return 'text title is required';
                                  }
                                  return null;
                                },
                              
                                decoration: InputDecoration(
                                
                                  labelText: 'Title',
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                onSaved: (value) {
                                  setTitle(value);
                                },
                              ),
                              )
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              submitTask(context);
                            },
                            
                            child: Card(
                              
                              color: Colors.transparent,
                              elevation: 0.0,
                              child: TextFormField(
                                
                                validator: (value) {
                                  // ignore: missing_return
                                  if (value.isEmpty) {
                                    return 'text description is required';
                                  }
                                  return null;
                                },
                                
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onSaved: (value) {
                                  setDescription(value);
                                },
                              ),
                            ),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            submitTask(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('Submit',style: TextStyle(color:Colors.pink),),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                context: context);
          }),
        ));
  }
}
