import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vk/ui/design/colors.dart';
import 'package:vk/ui/design/images.dart';
import 'package:vk/ui/design/style.dart';

class DialogScreen extends StatefulWidget {
  final int dialogId;
  // final String name;
  const DialogScreen({super.key, required this.dialogId});

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 138, 187, 206),
      appBar: AppBar( 
        backgroundColor: Colors.white,
        leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 24, color: systemTextBlueColor),
        onPressed: () { Navigator.pop(context); },
        ),
  
        titleSpacing: 2,
        title: Row(
          children: [
            Image.asset('assets/images/test1.png', width: 48, height: 48),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Владик Оладик', style: StyleApp.titleStyle),
                Text('был в 12:34', style: StyleApp.mainTextGrey,)
              ],
            ),
          ],
        ),
      actions: [
        IconButton(onPressed: (){}, icon: callIcon(systemTextBlueColor)),
        IconButton(onPressed: (){}, icon: pointsHorizontalMenu(systemTextBlueColor)),
      ],
      ),
      body: FriendMessage(),

// GPT

// Container(
//       padding: EdgeInsets.all(8.0),
//       child: 
//                     Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Flexible(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               padding: const EdgeInsets.all(10.0),
//               margin: const EdgeInsets.only(bottom: 4.0),
//               child: const Column(
//                 mainAxisSize: MainAxisSize.min, // Занимаем только необходимое пространство
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     'texrfgsdgergfwefsdfsefsdasdasdasdasfasgasdasdasdasdsdfsdfsdfsdfsdfsdfdfsdfsdfsdfsdfsdfsfsfsdfdfsdfsdfsfsdft',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   Text(
//                     'time',
//                     style: TextStyle(fontSize: 12.0, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
                  // ]
        //         );
        // },
        //   ),


                    // Container(
                    //   width: 250,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(20)
                    //     ),
                    //   child:



                  //   Stack(
                  //     alignment: AlignmentDirectional.bottomEnd,
                  //     children: [
                  //       Container(
                  //       width: 250,
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(20)
                  //           ),
                  //       child: Text('dasdasdasdjsdfsdawqweqweqwalkdj'),
                  //         ),
                  //         Container(
                  //           child: Text('time'),
                  //         )
                      
                  //       ])
                  // ]
                        
                        
                      
                      
                      
                      
                        
                        // const Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     // Flexible(
                        //     //   child: Text(
                        //     //       'dfsdflkja;lsdkkkjчавмчвмваыkjhlkasj;lkj;lkj;lk;lk;klhlsdfsdfsdfsdfjhfghfghfgjtk'),
                        //     // ),
                      
                            
                      
                      
      
      bottomNavigationBar: 

      // TextField()
      
      Container(
        color: Colors.white,
        // height: 120,
        child: Row(
          children: [
            IconButton(onPressed: (){}, icon: addElementIcon(systemTextBlueColor)),
            Expanded(child: TextField(
              decoration: InputDecoration(
                hintText: 'Сообщение',
                hintStyle: StyleApp.mainTextGreyHintFon,
                suffixIcon: IconButton(onPressed: (){}, icon: smileIcon(Colors.grey)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none
                  )
                )
              ),
              ),
            ),
            IconButton(onPressed: (){}, icon: microIcon(systemTextBlueColor)),
          ],
        ),
      )
      
      // NavigationBar(
      //   destinations: [
      //       NavigationDestination(icon: IconButton(onPressed: (){}, icon: Icon(Icons.add_box_outlined)), label: null),
      //       NavigationDestination(icon: TextField(), label: 'input'),
      //       NavigationDestination(icon: IconButton(onPressed: (){}, icon: Icon(Icons.mic_outlined)), label: 'add'),
      //   ]
      //   ),
      );
      
    
  }
}



class FriendMessage extends StatelessWidget {
  const FriendMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 15,
        reverse: true,
        itemBuilder: (context, index){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Image.asset('assets/images/test1.png', width: 48, height: 48),
                    const SizedBox(width: 10),
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                      ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          // child: Text.rich(TextSpan(text: 'dsfsdfjklskjfsdfaedqwdqwdadwqwdlkjhlkj'))
                          child: Text('dsfsdfjklskjfsdfsdfsdfsdfsdfsdfsdfaedsdsdsdjhlkj')
                        ),
                        SizedBox(width: 5.0),
                        Padding(
                          padding: EdgeInsets.only(bottom: 1),
                          child: Text('time', style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          );
        }
      );
  }
}