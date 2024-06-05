import 'package:flutter/material.dart';
import 'package:pet_friend_hub_app/config/extension/context_extension.dart';
import 'package:pet_friend_hub_app/config/items/app_color.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final String backImage = 'assets/images/chat_bck.jpg';
  final List<String>? message = List.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Asistan Veteriner',
          style: context.textTheme.titleLarge,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: context.dynamicWidth(0.05),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                    height: context.dynamicHeight(.72),
                    child: _messageView(context)),
                _buildPostMessage(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _messageView(BuildContext context) {
    return Padding(
      padding: context.paddingAllLow,
      child: ListView.builder(
        itemCount: message?.length,
        itemBuilder: (context, index) {
          bool isMe = true;
          if (index % 2 == 0) {
            isMe = false;
          }
          return MessageWidget(
            isMe: isMe,
            message: message![index].toString(),
          );
        },
      ),
    );
  }

  Row _buildPostMessage(BuildContext context) {
    return Row(
      children: [
        Container(
          width: context.dynamicWidth(0.85),
          padding: context.paddingHorizontalDefault,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(50),
          ),
          child: const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Mesaj',
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.send_rounded,
            color: Colors.white,
            size: 40,
          ),
        )
      ],
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.isMe,
    required this.message,
  });
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          width: context.dynamicWidth(.8),
          margin: context.marginBottomDefault,
          padding: context.paddingAllLow,
          decoration: BoxDecoration(
            color: AppColor.greenColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text('gelen mesaj:uzunun mesaj deneme $message',
              style: Theme.of(context).textTheme.bodyLarge),
        ),
      ],
    );
  }
}
