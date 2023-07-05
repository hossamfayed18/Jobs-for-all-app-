import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs_for_all/modules/login/login_screen.dart';
import 'package:jobs_for_all/modules/signUp/cubit/cubit.dart';
import 'package:jobs_for_all/modules/signUp/cubit/states.dart';
import 'package:jobs_for_all/shared/components/components.dart';
class  SignUp extends StatelessWidget {
  var myformkey = GlobalKey<FormState>() ;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SignUp_Cubit(),
      child: BlocConsumer<SignUp_Cubit,SignUpStates>(
        listener:(context,state){
          if(state is CreateUserSuccessState)
            navigatorTo(context, Login());
        } ,
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[200],
            ),
            body: SizedBox(
              height: 2000,
              child: Stack(
                children: [
                  const Image(
                    image: AssetImage('assets/images/img_3.png'),
                    height: 2000,
                    width: double.infinity,
                    fit: BoxFit.fill,

                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.all(20),
                        child: Form(
                          key: myformkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Register',
                                style: Theme.of(context).textTheme.headline3!.copyWith(
                                  color: Colors.black,
                                ),

                              ),

                              const SizedBox(height: 20),
                              defaultTFF(
                                mycontroller: nameController,
                                mykeyboardType: TextInputType.name,
                                text: 'User Name',
                                myprefixIcon: Icons.person,
                                validatorfunction:(value){
                                  if(value.toString().isEmpty)
                                  {return  'Please enter your name';}
                                  return null ;
                                },
                              ),
                              const SizedBox(height: 20),
                              defaultTFF(
                                mycontroller: emailController,
                                mykeyboardType: TextInputType.emailAddress,
                                text: 'Email Address',
                                myprefixIcon: Icons.email_outlined,
                                validatorfunction:(value){
                                  if(value.toString().isEmpty)
                                  {return  'Please enter your email';}
                                  return null ;
                                },
                              ),
                              const SizedBox(height: 20),
                              defaultTFF(
                                mycontroller:passController ,
                                mykeyboardType: TextInputType.visiblePassword,
                                text: 'Password',
                                myprefixIcon: Icons.lock_outline_sharp,
                                mysuffixIcon:SignUp_Cubit.get(context).myicon,
                                validatorfunction:(value){
                                  if(value.toString().isEmpty)
                                  {return  'Please enter your password';}
                                  return null ;
                                },
                                ispass:SignUp_Cubit.get(context).ispass,
                                 suffixiconfun: (){
                              SignUp_Cubit.get(context).chngePasswordVisibility();
                            },

                              ),
                              const SizedBox(height: 20),
                              const Text(
                                '* Optional',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color:Colors.brown ,
                                ),
                              ),
                              const SizedBox(height: 4,),
                              defaultTFF(
                                mycontroller: phoneController,
                                mykeyboardType: TextInputType.phone,
                                text: 'Phone',
                                myprefixIcon: Icons.phone,

                              ),
                              const SizedBox(height: 20),
                              ConditionalBuilder(
                              condition:  state is ! CreateUserLoadingState ,
                                fallback: (context)=>const Center(child: CircularProgressIndicator()),
                                builder:(context)=>  defaultButton(
                                  function: (){
                                    if(myformkey.currentState!.validate()) {
                                      SignUp_Cubit.get(context).userRegister(
                                    email:emailController.text,
                                    password: passController.text,
                                    phone: phoneController.text,
                                    name: nameController.text,
                                  );
                                    }
                                  },
                                  text: 'Register',
                                  isupercase: true,
                                ),
                              ),



                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ) ,
          );
        },
      ),
    );
  }
}
