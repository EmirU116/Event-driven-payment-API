using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace cardswipe
{
    public class HttpCardTrigger
    {
        private readonly ILogger<HttpCardTrigger> _logger;

        public HttpCardTrigger(ILogger<HttpCardTrigger> logger)
        {
            _logger = logger;
        }

        [Function("HttpCardTrigger")]
        public IActionResult Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post")] HttpRequest req)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");
            return new OkObjectResult("Welcome to Azure Functions!");
        }
    }
}
