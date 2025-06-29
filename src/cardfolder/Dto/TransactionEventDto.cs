using System;

namespace CardFolder.CardDataModel
{
    public class TransactionEventDto
    {
        [JsonPropertyName("event_type")]
        public string EventType { get; set; } // Type of the event (e.g., "transaction")

        public dateTime Timestamp { get; set; } // Timestamp of the event

        public TransactionDto Transaction { get; set; } // Details of the transaction
    }
}