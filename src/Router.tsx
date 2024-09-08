// src/Router.tsx
// import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
// import Home from './pages/Home/Home';
import ProductPage from './pages/ProductPage/ProductPage';
import App from './App';

const AppRouter = () => (
  <Router>
    <Routes>
      <Route path="/" element={<App />} />
      <Route path="/product" element={<ProductPage />} />
    </Routes>
  </Router>
);

export default AppRouter;
