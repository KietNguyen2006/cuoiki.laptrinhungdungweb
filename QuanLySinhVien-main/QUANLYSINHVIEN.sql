-- Tạo database
CREATE DATABASE QuanLySinhVien;
GO

USE QuanLySinhVien;
GO

-- Bảng Classes
CREATE TABLE Classes (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ClassName NVARCHAR(100) NOT NULL,
    AcademicYear NVARCHAR(50) NOT NULL
);

-- Bảng Students
CREATE TABLE Students (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Gender BIT NOT NULL,
    BirthDate DATE NOT NULL,
    ClassId INT NOT NULL,
    AvatarUrl NVARCHAR(255),
    Email NVARCHAR(100),
    PhoneNumber NVARCHAR(20),
    FOREIGN KEY (ClassId) REFERENCES Classes(Id)
);

-- Bảng Subjects
CREATE TABLE Subjects (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    SubjectName NVARCHAR(100) NOT NULL,
    Credits INT NOT NULL
);

-- Bảng Teachers
CREATE TABLE Teachers (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100),
    PhoneNumber NVARCHAR(20)
);

-- Bảng Scores (liên kết N:N giữa Students và Subjects)
CREATE TABLE Scores (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    StudentId INT NOT NULL,
    SubjectId INT NOT NULL,
    Score FLOAT,
    Semester NVARCHAR(50),
    FOREIGN KEY (StudentId) REFERENCES Students(Id),
    FOREIGN KEY (SubjectId) REFERENCES Subjects(Id)
);

-- Bảng Accounts
CREATE TABLE Accounts (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) NOT NULL, -- Admin / Teacher / Student
    StudentId INT NULL,
    TeacherId INT NULL,
    FOREIGN KEY (StudentId) REFERENCES Students(Id),
    FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
);


-- Stored Procedure cho Students
-- Thêm sinh viên mới
CREATE PROCEDURE sp_Student_Create
    @FullName NVARCHAR(100),
    @Gender BIT,
    @BirthDate DATE,
    @ClassId INT,
    @AvatarUrl NVARCHAR(255),
    @Email NVARCHAR(100),
    @PhoneNumber NVARCHAR(20)
AS
BEGIN
    INSERT INTO Students (FullName, Gender, BirthDate, ClassId, AvatarUrl, Email, PhoneNumber)
    VALUES (@FullName, @Gender, @BirthDate, @ClassId, @AvatarUrl, @Email, @PhoneNumber)
END
GO

-- Lấy danh sách sinh viên (có phân trang, tìm kiếm)
CREATE PROCEDURE sp_Student_GetAll
    @Keyword NVARCHAR(100) = NULL,
    @Page INT = 1,
    @PageSize INT = 10
AS
BEGIN
    SELECT *
    FROM Students
    WHERE (@Keyword IS NULL OR FullName LIKE '%' + @Keyword + '%')
    ORDER BY Id
    OFFSET (@Page - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY
END
GO

-- Lấy sinh viên theo Id
CREATE PROCEDURE sp_Student_GetById
    @Id INT
AS
BEGIN
    SELECT * FROM Students WHERE Id = @Id
END
GO

-- Cập nhật sinh viên
CREATE PROCEDURE sp_Student_Update
    @Id INT,
    @FullName NVARCHAR(100),
    @Gender BIT,
    @BirthDate DATE,
    @ClassId INT,
    @AvatarUrl NVARCHAR(255),
    @Email NVARCHAR(100),
    @PhoneNumber NVARCHAR(20)
AS
BEGIN
    UPDATE Students
    SET FullName = @FullName,
        Gender = @Gender,
        BirthDate = @BirthDate,
        ClassId = @ClassId,
        AvatarUrl = @AvatarUrl,
        Email = @Email,
        PhoneNumber = @PhoneNumber
    WHERE Id = @Id
END
GO

-- Xóa sinh viên
CREATE PROCEDURE sp_Student_Delete
    @Id INT
AS
BEGIN
    DELETE FROM Students WHERE Id = @Id
END
GO



-- Thêm lớp mới
CREATE PROCEDURE sp_Class_Create
    @ClassName NVARCHAR(100),
    @AcademicYear NVARCHAR(50)
AS
BEGIN
    INSERT INTO Classes (ClassName, AcademicYear)
    VALUES (@ClassName, @AcademicYear)
END
GO

-- Lấy tất cả lớp
CREATE PROCEDURE sp_Class_GetAll
AS
BEGIN
    SELECT * FROM Classes
END
GO

-- Lấy lớp theo Id
CREATE PROCEDURE sp_Class_GetById
    @Id INT
AS
BEGIN
    SELECT * FROM Classes WHERE Id = @Id
END
GO

-- Cập nhật lớp
CREATE PROCEDURE sp_Class_Update
    @Id INT,
    @ClassName NVARCHAR(100),
    @AcademicYear NVARCHAR(50)
AS
BEGIN
    UPDATE Classes
    SET ClassName = @ClassName,
        AcademicYear = @AcademicYear
    WHERE Id = @Id
END
GO

-- Xóa lớp
CREATE PROCEDURE sp_Class_Delete
    @Id INT
AS
BEGIN
    DELETE FROM Classes WHERE Id = @Id
END
GO


-- Thêm môn học mới
CREATE PROCEDURE sp_Subject_Create
    @SubjectName NVARCHAR(100),
    @Credits INT
AS
BEGIN
    INSERT INTO Subjects (SubjectName, Credits)
    VALUES (@SubjectName, @Credits)
END
GO

-- Lấy tất cả môn học
CREATE PROCEDURE sp_Subject_GetAll
AS
BEGIN
    SELECT * FROM Subjects
END
GO

-- Lấy môn học theo Id
CREATE PROCEDURE sp_Subject_GetById
    @Id INT
AS
BEGIN
    SELECT * FROM Subjects WHERE Id = @Id
END
GO

-- Cập nhật môn học
CREATE PROCEDURE sp_Subject_Update
    @Id INT,
    @SubjectName NVARCHAR(100),
    @Credits INT
AS
BEGIN
    UPDATE Subjects
    SET SubjectName = @SubjectName,
        Credits = @Credits
    WHERE Id = @Id
END
GO

-- Xóa môn học
CREATE PROCEDURE sp_Subject_Delete
    @Id INT
AS
BEGIN
    DELETE FROM Subjects WHERE Id = @Id
END
GO
-- Thêm giáo viên mới
CREATE PROCEDURE sp_Teacher_Create
    @FullName NVARCHAR(100),
    @Email NVARCHAR(100),
    @PhoneNumber NVARCHAR(20)
AS
BEGIN
    INSERT INTO Teachers (FullName, Email, PhoneNumber)
    VALUES (@FullName, @Email, @PhoneNumber)
END
GO

-- Lấy tất cả giáo viên
CREATE PROCEDURE sp_Teacher_GetAll
AS
BEGIN
    SELECT * FROM Teachers
END
GO

-- Lấy giáo viên theo Id
CREATE PROCEDURE sp_Teacher_GetById
    @Id INT
AS
BEGIN
    SELECT * FROM Teachers WHERE Id = @Id
END
GO

-- Cập nhật giáo viên
CREATE PROCEDURE sp_Teacher_Update
    @Id INT,
    @FullName NVARCHAR(100),
    @Email NVARCHAR(100),
    @PhoneNumber NVARCHAR(20)
AS
BEGIN
    UPDATE Teachers
    SET FullName = @FullName,
        Email = @Email,
        PhoneNumber = @PhoneNumber
    WHERE Id = @Id
END
GO

-- Xóa giáo viên
CREATE PROCEDURE sp_Teacher_Delete
    @Id INT
AS
BEGIN
    DELETE FROM Teachers WHERE Id = @Id
END
GO
-- Thêm điểm mới
CREATE PROCEDURE sp_Score_Create
    @StudentId INT,
    @SubjectId INT,
    @Score FLOAT,
    @Semester NVARCHAR(50)
AS
BEGIN
    INSERT INTO Scores (StudentId, SubjectId, Score, Semester)
    VALUES (@StudentId, @SubjectId, @Score, @Semester)
END
GO

-- Lấy tất cả điểm
CREATE PROCEDURE sp_Score_GetAll
AS
BEGIN
    SELECT * FROM Scores
END
GO

-- Lấy điểm theo Id
CREATE PROCEDURE sp_Score_GetById
    @Id INT
AS
BEGIN
    SELECT * FROM Scores WHERE Id = @Id
END
GO

-- Cập nhật điểm
CREATE PROCEDURE sp_Score_Update
    @Id INT,
    @StudentId INT,
    @SubjectId INT,
    @Score FLOAT,
    @Semester NVARCHAR(50)
AS
BEGIN
    UPDATE Scores
    SET StudentId = @StudentId,
        SubjectId = @SubjectId,
        Score = @Score,
        Semester = @Semester
    WHERE Id = @Id
END
GO

-- Xóa điểm
CREATE PROCEDURE sp_Score_Delete
    @Id INT
AS
BEGIN
    DELETE FROM Scores WHERE Id = @Id
END
GO

-- Thêm tài khoản mới
CREATE PROCEDURE sp_Account_Create
    @Username NVARCHAR(50),
    @PasswordHash NVARCHAR(255),
    @Role NVARCHAR(20),
    @StudentId INT = NULL,
    @TeacherId INT = NULL
AS
BEGIN
    INSERT INTO Accounts (Username, PasswordHash, Role, StudentId, TeacherId)
    VALUES (@Username, @PasswordHash, @Role, @StudentId, @TeacherId)
END
GO

-- Lấy tất cả tài khoản
CREATE PROCEDURE sp_Account_GetAll
AS
BEGIN
    SELECT * FROM Accounts
END
GO

-- Lấy tài khoản theo Id
CREATE PROCEDURE sp_Account_GetById
    @Id INT
AS
BEGIN
    SELECT * FROM Accounts WHERE Id = @Id
END
GO

-- Cập nhật tài khoản
CREATE PROCEDURE sp_Account_Update
    @Id INT,
    @Username NVARCHAR(50),
    @PasswordHash NVARCHAR(255),
    @Role NVARCHAR(20),
    @StudentId INT = NULL,
    @TeacherId INT = NULL
AS
BEGIN
    UPDATE Accounts
    SET Username = @Username,
        PasswordHash = @PasswordHash,
        Role = @Role,
        StudentId = @StudentId,
        TeacherId = @TeacherId
    WHERE Id = @Id
END
GO

-- Xóa tài khoản
CREATE PROCEDURE sp_Account_Delete
    @Id INT
AS
BEGIN
    DELETE FROM Accounts WHERE Id = @Id
END
GO
select * from Scores
