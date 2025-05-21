import React, { useEffect, useState } from "react";
import axios from "axios";

function GiaoVienPage() {
  const [giaoViens, setGiaoViens] = useState([]);

  useEffect(() => {
    axios.get("http://localhost:5146/api/GiaoVien")
      .then((res) => setGiaoViens(res.data))
      .catch((err) => console.error("Lỗi khi lấy dữ liệu giáo viên:", err));
  }, []);

  return (
    <div>
      <h2 className="text-2xl font-bold mb-4">Danh sách giáo viên</h2>
      <table className="min-w-full bg-white">
        <thead>
          <tr>
            <th className="py-2 px-4 border">ID</th>
            <th className="py-2 px-4 border">Họ tên</th>
            <th className="py-2 px-4 border">Bộ môn</th>
          </tr>
        </thead>
        <tbody>
          {giaoViens.map((gv) => (
            <tr key={gv.giaoVienId}>
              <td className="py-2 px-4 border">{gv.giaoVienId}</td>
              <td className="py-2 px-4 border">{gv.hoTen}</td>
              <td className="py-2 px-4 border">{gv.boMon}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default GiaoVienPage;
// ... existing code ...