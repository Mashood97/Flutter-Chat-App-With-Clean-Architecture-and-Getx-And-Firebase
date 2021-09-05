import 'package:flutter/material.dart';
import 'package:flutter_push_notification_proj/features/chat/presentation/pages/controller/chat_controller.dart';
import 'package:flutter_push_notification_proj/helpers/constant/app_utils.dart';
import 'package:flutter_push_notification_proj/helpers/routing/app_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatList extends StatelessWidget {
  final ChatController _chatController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat-List'),
        actions: [
          IconButton(
            onPressed: () async {
              await _chatController.getAllUserFromDB();
            },
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              _chatController.logoutUser();
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: AppUtils.kPaddingAllSides,
          child: Obx(
            () => _chatController.isBusy
                ? Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemBuilder: (ctx, index) => ListTile(
                      onTap: () {
                        Get.toNamed(
                          PageConst.chatMessages,
                          arguments: _chatController.usersList[index].uid,
                        );
                      },
                      title: Text(
                        _chatController.usersList[index].email!,
                      ),
                      leading: CircleAvatar(
                        child: FittedBox(
                          child: Text('${index + 1}'),
                        ),
                      ),
                      trailing: Icon(
                        Icons.message,
                      ),
                    ),
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: _chatController.usersList.length,
                  ),
          ),
        ),
      ),
    );
  }
}
