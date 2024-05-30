// abstract class IAuthFacade{
//   Future<void> signInWithEmailAndPassword({required String email, required String password});
//   Future<void> signUpWithEmailAndPassword({required String email, required String password});
//   Future<void> signInWithGoogle();
//   Future<void> signOut();
//   Future<bool> isSignedIn();
//   Future<String> getUserId();
//   Future<String> getUserEmail();
//   Future<void> resetPassword({required String email});
//   Future<void> changePassword({required String password});
//   Future<void> changeEmail({required String email});
//   Future<void> changeName({required String name});
//   Future<void> changeProfilePicture({required String profilePicture});
//   Future<void> deleteAccount();
//   Future<void> sendEmailVerification();
//   Future<bool> isEmailVerified();
//   Future<void> updateEmailVerification();
//   Future<void> updatePasswordVerification();
//   Future<void> updateNameVerification();
//   Future<void> updateProfilePictureVerification();
//   Future<void> updateDeleteAccountVerification();
//   Future<void> updateChangeEmailVerification();
//   Future<void> updateChangePasswordVerification();
//   Future<void> updateChangeNameVerification();
//   Future<void> updateChangeProfilePictureVerification();
//   Future<void> updateResetPasswordVerification();
//   Future<void> updateSignInWithEmailAndPasswordVerification();
//   Future<void> updateSignUpWithEmailAndPasswordVerification();
//   Future<void> updateSignInWithGoogleVerification();
//   Future<void> updateSignOutVerification();
//   Future<void> updateIsSignedInVerification();
//   Future<void> updateGetUserIdVerification();
//   Future<void> updateGetUserEmailVerification();
//   Future<void> updateSendEmailVerificationVerification();
//   Future<void> updateIsEmailVerifiedVerification();
// }

import 'package:bloc_2/domain/core/auth_failure.dart';
import 'package:dartz/dartz.dart';

import 'valid_objects.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
