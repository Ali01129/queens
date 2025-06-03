import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queens/components/messaging/sendMsg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../components/colors/appColor.dart';
import '../components/messaging/chatBubble.dart';
import '../database/chat_services.dart';

final ChatServices _chatServices = ChatServices();

class Messaging extends StatefulWidget {
  const Messaging({super.key});

  final String recieverID = 'BG9aQbNfQ3cLIsWWSTA4aBEcL902';

  @override
  State<Messaging> createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  void sendMsg() async {
    if (_msgController.text.isNotEmpty) {
      await _chatServices.sendMessage(widget.recieverID, _msgController.text);
      _msgController.clear();
      scrollDown();
    }
  }

  void scrollDown() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget buildMsgList() {
    String senderID = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: _chatServices.getMessages(senderID, widget.recieverID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No messages yet"));
        }

        // Scroll to bottom when messages load
        WidgetsBinding.instance.addPostFrameCallback((_) => scrollDown());

        return ListView(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          children: snapshot.data!.docs.map((doc) => buildMsgItem(doc)).toList(),
        );
      },
    );
  }

  Widget buildMsgItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser =
        data['senderID'] == FirebaseAuth.instance.currentUser!.uid;
    var alignment =
    isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      child: ChatBubble(
        message: data['message'],
        time: data['timestamp'],
        isCurrentUser: isCurrentUser,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        scrollDown();
      }
    });
  }

  @override
  void dispose() {
    _msgController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? AppColors.darkbg : AppColors.lightbg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkMode ? AppColors.darkbg : AppColors.lightbg,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: const NetworkImage(
                'https://wchadsxxtwetepaarxki.supabase.co/storage/v1/object/public/queenimages/BG9aQbNfQ3cLIsWWSTA4aBEcL902.jpg',
              ),
              radius: 2.5.h,
            ),
            SizedBox(width: 4.w),
            Text(
              "Queens Admin",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: buildMsgList(),
              ),
            ),
            Sendmsg(
              onTapCallback: sendMsg,
              controller: _msgController,
              darkMode: darkMode,
              focusNode: _focusNode,
            ),
          ],
        ),
      ),
    );
  }
}