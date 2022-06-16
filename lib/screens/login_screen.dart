import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:companysystem/screens/register_Screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
late  TextEditingController _emailTextController=TextEditingController(text:"");
  late  TextEditingController _passwordTextController=TextEditingController(text:"");
final _LoginFormKey=GlobalKey< FormState>();
  bool _obscureText =true;
  @override
  void dispose() {
    _animationController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();

    super.initState();
  }


  void submitFormOnLogin(){
    final isValid=_LoginFormKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
print("valid");

    }else{
      print("not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://media.istockphoto.com/photos/businesswoman-using-computer-in-dark-office-picture-id557608443?k=6&m=557608443&s=612x612&w=0&h=fWWESl6nk7T6ufo4sRjRBSeSiaiVYAzVrY-CLlfMptM=",
            placeholder: (context, url) => Image.asset(
              'images/wallpaper.jpg',
              fit: BoxFit.fill,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          ListView(
            children: [
              SizedBox(height: size.height * 0.1),
              const Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25,
                      letterSpacing: 1),
                ),
              ),
              const SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                      TextSpan(
                        text: "  ",
                      ),
                      TextSpan(
                        text: "Register",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => RegisterScreen())),
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue.shade300,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ],
                    //
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Form(
                  key: _LoginFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value){
                          if(value  !.isEmpty || !value.contains('@')){

                            return 'please enter a valid Email adress';
                          }
                          return null;
                        },
                        controller: _emailTextController,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(suffixIcon: GestureDetector(
                          onTap:     (){},child: Icon(Icons.email),
                        ),
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),

                            ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade700),

                        ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),

                          ),
                        ),

                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        validator: (value){
                          if(value  !.isEmpty || value.length<8){

                            return 'please enter a valid password';
                          }
                          return null;
                        },
                        obscureText: _obscureText,
                        controller: _passwordTextController,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap:     (){
                              setState(() {
                                _obscureText=!_obscureText;
                              });
                            },child: Icon(_obscureText ?Icons.visibility_off: Icons.visibility),
                          ),
                          hintText: 'password',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),

                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink.shade700),

                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),

                          ),
                        ),

                      ),
                    ],
                  ),
                ),
              ),

         
         SizedBox(height: 4,),

              Align(alignment: Alignment.topRight,
                child: TextButton(onPressed: (){},
                  child: Text(
                    "forget password?",

                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 1),),
                ),
              ), SizedBox(height: 12,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 11.0),
           child: MaterialButton(onPressed: submitFormOnLogin,color:Colors.pink.shade700,
             elevation: 10,
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),
             side: BorderSide.none),
           child :   Row(mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 14.0),
                 child: Text('Login',style: TextStyle(

             color: Colors.white,
             fontSize: 16,
             fontWeight: FontWeight.bold,),
                 ),
               ),
            SizedBox(width: 10,),
            Icon(Icons.exit_to_app,color: Colors.white,),
             ],
           ),
           ),
         ),


            ],

          ),
        ],
      ),
    );
  }
}
