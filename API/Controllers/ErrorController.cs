using API.Errors;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("errors/{code}")]
    [ApiExplorerSettings(IgnoreApi = true)]
    public class ErrorController : BaseApiController
    {
        public IActionResult Error(int code)
        {
            Console.WriteLine("ErrorController.cs: Error(int code) called");
            return new ObjectResult(new ApiResponse(code));
        }
    }
}