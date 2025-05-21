using QuanLySinhVienApi.Repositories;
using Microsoft.IdentityModel.Tokens;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddSingleton<SinhVienRepository>();
builder.Services.AddSingleton<LopRepository>();
builder.Services.AddSingleton<MonHocRepository>();
builder.Services.AddSingleton<GiaoVienRepository>();
builder.Services.AddSingleton<DiemRepository>();
builder.Services.AddSingleton<AccountRepository>();

builder.Services.AddControllers();

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

// Middleware Basic Authentication đơn giản
app.Use(async (context, next) =>
{
    // Cho phép truy cập Swagger mà không cần xác thực
    if (context.Request.Path.StartsWithSegments("/swagger"))
    {
        await next.Invoke();
        return;
    }

    string authHeader = context.Request.Headers["Authorization"];
    if (authHeader != null && authHeader.StartsWith("Basic "))
    {
        // Lấy thông tin username:password từ header
        var encodedUsernamePassword = authHeader.Substring("Basic ".Length).Trim();
        var encoding = System.Text.Encoding.GetEncoding("iso-8859-1");
        var usernamePassword = encoding.GetString(Convert.FromBase64String(encodedUsernamePassword));

        var seperatorIndex = usernamePassword.IndexOf(':');
        var username = usernamePassword.Substring(0, seperatorIndex);
        var password = usernamePassword.Substring(seperatorIndex + 1);

        // Kiểm tra username và password (hard-code)
        if (username == "admin" && password == "Abc@123")
        {
            await next.Invoke();
            return;
        }
    }
    context.Response.Headers["WWW-Authenticate"] = "Basic";
    context.Response.StatusCode = 401;
    await context.Response.WriteAsync("Unauthorized");
    return;
});

app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();
app.Run();