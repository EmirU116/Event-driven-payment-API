using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.EventGrid;
using Microsoft.Extensions.Logging;
using Azure.Messaging.EventGrid;

public class EventFunc
{
    [FunctionName("EventGridProcessor")]
    public void Run(
        [EventGridTrigger] EventGridEvent eventGridEvent,
        ILogger log
    )
    {
        log.LogInformation($"Event: event recieved {eventGridEvent.EventType}");
        log.LogInformation($"Data: {eventGridEvent.Data.ToString}");

        //TODO: process event 
    }
}