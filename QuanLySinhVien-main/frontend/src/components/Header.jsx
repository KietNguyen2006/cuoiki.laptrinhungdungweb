import React from "react";

const Header = () => {
  return (
    <header className="bg-white shadow px-6 py-4 flex items-center justify-between">
      <div className="font-bold text-lg text-gray-700">Quản lý sinh viên</div>
      <div>
        {/* Thêm các nút, avatar, thông báo... nếu cần */}
        <span className="text-gray-500">Xin chào, Admin</span>
      </div>
    </header>
  );
};

export default Header;
// ... existing code ...