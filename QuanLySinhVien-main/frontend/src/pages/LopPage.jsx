import React, { useEffect, useState } from "react";
import axios from "axios";

function LopPage() {
  const [lops, setLops] = useState([]);

  useEffect(() => {
    axios.get("http://localhost:5146/api/Lop")
      .then((res) => setLops(res.data))
      .catch((err) => console.error("Lỗi khi lấy dữ liệu lớp:", err));
  }, []);

  return (
    <div>
      <h2 className="text-2xl font-bold mb-4">Danh sách lớp</h2>
      <table className="min-w-full bg-white">
        <thead>
          <tr>
            <th className="py-2 px-4 border">ID</th>
            <th className="py-2 px-4 border">Tên lớp</th>
            <th className="py-2 px-4 border">Giáo viên chủ nhiệm</th>
          </tr>
        </thead>
        <tbody>
          {lops.map((lop) => (
            <tr key={lop.lopId}>
              <td className="py-2 px-4 border">{lop.lopId}</td>
              <td className="py-2 px-4 border">{lop.tenLop}</td>
              <td className="py-2 px-4 border">{lop.giaoVienChuNhiem}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default LopPage;
// ... existing code ...