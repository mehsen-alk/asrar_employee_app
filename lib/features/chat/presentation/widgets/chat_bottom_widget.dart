import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/functions.dart';
import '../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../domain/entities/message.dart';
import '../blocs/chat_bloc/chat_bloc.dart';
import 'chat_text_field.dart';

class ChatBottom extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  ChatBottom({super.key, this.onSended});

  final Function? onSended;
  late final Sender sender;

  @override
  Widget build(BuildContext context) {
    var authState = BlocProvider.of<AuthenticationBloc>(context).state;
    if (authState is AuthenticationSuccess) {
      var authUser = authState.employee;
      sender = Sender(name: authUser.name, email: authUser.email);
      return SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
              left: AppSize.s10.w, top: AppSize.s10.w, right: AppSize.s10.w, bottom: AppSize.s15.h),
          child: Row(
            children: [
              IconButton(
                  onPressed: () async {
                    onSended;
                    XFile? image = await selectFile(context);
                    if (image != null) {
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<ChatBloc>(context)
                          .add(ImageMessageSent(image, ImageMessage.create(sender)));
                    }
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    color: ColorManager.primary,
                  )),
              Expanded(
                  child: ChatTextField(
                onSended: onSended,
              )),
            ],
          ),
        ),
      );
    }
    return Container();
  }
}
