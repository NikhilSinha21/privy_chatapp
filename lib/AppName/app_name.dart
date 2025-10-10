import 'package:flutter/material.dart';
import 'package:privy_chat_chat_app/Frontend/Things/app_text_style.dart';
import 'package:privy_chat_chat_app/Frontend/Things/text_names.dart';
class AppName {

 static  Widget get appname => RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text :TextNames.appnamedemo1,style: AppTextStyle.appnamedemo1,
                ),
                TextSpan(
                  text :TextNames.appnamedemo2,style: AppTextStyle.appnamedemo2,
                ),
              ]
            ),
          );
}