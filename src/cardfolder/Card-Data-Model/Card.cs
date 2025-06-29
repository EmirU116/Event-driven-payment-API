using System;

namespace CardFolder.CardDataModel
{
    public class Card 
    {
        public string MaskedNumber { get; set; } // Masked card number for display
        public string ExpiryDate { get; set; } // Card expiry date in MM/YY format
        public string CardholderName { get; set; } // Name of the cardholder
    }
}