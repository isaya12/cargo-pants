class TFirebaseAuthExceptions implements Exception {
  final String code;

  TFirebaseAuthExceptions(this.code);

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered, please use a different email.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-not-found':
        return 'There is no user corresponding to the given email address.';
      case 'user-disabled':
        return 'The user account has been disabled by an administrator.';
      case 'wrong-password':
        return 'The password is incorrect.';
      case 'weak-password':
        return 'The password is too weak. Please use a stronger password.';
      case 'invalid-verification-code':
        return 'The verification code is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid.';
      case 'quota-exceeded':
        return 'The quota for this operation has been exceeded.';
      case 'provider-already-linked':
        return 'The provider is already linked to this account.';
      case 'invalid-phone-number':
        return 'The phone number provided is invalid. Please enter a valid phone number.';
      case 'missing-phone-number':
        return 'The phone number is required for this operation.';
      case 'invalid-credential':
        return 'The supplied credential is invalid.';
      case 'operation-not-allowed':
        return 'The requested operation is not allowed.';
      case 'popup-closed-by-user':
        return 'The popup has been closed by the user before signing in.';
      case 'popup-blocked':
        return 'The sign-in popup was blocked by the browser.';
      case 'app-deleted':
        return 'The Firebase instance has been deleted.';
      case 'web-storage-unsupported':
        return 'Web storage is not supported or is disabled.';
      case 'network-request-failed':
        return 'A network request failed.';
      case 'invalid-api-key':
        return 'The API key is invalid.';
      case 'user-mismatch':
        return 'The supplied credentials do not correspond to the previously signed in user.';
      case 'keychain-error':
        return 'An error occurred when accessing the keychain.';
      case 'no-such-provider':
        return 'The requested sign-in provider does not exist.';
      case 'invalid-verification':
        return 'The verification request is invalid.';
      case 'missing-iframe-start':
        return 'An internal error occurred during the sign-in flow.';
      case 'user-token-expired':
        return 'The user\'s token has expired.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'user-cancelled':
        return 'The user cancelled the sign-in flow.';
      case 'captcha-check-failed':
        return 'The reCAPTCHA response token is invalid or expired.';
      case 'app-not-authorized':
        return 'This app is not authorized to use Firebase Authentication with the provided API key.';
      case 'web-network-request-failed':
        return 'A network request failed on the web platform.';
      case 'invalid-app-credential':
        return 'The app credential is invalid or has expired.';
      case 'invalid-tenant-id':
        return 'The tenant ID provided is invalid.';
      case 'second-factor-already-in-use':
        return 'The second factor is already enrolled on this account.';
      case 'maximum-second-factor-count-exceeded':
        return 'The maximum allowed number of second factors on a user has been exceeded.';
      case 'missing-verification-code':
        return 'The verification code is missing.';
      case 'missing-multi-factor-info':
        return 'The user does not have a multi-factor session.';
      case 'missing-multi-factor-session':
        return 'The user does not have a multi-factor session.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'email-change-needs-verification':
        return 'Email change operation requires email verification.';
      case 'unauthorized-domain':
        return 'This domain is not authorized for OAuth operations for your Firebase project.';
      case 'admin-restricted-operation':
        return 'This operation is restricted to administrators only.';
      case 'unsupported-first-factor':
        return 'The operation requires a first factor to be enabled.';
      case 'unsupported-tenant-operation':
        return 'This operation is not supported in a multi-tenant context.';
      case 'invalid-oauth-provider':
        return 'The OAuth provider configuration is invalid.';
      case 'invalid-oauth-client-id':
        return 'The OAuth client ID is invalid.';
      case 'oauth-provider-already-linked':
        return 'The OAuth provider is already linked to this account.';
      case 'email-already-exists':
        return 'The email address is already in use by another account.';
      default:
        return 'An unknown error occurred. Please try again later.';
    }
  }
}
