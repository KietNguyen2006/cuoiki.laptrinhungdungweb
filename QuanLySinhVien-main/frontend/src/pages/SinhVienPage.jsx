import React, { useEffect, useState } from "react";
import axios from "axios";

function SinhVienPage() {
  const [sinhViens, setSinhViens] = useState([]);

  useEffect(() => {
    axios.get("http://localhost:5146/api/SinhVien")
      .then((res) => setSinhViens(res.data))
      .catch((err) => console.error("Lỗi khi lấy dữ liệu sinh viên:", err));
  }, []);

  return (
    <div>
      <h2 className="text-2xl font-bold mb-4">Danh sách sinh viên</h2>
      <table className="min-w-full bg-white">
        <thead>
          <tr>
            <th className="py-2 px-4 border">ID</th>
            <th className="py-2 px-4 border">Họ tên</th>
            <th className="py-2 px-4 border">Ngày sinh</th>
            <th className="py-2 px-4 border">Lớp</th>
          </tr>
        </thead>
        <tbody>
          {sinhViens.map((sv) => (
            <tr key={sv.sinhVienId}>
              <td className="py-2 px-4 border">{sv.sinhVienId}</td>
              <td className="py-2 px-4 border">{sv.hoTen}</td>
              <td className="py-2 px-4 border">{sv.ngaySinh}</td>
              <td className="py-2 px-4 border">{sv.lopId}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default SinhVienPage;
// ... existing code ...