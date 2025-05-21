import React from "react";

function Dashboard() {
  return (
    <div className="p-6 bg-gradient-to-br from-blue-50 to-indigo-100 min-h-screen">
      <h2 className="text-4xl font-extrabold mb-8 text-indigo-700 drop-shadow-lg">Dashboard Quản lý sinh viên</h2>
      {/* Cards thống kê */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-10">
        <div className="bg-white rounded-2xl shadow-xl p-8 flex flex-col items-center hover:scale-105 transition-transform duration-300 border-b-4 border-blue-400">
          <div className="text-5xl font-extrabold text-blue-600 mb-2 drop-shadow">120</div>
          <div className="text-lg text-gray-600 font-semibold">Sinh viên</div>
        </div>
        <div className="bg-white rounded-2xl shadow-xl p-8 flex flex-col items-center hover:scale-105 transition-transform duration-300 border-b-4 border-green-400">
          <div className="text-5xl font-extrabold text-green-600 mb-2 drop-shadow">12</div>
          <div className="text-lg text-gray-600 font-semibold">Lớp học</div>
        </div>
        <div className="bg-white rounded-2xl shadow-xl p-8 flex flex-col items-center hover:scale-105 transition-transform duration-300 border-b-4 border-yellow-400">
          <div className="text-5xl font-extrabold text-yellow-600 mb-2 drop-shadow">8</div>
          <div className="text-lg text-gray-600 font-semibold">Giáo viên</div>
        </div>
      </div>

      {/* Biểu đồ placeholder */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
        <div className="bg-white rounded-2xl shadow-xl p-8">
          <div className="font-bold text-indigo-700 mb-4 text-xl">Biểu đồ số lượng sinh viên theo lớp</div>
          <div className="w-full h-56 bg-gradient-to-r from-blue-100 to-blue-200 rounded-xl flex items-center justify-center text-gray-400 text-lg font-semibold">
            (Biểu đồ sẽ hiển thị ở đây)
          </div>
        </div>
        <div className="bg-white rounded-2xl shadow-xl p-8">
          <div className="font-bold text-indigo-700 mb-4 text-xl">Biểu đồ số lượng sinh viên theo năm</div>
          <div className="w-full h-56 bg-gradient-to-r from-yellow-100 to-yellow-200 rounded-xl flex items-center justify-center text-gray-400 text-lg font-semibold">
            (Biểu đồ sẽ hiển thị ở đây)
          </div>
        </div>
      </div>
    </div>
  );
}

export default Dashboard;
// ... existing code ...