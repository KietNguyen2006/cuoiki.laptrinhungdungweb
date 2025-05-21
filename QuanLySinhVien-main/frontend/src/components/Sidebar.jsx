import React from "react";
import { Link, useLocation } from "react-router-dom";

const menu = [
  { path: "/", label: "Dashboard" },
  { path: "/sinhvien", label: "Quản lý sinh viên" },
  { path: "/lop", label: "Quản lý lớp" },
  // Thêm các mục khác nếu cần
];

const Sidebar = () => {
  const location = useLocation();
  return (
    <aside className="w-64 bg-white shadow-md min-h-screen">
      <div className="p-6 font-bold text-xl text-blue-600">TailAdmin</div>
      <nav>
        <ul>
          {menu.map((item) => (
            <li key={item.path}>
              <Link
                to={item.path}
                className={`block px-6 py-3 hover:bg-blue-100 ${
                  location.pathname === item.path ? "bg-blue-200 font-semibold" : ""
                }`}
              >
                {item.label}
              </Link>
            </li>
          ))}
        </ul>
      </nav>
    </aside>
  );
};

export default Sidebar;
// ... existing code ...