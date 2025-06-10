using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;

namespace Company.Function;

public class CardSwipeFunc
{
    private readonly ILogger<CardSwipeFunc> _logger;

    public CardSwipeFunc(ILogger<CardSwipeFunc> logger)
    {
        _logger = logger;
    }

    [Function("CardSwipeFunc")]
    public IActionResult Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post")] HttpRequest req)
    {
        _logger.LogInformation("C# HTTP trigger function processed a request.");
        return new OkObjectResult("Welcome to Azure Functions!");
    }
}