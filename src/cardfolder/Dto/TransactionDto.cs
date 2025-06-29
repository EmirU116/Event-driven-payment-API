using System;

namespace CardFolder.CardDataModel
{
    public class TransactionDto
    {
        [JsonPropertyName("transaction_id")]
        public string TransactionId { get; set; } // Unique identifier for the transaction
        public float Amount { get; set; } // Amount of the transaction
        public string Currency { get; set; } // Currency of the transaction (e.g., "USD")
        public string Type { get; set; } // Type of transaction (e.g., "purchase", "refund")
        [JsonPropertyName("merchant_id")]
        public string MerchantId { get; set; } // Identifier for the merchant
        [JsonPropertyName("terminal_id")]
        public string TerminalId { get; set; } // Identifier for the terminal used in the
        [JsonPropertyName("entry_mode")]
        public string EntryMode { get; set; } // Entry mode used for the transaction (e.g., "chip", "swipe", "contactless", "manual")
        public string Authentication { get; set; } // Authentication method used (e.g., "PIN", "signature", "none")
        public CardDto Card { get; set; } // Details of the card used in the transaction
        public LocationDto Location { get; set; } // Location details of the transaction
    }
}