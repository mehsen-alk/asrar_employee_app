import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app/functions.dart';
import '../../../auth/presentation/bloc/authentication_bloc.dart';
import '../blocs/chat_bloc/chat_bloc.dart';
import '../functions/functions.dart';
import '../widgets/chat_bottom_widget.dart';
import '../widgets/message_widget.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              listenWhen: (previous, current) =>
                  previous.fileUploadingStatus != current.fileUploadingStatus,
              listener: (context, state) {
                if (state.fileUploadingStatus == Status.loading) {
                  showCustomDialog(context);
                } else if (state.fileUploadingStatus == Status.success) {
                  dismissDialog(context);
                } else if (state.fileUploadingStatus == Status.failed) {
                  showCustomDialog(context, message: state.message);
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: state.messagesList.length,
                  itemBuilder: (context, index) {
                    var message = state.messagesList[index];
                    var authState = BlocProvider.of<AuthenticationBloc>(context).state;
                    if (authState is AuthenticationSuccess) {
                      var isMine = message.isMine(authState.employee.email);

                      return Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (!isMine) const SizedBox(),
                          MessageWidget(
                            message: state.messagesList[index],
                            isMine: isMine,
                            isPreviousFromTheSameSender:
                                isPreviousFromTheSameSender(state.messagesList, index),
                          ),
                          if (isMine) const SizedBox(),
                        ],
                      );
                    }
                    return Container();
                  },
                );
              },
            ),
          ),
          ChatBottom(onSended: () {
            _scrollController.animateTo(_scrollController.position.minScrollExtent,
                duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
          }),
        ],
      ),
    );
  }
}
