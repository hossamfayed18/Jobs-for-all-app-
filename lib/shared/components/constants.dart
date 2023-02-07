String ? uid ;

// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jobs_for_all/modules/login/cubit/cubit.dart';
// import 'package:jobs_for_all/modules/login/cubit/states.dart';
// import 'package:jobs_for_all/modules/signUp/signUp_screen.dart';
//
// import '../../shared/components/components.dart';
//
//
// class Login extends StatelessWidget {
//
//   var myformkey = GlobalKey<FormState>();
//   var  emailController= TextEditingController();
//   var  passController= TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context)=>Login_Cubit(),
//       child:BlocConsumer<Login_Cubit,LoginStates>(
//         listener:(context,state){} ,
//         builder: (context,state){
//           return Scaffold(
//             appBar: AppBar(),
//             body: Center(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsetsDirectional.all(20),
//                   child: Form(
//                     key: myformkey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Login',
//                           style: Theme.of(context).textTheme.headline3!.copyWith(
//                             color: Colors.black,
//                           ),
//
//                         ),
//
//                         SizedBox(height: 20),
//                         Column(
//                           children: [
//                             defaultTFF(
//                               mycontroller: emailController,
//                               mykeyboardType: TextInputType.emailAddress,
//                               text: 'Email Address',
//                               myprefixIcon: Icons.email_outlined,
//                               validatorfunction:(value){
//                                 if(value.toString().isEmpty)
//                                 {return  'Please enter your email';}
//                                 return null ;
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             defaultTFF(
//                               mycontroller:passController ,
//                               mykeyboardType: TextInputType.visiblePassword,
//                               text: 'Password',
//                               myprefixIcon: Icons.lock_outline_sharp,
//                               mysuffixIcon:Login_Cubit.get(context).myicon,
//                               validatorfunction:(value){
//                                 if(value.toString().isEmpty)
//                                 {return  'Please enter your password';}
//                                 return null ;
//                               },
//                               ispass: Login_Cubit.get(context).ispass,
//                               suffixiconfun: (){
//                                 Login_Cubit.get(context).chngePasswordVisibility();
//                               },
//
//                             ),
//                             SizedBox(height: 20),
//                             ConditionalBuilder(
//                               condition: state is! LoginLoadingState ,
//                               fallback: (context)=>Center(child: CircularProgressIndicator()),
//                               builder:(context)=>  defaultButton(
//                                 function: (){
//                                   if(myformkey.currentState!.validate()) {
//                                     Login_Cubit.get(context).Login(email:emailController.text, password: passController.text,context: context);
//                                   }
//                                 },
//                                 text: 'Login',
//                                 isupercase: true,
//                               ),
//                             ),
//
//
//                             SizedBox(height: 20),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Don\'t have an account ?',
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                   ),
//
//
//                                 ),
//                                 TextButton(
//                                   onPressed:(){
//                                     navigatorTo(context, SignUp());
//                                   },
//                                   child: Text('REGISTER'),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//
//
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ) ,
//     );
//   }
// }
