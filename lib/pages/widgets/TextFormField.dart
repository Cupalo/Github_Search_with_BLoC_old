
import 'package:flutter/material.dart';
import 'package:github_profile/bloc/RadioBloc.dart';
import 'package:github_profile/bloc/pagination_bloc.dart';
import 'package:github_profile/bloc/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_profile/pages/GitProfile.dart';

class UserNameInputField extends GitProfile {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    var blocradio = context.bloc<RadioBloc>();
    return Column(
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
    );
  }

  void submitUserName(BuildContext context, String input) {
    final postBloc = context.bloc<PostBloc>();
    var radio = context.bloc<RadioBloc>().state;
    print('submit : $radio dan input : $input');
    postBloc.add(GetInput(input, radio));
  }
}
