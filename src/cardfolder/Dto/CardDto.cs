using System;

namespace CardFolder.CardDataModel
{
    public class CardDto
    {
        [JsonPropertyName("masked_number")]
        public string MaskedNumber { get; set; } // Masked card number for display
        [JsonPropertyName("expiry_date")]
        public string ExpiryDate { get; set; } // Card expiry date in MM/YY format
        [JsonPropertyName("cardholder_name")]
        public string CardholderName { get; set; } // Name of the cardholder
    }
}