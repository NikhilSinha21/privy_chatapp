
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:privy_chat_chat_app/Backend/auth_service.dart';
import 'package:privy_chat_chat_app/Frontend/Things/app_text_style.dart';
import 'package:privy_chat_chat_app/Frontend/Things/color.dart';
import 'package:privy_chat_chat_app/Frontend/Things/text_names.dart';


class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration>{
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureconfirmPassword = true;

  void register() async{
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmpassword = confirmPasswordController.text.trim();


    if(email.isEmpty|| password.isEmpty||confirmpassword.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter All The field")));
      return;
    }
     else{
    if(password == confirmpassword){  
    setState(() => _isLoading = true);
    try{
      await authService.value.createAccount(
        email: email,
        password: password,
      );
    

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registraion Successfull")));

    Navigator.pushNamed(context, '/');
    }catch(e){
      
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));

    }finally {
      setState(() => _isLoading = false);
    }}
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
    }
    
    }
  }
  
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(

      backgroundColor: backgroundColor,

      body: Center( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                   width: double.infinity,
                   height: 450,
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
              const Text( TextNames.register, //register
              style: AppTextStyle.heading,
              ),
              
              const SizedBox(height: 20),
              
              Container(
                margin: const EdgeInsets.all(15) ,
            
            
                // name input 
                child: TextField(
                 controller: emailController,
                 decoration: InputDecoration(
                  hintText: TextNames.email, //name
                  filled: true,
                  hintStyle:  AppTextStyle.hint,
                  border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(15),
                   borderSide: BorderSide.none,
                   ),
                  )
                 ),
              ),
              
            
            
              
              Container(
                margin: const EdgeInsets.all(15) ,
            
            
                // password
                child: TextField(
                  controller: passwordController,
                 obscureText: _obscurePassword,
                 decoration: InputDecoration(
                  hintText: TextNames.password,
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
                            // add hide button working
                            // will be done later
                           setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                          },
                ),
                  ),
                 ),
              ),
             
         
             Container(
                margin: const EdgeInsets.all(15) ,
            
            
                // confirm password
                child: TextField(
                  controller: confirmPasswordController,
                 obscureText: _obscureconfirmPassword,
                 decoration: InputDecoration(
                  hintText: TextNames.confirmpassword,
                  filled: true,
                  hintStyle:  AppTextStyle.hint,
                  border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(15),
                   borderSide: BorderSide.none,
                   ),
                   contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            
                    suffixIcon: IconButton(
                          icon:  Icon(_obscureconfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,), // icon to show/hide
                          onPressed: () {
                            // add hide button working
                            // will be done later
                           setState(() {
                                      _obscureconfirmPassword = !_obscureconfirmPassword;
                                    });
                          },
                ),
                  ),
                 ),
              ),
            
                   const Spacer(),
                   Container( margin: const EdgeInsets.all(15), width: double.infinity,
                   padding: const EdgeInsets.only(top: 2,bottom: 2),
                    child: ElevatedButton(onPressed: (){
                      _isLoading? null : register();
                    }, style: ElevatedButton.styleFrom( backgroundColor: backgroundColor, ),
             child:  _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ):const Text(TextNames.register,
                            style: AppTextStyle.button,
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
                      text: TextNames.haveaccount,
                                    style: AppTextStyle.clickOn,
                      children: [
                         TextSpan(
                       text: TextNames.login,
                      style: AppTextStyle.link,
                       recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to registration page
                                Navigator.pushNamed(context, '/');
                              },
                      )
                      ]
                    ),
                  
                  )
          ],
        ),),
    );
  }
}