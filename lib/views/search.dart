import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helper/constants.dart';
import 'package:flutter_chat_app/services/database.dart';
import 'package:flutter_chat_app/views/conversation_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoaded = true;
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();

  QuerySnapshot<Map<String, dynamic>>? searchSnapshot;
  @override
  initState() {
    super.initState();
    initiateSearch();
  }

  Widget searchList() {
    // ignore: avoid_print
    print('clicked');
    // ignore: avoid_print
    print(searchSnapshot!.docs);

    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              // ignore: avoid_print
              print(searchSnapshot!.docs[index].data());
              return SearchTile(
                  userName: searchSnapshot!.docs[index].data()["name"],
                  userEmail: searchSnapshot!.docs[index].data()["email"]);
            },
          )
        : Container();
  }

  initiateSearch() async {
    QuerySnapshot<Map<String, dynamic>> val = await databaseMethods
        .getUserByUserName(searchTextEditingController.text);
    setState(() {
      searchSnapshot = val;
      isLoaded = false;
    });
    await Future.delayed(Duration.zero);
  }

  createChatroomAndStartConversation({required String userName}) {
    if (userName != Constants.myName) {
      String chatRoomId = getChatRoomId(userName, Constants.myName);

      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId
      };
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRoomId)));
    }
  }

  // ignore: non_constant_identifier_names
  Widget SearchTile({required String userName, required String userEmail}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName.toString(),
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
              Text(
                userEmail.toString(),
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              createChatroomAndStartConversation(
                userName: userName,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: const Text(
                "Message",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      // ignore: avoid_unnecessary_containers
      body: isLoaded
          ? const Center(
              child: CircularProgressIndicator(),
            )
          // ignore: avoid_unnecessary_containers
          : Container(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchTextEditingController,
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintText: 'Search username',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: initiateSearch,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 40,
                            width: 40,
                            child: const Icon(
                              Icons.search,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: searchList()),
                ],
              ),
            ),
    );
  }
}

// class SearchTile extends StatelessWidget {
//   // ignore: prefer_typing_uninitialized_variables
//   final
//   const SearchTile(
//       {super.key, required this.userName, required this.userEmail});

//   @override
//   Widget build(BuildContext context) {
//     // ignore: avoid_unnecessary_containers
//     return
//   }
// }

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    // ignore: unnecessary_string_escapes
    return "$b\_$a";
  } else {
    // ignore: unnecessary_string_escapes
    return "$a\_$b";
  }
}
