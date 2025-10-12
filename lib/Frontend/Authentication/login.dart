
// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Privy/Frontend/Things/app_text_style.dart';
import 'package:Privy/Frontend/Things/color.dart';
import 'package:Privy/Frontend/Things/text_names.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>{
   final TextEditingController  emailController = TextEditingController();
   final TextEditingController  passwordController = TextEditingController();
   bool _isLoading = false;
   bool _obscurePassword = true;
  
   void login() async{

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if(email.isEmpty||password.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please enter email and password")),
    );
    return;
    }



     setState(() => _isLoading = true);
     try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Login successful")),
    );
     Navigator.pushNamedAndRemoveUntil(
             context, '/homepage', (Route<dynamic> route) => false,
);
     } catch(e){
             ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text("Login Failed $e"),
       
       ),
    );
     }finally{
       setState(() {
         _isLoading = false;
       });
     }
   }
  
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(

      backgroundColor: backgroundColor,

      body: Container(
        decoration: const BoxDecoration(
          gradient: myGradient,
        ),
        child: Center( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                     width: double.infinity,
                     height: 360,
                     margin: const EdgeInsets.only(left: 15,right: 15),
                     decoration: BoxDecoration(
                     color:  containerColor,
                     borderRadius: BorderRadius.circular(16), 
                     boxShadow: [
                    BoxShadow(
              color: Colors.black.withOpacity(0.3), // shadow color
              blurRadius: 15, // softness of the shadow
              spreadRadius: 2, // size around the container
              offset: const Offset(0, 5), // moves shadow down
                    ),
                  ],
                     ),
              
                     child: Column(
              children: [
                const SizedBox(height: 15),
                const Text(TextNames.login, //Login name
                style: AppTextStyle.heading  // text style for heading
                ),
                
                const SizedBox(height: 20),
                
                Container(
                  margin: const EdgeInsets.all(15) ,
              
              
                  // name input 
                  child: TextField(
                   controller: emailController,
                   textInputAction: TextInputAction.next,
                   decoration: InputDecoration(
                    hintText: TextNames.email, // name
                    filled: true,
                    hintStyle: AppTextStyle.hint, // text style of hint
                    border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(15),
                     borderSide: BorderSide.none,
                     ),
                    )
                   ),
                ),
                
              
              
                
                Container(
                  margin: const EdgeInsets.all(15) ,
              
              
                  // name input 
                  child: TextField(
                    controller: passwordController,
                   obscureText: _obscurePassword,
                   onSubmitted: (value) {
                     _isLoading? null :login();
                               
                   },
                   decoration: InputDecoration(
                    hintText: TextNames.password , //password
                    filled: true,
                    hintStyle:  AppTextStyle.hint,
                    border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(15),
                     borderSide: BorderSide.none,
                     ),
                     contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              
                      suffixIcon: IconButton(
                            icon: Icon(_obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,), // icon to show/hide
                            onPressed: () {
        
                               setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                              // add hide button working
                              // will be done later
                              
                              
                              
                            },
                  ),
                    ),
                   ),
                ),
              
              
                     const Spacer(),
                     Container( margin: const EdgeInsets.all(15), width: double.infinity,
                     padding: const EdgeInsets.only(top: 2,bottom: 2),
                      child: ElevatedButton(onPressed: (){
                        _isLoading? null :login();
                      }, style: ElevatedButton.styleFrom( backgroundColor: backgroundColor, 
                      
                      ),
               child: _isLoading ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ):const Text(TextNames.login, // login
                style: AppTextStyle.button
                ),
                
                ),
                     ),
              
                const SizedBox(height: 10,)
              ],
                     )
                    ),
             const SizedBox(height: 10,),
                    RichText(
                      text: TextSpan(
                        text: TextNames.clickOn,
                                      style: AppTextStyle.clickOn,
                        children: [
                           TextSpan(
                         text: TextNames.signup,
                        style: AppTextStyle.link,
                         recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to registration page
                                  Navigator.pushNamed(context, '/register');
                                },
                        )
                        ]
                      ),
                    
                    )
            ],
          ),),
      ),
    );
  }
}