using Microsoft.AspNetCore.Mvc;
using QuanLySinhVienApi.Models;
using QuanLySinhVienApi.Repositories;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using System.Security.Claims;

namespace QuanLySinhVienApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly AccountRepository _accountRepo;
        private readonly IConfiguration _config;

        public AuthController(AccountRepository accountRepo, IConfiguration config)
        {
            _accountRepo = accountRepo;
            _config = config;
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginRequest request)
        {
            var account = _accountRepo.GetAll().FirstOrDefault(a => a.Username == request.Username);
            if (account == null || account.PasswordHash != request.Password) // Nên hash password thực tế
                return Unauthorized("Sai tài khoản hoặc mật khẩu");

            var claims = new[]
            {
                new Claim(ClaimTypes.Name, account.Username ?? ""),
                new Claim(ClaimTypes.Role, account.Role ?? "")
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: _config["Jwt:Issuer"],
                audience: _config["Jwt:Audience"],
                claims: claims,
                expires: DateTime.Now.AddHours(2),
                signingCredentials: creds
            );

            return Ok(new { token = new JwtSecurityTokenHandler().WriteToken(token) });
        }

        [HttpPost("logout")]
        public IActionResult Logout()
        {
            // Với JWT, logout chỉ cần xóa token phía client
            return Ok(new { message = "Đăng xuất thành công" });
        }
    }
}