import 'package:blog_app/core/configs/constants/app_urls.dart';
import 'package:blog_app/data/models/auth/create_user_req.dart';
import 'package:blog_app/data/models/auth/signin_user_req.dart';
import 'package:blog_app/data/models/auth/user.dart';
import 'package:blog_app/domain/entities/auth/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> signin(SigninUserReq signinUserReq);

  Future<Either> getUser();
}

class AuthFirebaseServiceImplementation extends AuthFirebaseService {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserReq.email, password: signinUserReq.password);
      return const Right("Sign-in successful");
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == "invalid-email") {
        message = "The entered email was invalid";
      } else if (e.code == "invalid-credential") {
        message = "Incorrect credentials";
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email, password: createUserReq.password);

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'name': createUserReq.fullName,
        'email': data.user?.email,
      });

      return const Right('Signup successful');
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'weak-password') {
        message = "The password entered is weak";
      } else if (e.code == "email-already-in-use") {
        message = "An account already exists with this email";
      }
      return Left(message);
    }
  }

  // @override
  // Future<Either> getUser() async {
  //   try {
  //     FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //     var user = await firebaseFirestore
  //         .collection('Users')
  //         .doc(firebaseAuth.currentUser?.uid)
  //         .get();

  //     UserModel userModel = UserModel.fromJson(user.data()!);
  //     userModel.imageUrl =
  //         firebaseAuth.currentUser?.photoURL ?? AppUrls.placeholderImage1;
  //     UserEntity userEntity = userModel.toEntity();
  //     return Right(userEntity);
  //   } catch (e) {
  //     print("an error occurred:$e");
  //     return const Left('An error occurred');
  //   }
  // }
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      // Check if the user is logged in
      if (firebaseAuth.currentUser == null) {
        print("user not authenticated");
        return const Left("User is not authenticated.");
      }

      // Fetch user document from Firestore
      var userDoc = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser!.uid)
          .get();

      // Check if document exists and contains data
      if (!userDoc.exists || userDoc.data() == null) {
        print("user data is missing");

        return const Left("User data is missing.");
      }

      // Safely handle data retrieval and assign fallback image if needed
      UserModel userModel = UserModel.fromJson(userDoc.data()!);
      userModel.imageUrl =
          firebaseAuth.currentUser?.photoURL ?? AppUrls.placeholderImage1;
      UserEntity userEntity = userModel.toEntity();

      return Right(userEntity);
    } catch (e) {
      print("Error in getUser(): $e");
      return const Left("An error occurred while fetching user data.");
    }
  }
}
