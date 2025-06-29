using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CardFolder.CardDataModel
{
    public class Transaction
    {
        public string Id { get; set; }
        public float Amount { get; set; }
        public string Currency { get; set; }
        public string Type { get; set; }
        public string MerchantId { get; set; }
        public string TerminalId { get; set; }
        public EntryMode EntryMode { get; set; }
        public AuthMethod Authentication{ get; set; }
        public Card Card { get; set; }
        public Location Location { get; set; }
        public DateTime Timestamp { get; set; }
    }
}