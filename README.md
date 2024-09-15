วิธีติดตั้ง

1. git clone https://github.com/ohmfordev/bun-react-client.git

ิ2. bun install

3. bun run dev




## index.html

ไฟล์ `index.html` เป็นจุดเริ่มต้นของแอปพลิเคชัน React โดยมีโครงสร้างพื้นฐานดังนี้:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Product Page</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
```

สังเกตว่า script ที่โหลดคือ `/src/main.tsx`

<div id="root"></div> เป็นจุดยึด (mounting point) สำหรับแอปพลิเคชัน React 

เป็นตำแหน่งในเอกสาร HTML ที่ React จะ "เกาะ" (mount) แอปพลิเคชันทั้งหมดของ
React จะจัดการและอัปเดตเนื้อหาภายใน <div> นี้โดยอัตโนมัติ
ใน main.tsx, จะมีการใช้ document.getElementById('root') เพื่อบอก React ว่าจะ render แอปพลิเคชันที่ตำแหน่งนี้
## src/main.tsx

ไฟล์ `main.tsx` เป็นจุดเริ่มต้นของ JavaScript ในแอปพลิเคชัน:
```tsx
import React from 'react';
import ReactDOM from 'react-dom/client';
import AppRouter from './';
import './index.css';

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <AppRouter />
  </React.StrictMode>,
);
```

- ไฟล์นี้ import `AppRouter` จากไฟล์ `Router.tsx`
- ใช้ `ReactDOM.createRoot()` เพื่อ render แอปพลิเคชันภายใต้ `React.StrictMode`
- import ไฟล์ CSS หลัก (`index.css`)

## src/Router.tsx

ไฟล์ `Router.tsx` กำหนดโครงสร้างการ routing ของแอปพลิเคชัน:

```tsx
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
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
```

- ใช้ `react-router-dom` สำหรับการจัดการ routing
- กำหนด route หลัก ("/") ให้แสดง `<App />` component
- กำหนด route "/product" ให้แสดง `<ProductPage />` component

## App.tsx

ไฟล์ `App.tsx` เป็น component หลักที่แสดงเมื่อเข้าสู่หน้าแรกของแอปพลิเคชัน:

```tsx
import React from 'react';

const App: React.FC = () => {
  return (
    <div>
      <h1>Welcome to our Product App</h1>
      {/* เพิ่มเนื้อหาหน้าแรกของแอปพลิเคชันที่นี่ */}
    </div>
  );
}

export default App;
```

## pages/ProductPage/ProductPage.tsx

`ProductPage.tsx` เป็น component ที่แสดงข้อมูลสินค้า:

```tsx
import React, { useState, useEffect } from 'react';
import axios from 'axios';

interface Product {
  id: number;
  title: string;
  price: number;
  description: string;
  images: string[];
}

const ProductPage: React.FC = () => {
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const response = await axios.get<{ products: Product[] }>('https://dummyjson.com/products');
        setProducts(response.data.products.slice(0, 3));
        setLoading(false);
      } catch (err) {
        setError('เกิดข้อผิดพลาดในการโหลดข้อมูลสินค้า');
        setLoading(false);
      }
    };

    fetchProducts();
  }, []);

  if (loading) return <div className="text-center text-xl font-bold mt-8">กำลังโหลด...</div>;
  if (error) return <div className="text-center text-xl font-bold mt-8 text-red-500">{error}</div>;

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-6">หน้าสินค้า</h1>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {products.map((product) => (
          <div key={product.id} className="bg-white rounded-lg shadow-md overflow-hidden">
            <img src={product.images[0]} alt={product.title} className="w-full h-48 object-cover" />
            <div className="p-4">
              <h2 className="text-xl font-semibold mb-2">{product.title}</h2>
              <p className="text-gray-600 mb-2">ราคา: {product.price.toFixed(2)} บาท</p>
              <p className="text-sm text-gray-500">{product.description}</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default ProductPage;
```
Component นี้ใช้ useState และ useEffect hooks ของ React
มีการเรียกใช้ API จาก DummyJSON เพื่อดึงข้อมูลสินค้า
แสดงสถานะ loading และ error ถ้าจำเป็น
แสดงรายการสินค้าโดยใช้ Tailwind CSS สำหรับ styling
