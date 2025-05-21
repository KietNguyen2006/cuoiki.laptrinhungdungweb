using Dapper;
using System.Data;
using Microsoft.Data.SqlClient;
using QuanLySinhVienApi.Models;

namespace QuanLySinhVienApi.Repositories
{
    public class DiemRepository
    {
        private readonly string? _connectionString;

        public DiemRepository(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        private IDbConnection Connection => new SqlConnection(_connectionString);

        public IEnumerable<Score> GetAll()
        {
            using (var db = Connection)
            {
                return db.Query<Score>("SELECT * FROM Diem");
            }
        }

        public Score? GetById(int id)
        {
            using (var db = Connection)
            {
                return db.QueryFirstOrDefault<Score>("SELECT * FROM Diem WHERE DiemId = @Id", new { Id = id });
            }
        }

        public int Create(Score diem)
        {
            using (var db = Connection)
            {
                var sql = "INSERT INTO Diem (StudentId, SubjectId, Value, Semester) VALUES (@StudentId, @SubjectId, @Value, @Semester)";
                return db.Execute(sql, diem);
            }
        }

        public int Update(Score diem)
        {
            using (var db = Connection)
            {
                var sql = "UPDATE Diem SET StudentId = @StudentId, SubjectId = @SubjectId, Value = @Value, Semester = @Semester WHERE DiemId = @Id";
                return db.Execute(sql, diem);
            }
        }

        public int Delete(int id)
        {
            using (var db = Connection)
            {
                return db.Execute("DELETE FROM Diem WHERE DiemId = @Id", new { Id = id });
            }
        }

        public IEnumerable<Score> GetPagingFilteringSearching(int pageIndex, int pageSize, string keyword)
        {
            using (var connection = Connection)
            {
                var result = connection.Query<Score>(
                    "sp_GetDiems_Paging_Filter_Search",
                    new { PageIndex = pageIndex, PageSize = pageSize, Keyword = keyword },
                    commandType: CommandType.StoredProcedure
                );
                return result;
            }
        }
    }
}