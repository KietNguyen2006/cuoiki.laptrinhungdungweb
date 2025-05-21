namespace QuanLySinhVienApi.Models
{
    public class Score
    {
        public int Id { get; set; }
        public int StudentId { get; set; }
        public int SubjectId { get; set; }
        public float? Value { get; set; }
        public string? Semester { get; set; }
    }
}