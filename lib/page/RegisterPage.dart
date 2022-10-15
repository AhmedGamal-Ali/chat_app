import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/cubit/register_cubit/register_cubit.dart';
import '../constant/constant.dart';
import '../cubit/chat_cubit/chat_cubit.dart';
import '../custom_widget/custombootom.dart';
import '../custom_widget/customtextfiled.dart';
import '../custom_widget/snackBar.dart';
import 'message_page.dart';

class RegisterPage extends StatelessWidget {
  static String id = "registerpage";
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoding) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          BlocProvider.of<ChatCubit>(context).reciveMessage();
          Navigator.pushNamed(context, MessagePage.id,arguments: email);
          isLoading = false;
        } else if (state is RegisterFailuer) {
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
                          "Register",
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
                        text: "Register",
                        onTab: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<RegisterCubit>(context)
                                .userRegister(
                                email: email!, password: password!);
                          }
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "you have an account? Login",
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
