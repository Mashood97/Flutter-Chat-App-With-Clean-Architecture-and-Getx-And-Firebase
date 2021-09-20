import 'package:flutter/material.dart';
import 'package:flutter_push_notification_proj/features/chat/domain/entities/message.dart';
import 'package:flutter_push_notification_proj/features/chat/presentation/pages/controller/chat_controller.dart';
import 'package:flutter_push_notification_proj/helpers/constant/app_utils.dart';
import 'package:flutter_push_notification_proj/helpers/constant/constant_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  final _chatController = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    _chatController.getFriendsId();
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat-Screen'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Obx(
                () => _chatController.messagesList.isEmpty
                    ? Center(
                        child: Text('No Messages history found'),
                      )
                    : ListView.builder(
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (ctx, index) => _chatController
                                    .messagesList[index].senderId ==
                                _chatController.currentUserId
                            //My Message
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Card(
                                    color: Colors.green.shade300,
                                    elevation: 8,
                                    margin: AppUtils.kPaddingAllSides,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: AppUtils.kPaddingAllSides,
                                      child: Text(
                                        _chatController
                                            .messagesList[index].messageText,
                                        style: TextStyle(
                                            fontSize:
                                                AppFontSizes.smallFontSize,
                                            fontWeight:
                                                AppFontWeights.smallFontWeight),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            :
                            //Sender Message
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 8,
                                    margin: AppUtils.kPaddingAllSides,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: AppUtils.kPaddingAllSides,
                                      child: Text(
                                        _chatController
                                            .messagesList[index].messageText,
                                        style: TextStyle(
                                            fontSize:
                                                AppFontSizes.smallFontSize,
                                            fontWeight:
                                                AppFontWeights.smallFontWeight),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        itemCount: _chatController.messagesList.length,
                      ),
              ),
            ),
            Divider(),
            Container(
              height: 50.h,
              width: double.infinity,
              // color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _chatController.messageTextCont,
                        onSubmitted: (val) async {
                          _chatController.messageTextCont.text = val;
                          if (_chatController.messageTextCont.text.isNotEmpty &&
                              _chatController.friendUserId != null &&
                              _chatController.currentUserId != null) {
                            await _chatController.addAMessageToDB(
                              messageVal: Message(
                                dateTime: DateTime.now(),
                                messageText: _chatController
                                    .messageTextCont.text
                                    .toString()
                                    .trim(),
                                recieverId: _chatController.friendUserId!,
                                senderId: _chatController.currentUserId!,
                              ),
                            );
                          } else {
                            ConstantMethod.showErrorSnackBar(
                                "Unable to add message try again later");
                          }
                        },
                        decoration:
                            InputDecoration(hintText: 'Enter your message....'),
                      ),
                    ),
                    AppUtils.changeSizedBoxWidth(
                      15.w,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_chatController.messageTextCont.text.isNotEmpty &&
                            _chatController.friendUserId != null &&
                            _chatController.currentUserId != null) {
                          await _chatController.addAMessageToDB(
                            messageVal: Message(
                              dateTime: DateTime.now(),
                              messageText: _chatController.messageTextCont.text
                                  .toString()
                                  .trim(),
                              recieverId: _chatController.friendUserId!,
                              senderId: _chatController.currentUserId!,
                            ),
                          );
                        } else {
                          ConstantMethod.showErrorSnackBar(
                              "Unable to add message try again later");
                        }
                      },
                      child: CircleAvatar(
                        // backgroundColor: Colors.black,
                        child: Icon(Icons.send),
                      ),
                    ),
                    AppUtils.changeSizedBoxWidth(
                      5.w,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
