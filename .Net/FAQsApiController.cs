using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Build.Framework;
using Microsoft.Extensions.Logging;
using Sabio.Models.Domain;
using Sabio.Models.Requests;
using Sabio.Services;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;
using System.Collections.Generic;
using System.Linq.Expressions;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/faqs")]
    [ApiController]
    public class FAQsApiController : BaseApiController
    {
        private IFAQsService _service = null;
        private IAuthenticationService<int> _authService = null;
        public FAQsApiController(IFAQsService service,
            IAuthenticationService<int> authService,
            ILogger<FAQsApiController> logger) : base(logger)
        {
            _service = service;
            _authService = authService;
        }
        [HttpPost]
        public ActionResult<ItemResponse<int>> Create(FAQsAddRequest model)
        {
            ObjectResult result = null;
            try
            {
                int userId = _authService.GetCurrentUserId();
                int id = _service.Add(model, userId);
                ItemResponse<int> response = new ItemResponse<int>() { Item = id };
                result = Created201(response);
            }
            catch (Exception ex)
            {
                base.Logger.LogError(ex.ToString());
                ErrorResponse response = new ErrorResponse(ex.Message);
                result = StatusCode(500, response);
            }
            return result;
        }

        [HttpDelete("{id:int}")]
        public ActionResult<SuccessResponse> Delete(int id)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                _service.Delete(id);
                response = new SuccessResponse();
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(code, response);
        }

        [HttpGet("{id:int}")]
        [AllowAnonymous]
        public ActionResult<ItemsResponse<FAQs>> GetByCategoryId(int id)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                List<FAQs> faqsList = _service.Get(id);
                if (faqsList == null)
                {
                    code = 404;
                    response = new ErrorResponse("Application not found");
                }
                else
                {
                    response = new ItemsResponse<FAQs>() { Items = faqsList };
                }
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(code, response);
        }

        [HttpGet("")]
        [AllowAnonymous]
        public ActionResult<ItemsResponse<FAQs>> GetAll()
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                List<FAQs> faqsList = _service.GetAll();
                if (faqsList == null)
                {
                    code = 404;
                    response = new ErrorResponse("Application not found");
                }
                else
                {
                    response = new ItemsResponse<FAQs>() { Items = faqsList };
                }
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(code, response);
        }

        [HttpPut("{id:int}")]
        public ActionResult<SuccessResponse> Update(FAQsUpdateRequest model)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                int userId = _authService.GetCurrentUserId();
                _service.Update(model, userId);
                response = new SuccessResponse();
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
                base.Logger.LogError(ex.ToString());   
            }
            return StatusCode(code, response);
        }
    }
}
