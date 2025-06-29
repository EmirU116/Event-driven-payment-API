using System;

namespace CardFolder.CardDataModel
{
    public enum AuthMethod
    {
        // Represents the method of authentication used in a transaction
        None,          // No authentication method used
        Signature,     // Authentication via signature
        Pin,           // Authentication via PIN entry
        Biometric,     // Authentication via biometric methods (e.g., fingerprint, facial recognition)
        TwoFactor,     // Authentication via two-factor methods (e.g., SMS code, authenticator app)
        Other          // Any other authentication method not specified above
    }
}