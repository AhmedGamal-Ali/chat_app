
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/cubit/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/cubit/login_cubit/login_cubit.dart';
import 'package:scholar_chat/custom_widget/snackBar.dart';
import 'package:scholar_chat/page/RegisterPage.dart';
import 'package:scholar_chat/custom_widget/customtextfiled.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/page/message_page.dart';
import '../constant/constant.dart';
import '../custom_widget/custombootom.dart';

class LoginPage extends StatelessWidget {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoding) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).reciveMessage();
          Navigator.pushNamed(context, MessagePage.id,arguments: email);
          isLoading = false;
        } else if (state is LoginFailuer) {
          snackBar(context, state.messageError);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 75,
                    ),
                    Image.asset(
                      "assets/images/scholar.png",
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Scholor Chat",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontFamily: "pacifico"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 75,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hint: "Email",
                      onchanged: (data) {
                        email = data;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      obscureText: true,
                      hint: "Password",
                      onchanged: (data) {
                        password = data;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        text: "Login",
                        onTab: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<LoginCubit>(context)
                                .userLogin(email: email!, password: password!);
                          }
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "do not have an account? Register",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
