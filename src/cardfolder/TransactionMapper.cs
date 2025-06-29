using System; 
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CardFolder
{
    public class TransactionMapper
    {
        private float amount { get; set; }
        private string currency { get; set; }
        private string cardName { get; set; }
        private string cardExpiry { get; set; }
        private string timeStamp { get; set; }
        private string cardNumber { get; set; }
        private string cardType { get; set; }
        private string cardCvv { get; set; }
        private string cardIssuer { get; set; }
        private string cardCountry { get; set; }
        private string cardId { get; set; }
        private string cardStatus { get; set; }
    }
}