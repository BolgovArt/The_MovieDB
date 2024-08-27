import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:vk/ui/design/style.dart';
import 'package:vk/ui/navigation/main_navigation.dart';

class DialogRow {
  final int id;
  final Image avatar;
  final String nameAndSurname;
  final String lastMessage;
  final String timeOfLastMessage;

  const DialogRow ({
    required this.id,
    required this.avatar, 
    required this.nameAndSurname, 
    required this.lastMessage, 
    required this.timeOfLastMessage
    });
}

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {


  final _messageList = [
    DialogRow(
      id: 1,
      avatar: Image.asset('assets/images/test1.png', width: 48, height: 48), 
      nameAndSurname: 'nameAndSurname', 
      lastMessage: 'lastMessage', 
      timeOfLastMessage: 'timeOfLastMessage'
      ),
    DialogRow(
      id: 2,
      avatar: Image.asset('assets/images/test1.png', width: 48, height: 48), 
      nameAndSurname: 'Иван Иванов', 
      lastMessage: 'Привет', 
      timeOfLastMessage: '21:07'
      ),
    DialogRow(
      id: 3,
      avatar: Image.asset('assets/images/test1.png', width: 48, height: 48), 
      nameAndSurname: 'nameAndSurname', 
      lastMessage: 'lastMessage', 
      timeOfLastMessage: 'timeOfLastMessage'
      ),
    DialogRow(
      id: 4,
      avatar: Image.asset('assets/images/test1.png', width: 48, height: 48), 
      nameAndSurname: 'nameAndSurname', 
      lastMessage: 'lastMessage', 
      timeOfLastMessage: 'timeOfLastMessage'
      ),
      DialogRow(
      id: 5,
      avatar: Image.asset('assets/images/test1.png', width: 48, height: 48), 
      nameAndSurname: 'nameAndSurname', 
      lastMessage: 'lastMessage', 
      timeOfLastMessage: 'timeOfLastMessage'
      ),
      DialogRow(
      id: 6,
      avatar: Image.asset('assets/images/test1.png', width: 48, height: 48), 
      nameAndSurname: 'nameAndSurname', 
      lastMessage: 'lastMessage', 
      timeOfLastMessage: 'timeOfLastMessage'
      ),
      DialogRow(
      id: 7,
      avatar: Image.asset('assets/images/test1.png', width: 48, height: 48), 
      nameAndSurname: 'Ivan kudr', 
      lastMessage: 'lastMessage', 
      timeOfLastMessage: 'timeOfLastMessage'
      ),
  ];


final _searchController = TextEditingController();

void _searchDialog() {
  final field = _searchController.text;
  if (field.isEmpty) {
    _filteredMessageList = _messageList;
  } else {
    _filteredMessageList = _messageList.where((DialogRow element) {
      return element.nameAndSurname.toLowerCase().contains(field.toLowerCase());
    }).toList();
    }
  setState((){});
}


  // void _searchDialog() {
  //   final field = _searchController.text;
  //   if (field.isNotEmpty) {
  //     _filteredMessageList = _messageList.where((DialogRow element) {
  //       return element.nameAndSurname.contains(field);
  //     }).toList();
  //   }
  // setState((){});
  // }
  


@override
  void initState() {
    super.initState();
    _searchController.addListener(_searchDialog);
    _filteredMessageList = _messageList;
  }
  

var _filteredMessageList = <DialogRow>[];

  void _onDialog(index) {
    final id = _messageList[index].id;
    Navigator.of(context).pushNamed(MainNavigationRouteNames.movieDetails, arguments: id);
  }


  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        
        ListView.separated(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              separatorBuilder: (context, index) {return const Divider(height: 0, color: Colors.black12);},
              padding: const EdgeInsets.only(top: 40),
              itemCount: _filteredMessageList.length,
              itemBuilder: (BuildContext context, int index){
                final item = _filteredMessageList[index];
                return 
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                        onTap: () => _onDialog(index),
                        child:
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                        children: [
                          item.avatar,
                          Padding(
                            padding:const EdgeInsets.only(left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.nameAndSurname, style: StyleApp.mainTextBlack,),
                                Text(item.lastMessage, style: StyleApp.mainTextGrey)
                              ],
                            ),
                          ),
                          
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(item.timeOfLastMessage)
                              ),
                          ),
                          
                          
                        ],
                        
                      ),
                    ),
                    
                  ),
                );
              },
              
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                
                controller: _searchController,
                // style: TextStyle(fontSize: 1),
                decoration: InputDecoration(

                  filled: true,
                  fillColor: Color.fromARGB(235, 220, 223, 226),
                  prefixIcon: Icon(Icons.search, size: 24,), // ? Как изменить размер иконки?????????? Пробовал в контейнер оборачивать
                  prefixIconColor: Colors.black38,
                  // prefixIconConstraints: BoxConstraints(maxWidth: 20),
                  hintText: 'Поиск',
                  hintStyle: StyleApp.mainTextGrey,
                  // isCollapsed: true,
                  contentPadding: EdgeInsets.zero,

                  enabled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red,
                      style: BorderStyle.none
                    ),
                    borderRadius:BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none
                    ),
                    borderRadius:BorderRadius.circular(10)
                  ),
                  ),
              ),
            ),
      ],
    );

  }
}