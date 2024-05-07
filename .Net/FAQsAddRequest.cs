using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Requests
{
    public class FAQsAddRequest
    {
        [Required]
        [StringLength(255, MinimumLength = 1)]
        public string Question {  get; set; }
        [Required]
        [StringLength(2000, MinimumLength = 1)]
        public string Answer { get; set; }
        [Required]
        [Range(1, Int32.MaxValue)]
        public int CategoryId { get; set; }
        [Required]
        [Range(1, Int32.MaxValue)]
        public int SortOrder { get; set; }
    }
}
