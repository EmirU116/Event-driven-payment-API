using System.Xml.Serialization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.Extensions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;

namespace Company.Function;

public class SwipeCardFunc
{
    private readonly ILogger<SwipeCardFunc> _logger;

    public SwipeCardFunc(ILogger<SwipeCardFunc> logger)
    {
        _logger = logger;
    }

    [Function("SwipeCardFunc")]
    public IActionResult Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post")] HttpRequest req, CardData card)
    {
        _logger.LogInformation("C# HTTP trigger function processed a request.");
        card.
        return new OkObjectResult("Welcome to Azure Functions! " + tes);

        //connect / trigger event grid function
    }
}