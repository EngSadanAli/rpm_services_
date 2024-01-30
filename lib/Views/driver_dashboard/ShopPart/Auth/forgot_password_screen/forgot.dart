import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rpm/Views/driver_dashboard/widgets/custom_textField.dart';
import 'package:rpm/Views/driver_dashboard/widgets/round_button.dart';
import 'package:rpm/utils/app_colors.dart';
import 'package:rpm/utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  'Forgot Password',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: AppColors.textFieldBorderColor,
                        fontSize: 30,
                        // decoration: TextDecoration.underline,
                      ),
                ),
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  'Enter your email address\nto recover your password',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.textFieldBorderColor,
                        // fontSize: 30,
                        // decoration: TextDecoration.underline,
                      ),
                ),
                SizedBox(
                  height: height * .01,
                ),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height * .06, bottom: height * 0.01),
                      child: Column(
                        children: [
                          CustomTextField(
                            readOnly: false,
                            controller: emailController,
                            focusNode: emailFocusNode,
                            onFieldSubmittedValue: (newValue) {},
                            keyBoardType: TextInputType.emailAddress,
                            obscureText: false,
                            prefixIcon: Icon(Icons.email_outlined,
                                color: AppColors.textFieldBorderColor),
                            hint: 'Email',
                            onChange: (value) {},
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !GetUtils.isEmail(value)) {
                                return "Please enter a valid email";
                              }
                              return null;
                            },
                          ),
                          // InputTextField(
                          //   myController: emailController,
                          //   focusNode: emailFocusNode,
                          //   onFiledSubmittedValue: (value) {},
                          //   keyBoardType: TextInputType.emailAddress,
                          //   obscureText: false,
                          //   hint: 'Email',
                          //   onValidator: (value) {
                          //     return value.isEmpty ? 'enter email' : null;
                          //   },
                          // ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 31),
                  child: ChangeNotifierProvider(
                    create: (_) => ForgotPasswordController(),
                    child: Consumer<ForgotPasswordController>(
                      builder: (context, provider, child) {
                        return RoundButton(
                            title: 'Recover',
                            loading: provider.loading,
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                provider.forgotPassword(
                                    context, emailController.text);
                              }
                            });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void forgotPassword(BuildContext context, String email) async {
    setLoading(true);

    try {
      auth
          .sendPasswordResetEmail(
        email: email,
      )
          .then((value) {
        setLoading(false);
        // Navigator.pushNamed(context, RouteName.loginView);
        Get.back();
        Utils.toastMessage('Please check your email to recover your password');
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
