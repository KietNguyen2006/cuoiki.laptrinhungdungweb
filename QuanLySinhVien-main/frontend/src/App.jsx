import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Dashboard from "./pages/Dashboard";
import SinhVienPage from "./pages/SinhVienPage";
import GiaoVienPage from "./pages/GiaoVienPage";
import LopPage from "./pages/LopPage";
import MainLayout from "./layouts/MainLayout";
import "./App.css";

function App() {
  return (
    <BrowserRouter>
      <MainLayout>
        <Routes>
          <Route path="/" element={<Dashboard />} />
          <Route path="/sinhvien" element={<SinhVienPage />} />
          <Route path="/giaovien" element={<GiaoVienPage />} />
          <Route path="/lop" element={<LopPage />} />
        </Routes>
      </MainLayout>
    </BrowserRouter>
  );
}

export default App;
