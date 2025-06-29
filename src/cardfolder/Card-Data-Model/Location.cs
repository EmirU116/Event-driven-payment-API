using System;

namespace CardFolder.CardDataModel
{
    public class Location
    {
        public string Store { get; set; } // Name of the store or merchant
        public float Latitude { get; set; } // Latitude of the transaction location
        public float Longitude { get; set; } // Longitude of the transaction location
    }
}