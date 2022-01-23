
import 'package:flutter/material.dart';
import 'package:github_profile/bloc/RadioBloc.dart';
import 'package:github_profile/bloc/post_bloc.dart';
import 'package:github_profile/bloc/pagination_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_profile/bloc/theme_bloc.dart';
import 'package:github_profile/pages/widgets/buildPostData.dart';

class GitProfile extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  ScrollController controller = ScrollController();
  PostBloc bloc; 
  var radiobloc;
  
  void onScroll(){
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;

    if(currentScroll == maxScroll){
      print('controller : ${_controller.text}');
      print('radiobloc: $radiobloc');
      bloc.add(GetNext(_controller.text, radiobloc));
    }
  }
  
  void submitUserName(BuildContext context, String input) {
    final postBloc = context.bloc<PostBloc>();
    var radio = context.bloc<RadioBloc>().state;
    print('submit : $radio dan input : $input');
    postBloc.add(GetInput(input, radio));
  }


  @override
  Widget build(BuildContext context) {
    
    var blocradio = context.bloc<RadioBloc>();
    bloc = BlocProvider.of<PostBloc>(context);
    controller.addListener(onScroll);

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFF188991),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "GITHUB PROFILE",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            child: Icon(Icons.light),
            onTap: ()=> context.bloc<ThemeBloc>().changetheme(),
          ),
        ],
      ),
      body: ListView(
        children: [
          //UserNameInputField(),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      onSubmitted: (value) {
                        if (_controller.text.isNotEmpty) {
                          submitUserName(context, _controller.text);                    
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("please fill the textfield for search"),
                              duration: Duration(milliseconds: 1000),
                            ),
                          );
                        }
                      },
                      controller: _controller,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        hintText: 'Search User Here',
                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: BlocBuilder<RadioBloc, String>(
                    builder: (context, state){
                      if (_controller.text.isNotEmpty) {
                        submitUserName(context, _controller.text);     
                      }
                    return
                    Container(
                      child: Row(
                        children: [
                          Radio(
                            value: state, 
                            groupValue: 'users', 
                            onChanged: (value){
                              blocradio.add('users');
                            }
                          ),
                          Text("Users"),
                          Radio(
                            value: state, 
                            groupValue: 'issues', 
                            onChanged: (value){
                              blocradio.add('issues');
                            }
                          ),
                          Text("Issues"),
                          Radio(value: state, groupValue: 'repositories', onChanged: (value)=>blocradio.add('repositories')),
                          Text("Repositories"),
                        ],
                      )
                    );
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: BlocBuilder<PaginationBloc, bool>(
                    builder: (context, state)=> Container(
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                color: state ? Colors.grey : null,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey, width: 3)
                              ),
                              child: Text('Lazy Loading'),
                            ),
                            onTap: (){
                              print(state);
                              //context.bloc<PaginationBloc>().changeLazyLoad();
                              context.bloc<PaginationBloc>().changePagination();
                            }
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                color: state ? null : Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey, width: 3)
                              ),
                              child: Text('With Index'),
                            ),
                            onTap: (){
                              print(state);
                              //context.bloc<PaginationBloc>().changeWithIndex();
                              context.bloc<PaginationBloc>().changePagination();
                            } 
                          ),
                        ],
                      )
                    ),
                  ),
                ),
            ],
          ),

          Container(
            height: 550,
            
            child: BlocConsumer<PostBloc, PostState>(
              builder: (context, state) {
                print(state);
                var radio = context.bloc<RadioBloc>().state;
                radiobloc = radio;
                print('radiobloc: $radiobloc');
                
                if (state is PostInitial)
                  return Container();
                  //buildInitialTextField();
                else if (state is PostLoading)
                  return buildLoadingState();
                else if (state is PostLoadedUsers){
                  print('profilLoaded : $radio');
                  print('profilLoaded : ${state.post.items.length}');
                  print('hasReachedMax :${state.hasReachedMax}');
                  return ListView.builder(
                    controller: controller,
                    scrollDirection: Axis.vertical,
                    //primary: true,
                    itemCount: state.hasReachedMax ? state.post.items.length : state.post.items.length + 1 ,
                    itemBuilder: (context, index)=>
                      index < state.post.items.length
                        ? buildUserData(state.post, index)
                        : Container(
                            child: Center(
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                  );

                }else if(state is PostLoadedIssues){
                  return ListView.builder(
                    controller: controller,
                    scrollDirection: Axis.vertical,
                    //primary: true,
                    itemCount: state.hasReachedMax ? state.post.items.length : state.post.items.length + 1 ,
                    itemBuilder: (context, index)=>
                      index < state.post.items.length
                        ? buildIssuesData(state.post, index)
                        : Container(
                            child: Center(
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                  );
                  
                } else if(state is PostLoadedRepositories){
                  return ListView.builder(
                    controller: controller,
                    scrollDirection: Axis.vertical,
                    //primary: true,
                    itemCount: state.hasReachedMax ? state.post.items.length : state.post.items.length + 1 ,
                    itemBuilder: (context, index)=>
                      index < state.post.items.length
                        ? buildRepositoryData(state.post, index)
                        : Container(
                            child: Center(
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                  );
                }
                else
                  return Container();
                  //buildInitialTextField();
              },
              listener: (context, state) {
                if (state is PostError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInitialTextField() {
    return Center(
      //child: UserNameInputField(),
    );
  }

  Widget buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
