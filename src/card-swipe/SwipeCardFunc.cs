using System.Threading.Tasks;
using System.Xml.Serialization;
using Google.Protobuf;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.Extensions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using Azure.Messaging.ServiceBus;
using Microsoft.Azure.Functions.Worker.Http;
using System.Net;

namespace Company.Function;

public class SwipeCardFunc
{
    private readonly ILogger<SwipeCardFunc> _logger;

    public SwipeCardFunc(ILogger<SwipeCardFunc> logger)
    {
        _logger = logger;
    }

    [Function("SwipeCardFunc")]
    public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post")] HttpRequestData req)
    {
        var body = await req.ReadAsStringAsync();

        string ?serviceBusConnectionString = Environment.GetEnvironmentVariable("ServiceBusConnectionString"); 
        var client = new ServiceBusClient(serviceBusConnectionString);
        var sender = client.CreateSender("payment-queue");

        var message = new ServiceBusMessage(body)
        {
            ContentType = "application/json",
            Subject = "PaymentCreated"
        };

        await sender.SendMessageAsync(message);

        var response = req.CreateResponse(HttpStatusCode.OK);
        await response.WriteStringAsync("Message sent to Servcie Bus");
        return response;
    }
}