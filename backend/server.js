require('dotenv').config();

const http = require('http');
const fs = require('fs');
const path = require('path');
const db = require('./config/db');

const PORT = 3000;
const PUBLIC_DIR = path.join(__dirname, '..', 'public');

const mimeTypes = {
    '.html': 'text/html',
    '.css': 'text/css',
    '.js': 'application/javascript',
    '.json': 'application/json',
    '.png': 'image/png',
    '.jpg': 'image/jpeg',
    '.gif': 'image/gif',
    '.svg': 'image/svg+xml'
};

const server = http.createServer(async (req, res) => {
    console.log(`${req.method} ${req.url}`);

    if (req.url.startsWith('/api/')) {
        if (req.url === '/api/login' && req.method === 'POST') {
            let body = '';
            req.on('data', chunk => {
                body += chunk.toString();
            });
            req.on('end', async () => {
                try {
                    const data = JSON.parse(body);
                    const { username, password } = data;

                    if (!username || !password) {
                        res.writeHead(400, { 'Content-Type': 'application/json' });
                        res.end(JSON.stringify({ success: false, message: 'Username dan password harus diisi' }));
                        return;
                    }

                    const [rows] = await db.execute('SELECT * FROM users WHERE username = ? AND password = ?', [username, password]);

                    if (rows.length > 0) {
                        res.writeHead(200, { 'Content-Type': 'application/json' });
                        res.end(JSON.stringify({ success: true, message: 'Login berhasil' }));
                    } else {
                        res.writeHead(401, { 'Content-Type': 'application/json' });
                        res.end(JSON.stringify({ success: false, message: 'Username atau password salah' }));
                    }
                } catch (error) {
                    console.error('API Error:', error);
                    res.writeHead(500, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify({ success: false, message: 'Terjadi kesalahan pada server' }));
                }
            });
            return;
        }

        if (req.url === '/api/products' && req.method === 'GET') {
            try {
                const [rows] = await db.execute('SELECT * FROM products ORDER BY id DESC');
                res.writeHead(200, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify({ success: true, data: rows }));
            } catch (error) {
                console.error('API Error:', error);
                res.writeHead(500, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify({ success: false, message: 'Terjadi kesalahan server' }));
            }
            return;
        }

        if (req.url === '/api/products' && req.method === 'POST') {
            let body = '';
            req.on('data', chunk => body += chunk.toString());
            req.on('end', async () => {
                try {
                    const data = JSON.parse(body);
                    const { name, sku, category, price, stock, description, image } = data;
                    
                    if (!name || !sku || !category || !price || !stock) {
                        res.writeHead(400, { 'Content-Type': 'application/json' });
                        res.end(JSON.stringify({ success: false, message: 'Harap lengkapi semua field wajib' }));
                        return;
                    }

                    let status = 'aman';
                    if (stock <= 5) status = 'kritis';
                    else if (stock <= 15) status = 'menipis';

                    const [result] = await db.execute(
                        'INSERT INTO products (name, sku, category, price, stock, description, status, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
                        [name, sku, category, price, stock, description || '', status, image || null]
                    );

                    res.writeHead(201, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify({ success: true, message: 'Produk berhasil ditambahkan', id: result.insertId }));
                } catch (error) {
                    console.error('API Error:', error);
                    res.writeHead(500, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify({ success: false, message: 'Terjadi kesalahan server', detail: error.message }));
                }
            });
            return;
        }

        if (req.url.startsWith('/api/products/') && req.method === 'PUT') {
            const id = req.url.split('/').pop();
            let body = '';
            req.on('data', chunk => body += chunk.toString());
            req.on('end', async () => {
                try {
                    const data = JSON.parse(body);
                    const { name, sku, category, price, stock, description } = data;

                    if (!name || !sku || !category || !price || stock === undefined) {
                        res.writeHead(400, { 'Content-Type': 'application/json' });
                        res.end(JSON.stringify({ success: false, message: 'Harap lengkapi semua field wajib' }));
                        return;
                    }

                    let status = 'aman';
                    if (stock <= 5) status = 'kritis';
                    else if (stock <= 15) status = 'menipis';

                    await db.execute(
                        'UPDATE products SET name = ?, sku = ?, category = ?, price = ?, stock = ?, description = ?, status = ? WHERE id = ?',
                        [name, sku, category, price, stock, description || '', status, id]
                    );

                    res.writeHead(200, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify({ success: true, message: 'Produk berhasil diperbarui' }));
                } catch (error) {
                    console.error('API Error:', error);
                    res.writeHead(500, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify({ success: false, message: 'Terjadi kesalahan server', detail: error.message }));
                }
            });
            return;
        }

        if (req.url.startsWith('/api/products/') && req.method === 'DELETE') {
            const id = req.url.split('/').pop();
            try {
                await db.execute('DELETE FROM products WHERE id = ?', [id]);
                res.writeHead(200, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify({ success: true, message: 'Produk berhasil dihapus' }));
            } catch (error) {
                console.error('API Error:', error);
                res.writeHead(500, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify({ success: false, message: 'Terjadi kesalahan server' }));
            }
            return;
        }

        if (req.url === '/api/analytics' && req.method === 'GET') {
            try {
                // Total penjualan (total quantity keluar)
                const [totalSalesRows] = await db.execute("SELECT COALESCE(SUM(quantity),0) as total FROM transactions WHERE type = 'out'");
                const totalSales = parseInt(totalSalesRows[0].total);

                // Pendapatan bulanan (bulan ini)
                const now = new Date();
                const monthStart = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-01`;
                const [monthlyRevRows] = await db.execute(
                    "SELECT COALESCE(SUM(total_price),0) as total FROM transactions WHERE type = 'out' AND date >= ?", [monthStart]
                );
                const monthlyRevenue = parseFloat(monthlyRevRows[0].total);

                // Produk terjual (jumlah transaksi keluar unik)
                const [soldCountRows] = await db.execute("SELECT COALESCE(SUM(quantity),0) as total FROM transactions WHERE type = 'out'");
                const productsSold = parseInt(soldCountRows[0].total);

                // Pertumbuhan: bandingkan bulan ini vs bulan lalu
                const lastMonthStart = new Date(now.getFullYear(), now.getMonth() - 1, 1).toISOString().slice(0, 10);
                const lastMonthEnd = new Date(now.getFullYear(), now.getMonth(), 0).toISOString().slice(0, 10);
                const [lastMonthRows] = await db.execute(
                    "SELECT COALESCE(SUM(total_price),0) as total FROM transactions WHERE type = 'out' AND date >= ? AND date <= ?",
                    [lastMonthStart, lastMonthEnd]
                );
                const lastMonthRev = parseFloat(lastMonthRows[0].total) || 1;
                const growth = Math.round(((monthlyRevenue - lastMonthRev) / lastMonthRev) * 100);

                // Grafik penjualan 6 bulan terakhir (per bulan)
                const salesLabels = [];
                const salesData = [];
                const monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                for (let i = 5; i >= 0; i--) {
                    const d = new Date(now.getFullYear(), now.getMonth() - i, 1);
                    const mStart = d.toISOString().slice(0, 10);
                    const mEnd = new Date(d.getFullYear(), d.getMonth() + 1, 0).toISOString().slice(0, 10);
                    salesLabels.push(monthNames[d.getMonth()]);
                    const [r] = await db.execute(
                        "SELECT COALESCE(SUM(quantity),0) as total FROM transactions WHERE type='out' AND date >= ? AND date <= ?",
                        [mStart, mEnd]
                    );
                    salesData.push(parseInt(r[0].total));
                }

                // Kategori terlaris
                const [categoryRows] = await db.execute(
                    `SELECT p.category, COALESCE(SUM(t.quantity),0) as total
                     FROM transactions t JOIN products p ON t.product_id = p.id
                     WHERE t.type = 'out'
                     GROUP BY p.category ORDER BY total DESC`
                );
                const categoryLabels = categoryRows.map(r => r.category.charAt(0).toUpperCase() + r.category.slice(1));
                const categoryData = categoryRows.map(r => parseInt(r.total));

                // Stock flow 6 bulan
                const stockFlowLabels = [];
                const stockFlowIn = [];
                const stockFlowOut = [];
                for (let i = 5; i >= 0; i--) {
                    const d = new Date(now.getFullYear(), now.getMonth() - i, 1);
                    const mStart = d.toISOString().slice(0, 10);
                    const mEnd = new Date(d.getFullYear(), d.getMonth() + 1, 0).toISOString().slice(0, 10);
                    stockFlowLabels.push(monthNames[d.getMonth()]);
                    const [inR] = await db.execute("SELECT COALESCE(SUM(quantity),0) as total FROM transactions WHERE type='in' AND date >= ? AND date <= ?", [mStart, mEnd]);
                    const [outR] = await db.execute("SELECT COALESCE(SUM(quantity),0) as total FROM transactions WHERE type='out' AND date >= ? AND date <= ?", [mStart, mEnd]);
                    stockFlowIn.push(parseInt(inR[0].total));
                    stockFlowOut.push(parseInt(outR[0].total));
                }

                // Performa
                const [avgTxRows] = await db.execute("SELECT COUNT(*) as total FROM transactions");
                const totalTx = parseInt(avgTxRows[0].total);
                const [oldestRow] = await db.execute("SELECT MIN(date) as oldest FROM transactions");
                let avgPerDay = 0;
                if (oldestRow[0].oldest) {
                    const daysDiff = Math.max(1, Math.ceil((now - new Date(oldestRow[0].oldest)) / (1000 * 60 * 60 * 24)));
                    avgPerDay = Math.round(totalTx / daysDiff);
                }

                // Top selling products
                const [topProducts] = await db.execute(
                    `SELECT p.name, p.description, p.category, SUM(t.quantity) as sold, SUM(t.total_price) as revenue
                     FROM transactions t JOIN products p ON t.product_id = p.id
                     WHERE t.type = 'out'
                     GROUP BY t.product_id ORDER BY sold DESC LIMIT 5`
                );

                res.writeHead(200, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify({
                    success: true,
                    data: {
                        totalSales,
                        monthlyRevenue,
                        productsSold,
                        growth,
                        salesLabels,
                        salesData,
                        categoryLabels,
                        categoryData,
                        stockFlowLabels,
                        stockFlowIn,
                        stockFlowOut,
                        avgPerDay,
                        topProducts: topProducts.map(p => ({
                            name: p.name,
                            description: p.description,
                            category: p.category,
                            sold: parseInt(p.sold),
                            revenue: parseFloat(p.revenue)
                        }))
                    }
                }));
            } catch (error) {
                console.error('Analytics Error:', error);
                res.writeHead(500, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify({ success: false, message: 'Terjadi kesalahan server' }));
            }
            return;
        }
        if (req.url === '/api/dashboard-stats' && req.method === 'GET') {
            try {
                const [skuRows] = await db.execute('SELECT COUNT(*) as total FROM products');
                const totalSku = skuRows[0].total;

                const [valRows] = await db.execute('SELECT SUM(stock * price) as total FROM products');
                const stockValue = parseFloat(valRows[0].total) || 0;

                const [lowRows] = await db.execute("SELECT COUNT(*) as total FROM products WHERE status IN ('menipis', 'kritis')");
                const lowStock = lowRows[0].total;

                const [totalStockRows] = await db.execute('SELECT SUM(stock) as total FROM products');
                const totalStock = parseInt(totalStockRows[0].total) || 1;
                const [soldAllRows] = await db.execute("SELECT COALESCE(SUM(quantity),0) as total FROM transactions WHERE type = 'out'");
                const totalSold = parseInt(soldAllRows[0].total) || 0;
                const turnover = totalStock > 0 ? Math.min(Math.round((totalSold / (totalStock + totalSold)) * 100), 99) : 0;

                const todayStr = new Date().toISOString().slice(0, 10);
                const [dailySold] = await db.execute(
                    "SELECT COALESCE(SUM(quantity),0) as total FROM transactions WHERE type = 'out' AND DATE(date) = ?", [todayStr]
                );
                const [dailyRevenue] = await db.execute(
                    "SELECT COALESCE(SUM(total_price),0) as total FROM transactions WHERE type = 'out' AND DATE(date) = ?", [todayStr]
                );
                const [dailyOrders] = await db.execute(
                    "SELECT COUNT(*) as total FROM transactions WHERE type = 'out' AND DATE(date) = ?", [todayStr]
                );

                const chartLabels = [];
                const chartIn = [];
                const chartOut = [];
                const dayNames = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
                for (let i = 6; i >= 0; i--) {
                    const d = new Date();
                    d.setDate(d.getDate() - i);
                    const ds = d.toISOString().slice(0, 10);
                    chartLabels.push(dayNames[d.getDay()]);
                    const [inR] = await db.execute("SELECT COALESCE(SUM(quantity),0) as total FROM transactions WHERE type='in' AND DATE(date)=?", [ds]);
                    const [outR] = await db.execute("SELECT COALESCE(SUM(quantity),0) as total FROM transactions WHERE type='out' AND DATE(date)=?", [ds]);
                    chartIn.push(parseInt(inR[0].total));
                    chartOut.push(parseInt(outR[0].total));
                }

                const [alertRows] = await db.execute("SELECT name, stock, status FROM products WHERE status IN ('menipis','kritis') ORDER BY stock ASC LIMIT 5");

                res.writeHead(200, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify({
                    success: true,
                    data: {
                        totalSku,
                        stockValue,
                        lowStock,
                        turnover,
                        dailySold: parseInt(dailySold[0].total),
                        dailyRevenue: parseFloat(dailyRevenue[0].total),
                        dailyOrders: parseInt(dailyOrders[0].total),
                        chartLabels,
                        chartIn,
                        chartOut,
                        alerts: alertRows
                    }
                }));
            } catch (error) {
                console.error('Dashboard Stats Error:', error);
                res.writeHead(500, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify({ success: false, message: 'Terjadi kesalahan server' }));
            }
            return;
        }

        if (req.url === '/api/transactions' && req.method === 'GET') {
            try {
                const [rows] = await db.execute(
                    `SELECT t.id, t.type, t.quantity, t.total_price, t.supplier, t.destination, t.notes, t.admin, t.date,
                            p.name as product_name, p.description as product_desc
                     FROM transactions t
                     JOIN products p ON t.product_id = p.id
                     ORDER BY t.date DESC
                     LIMIT 100`
                );
                res.writeHead(200, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify({ success: true, data: rows }));
            } catch (error) {
                res.writeHead(500, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify({ success: false, message: 'Terjadi kesalahan server' }));
            }
            return;
        }

        if (req.url === '/api/transactions' && req.method === 'POST') {
            let body = '';
            req.on('data', chunk => body += chunk.toString());
            req.on('end', async () => {
                try {
                    const data = JSON.parse(body);
                    const { product_id, type, quantity, supplier, destination, notes } = data;

                    if (!product_id || !type || !quantity || quantity < 1) {
                        res.writeHead(400, { 'Content-Type': 'application/json' });
                        res.end(JSON.stringify({ success: false, message: 'Data tidak lengkap' }));
                        return;
                    }

                    const [prodRows] = await db.execute('SELECT id, price, stock FROM products WHERE id = ?', [product_id]);
                    if (prodRows.length === 0) {
                        res.writeHead(404, { 'Content-Type': 'application/json' });
                        res.end(JSON.stringify({ success: false, message: 'Produk tidak ditemukan' }));
                        return;
                    }

                    const product = prodRows[0];

                    if (type === 'out' && product.stock < quantity) {
                        res.writeHead(400, { 'Content-Type': 'application/json' });
                        res.end(JSON.stringify({ success: false, message: `Stok tidak cukup (sisa ${product.stock})` }));
                        return;
                    }

                    const totalPrice = quantity * parseFloat(product.price);

                    await db.execute(
                        'INSERT INTO transactions (product_id, type, quantity, total_price, supplier, destination, notes) VALUES (?, ?, ?, ?, ?, ?, ?)',
                        [product_id, type, quantity, totalPrice, supplier || null, destination || null, notes || null]
                    );

                    const newStock = type === 'in' ? product.stock + parseInt(quantity) : product.stock - parseInt(quantity);
                    let newStatus = 'aman';
                    if (newStock <= 5) newStatus = 'kritis';
                    else if (newStock <= 15) newStatus = 'menipis';

                    await db.execute('UPDATE products SET stock = ?, status = ? WHERE id = ?', [newStock, newStatus, product_id]);

                    res.writeHead(201, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify({ success: true, message: type === 'in' ? 'Stok berhasil ditambahkan' : 'Stok berhasil dikeluarkan' }));
                } catch (error) {
                    res.writeHead(500, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify({ success: false, message: 'Terjadi kesalahan server' }));
                }
            });
            return;
        }

        if (req.url === '/api/stock-stats' && req.method === 'GET') {
            try {
                const [inRows] = await db.execute("SELECT COALESCE(SUM(quantity),0) as total FROM transactions WHERE type = 'in'");
                const [outRows] = await db.execute("SELECT COALESCE(SUM(quantity),0) as total FROM transactions WHERE type = 'out'");

                const todayStr = new Date().toISOString().slice(0, 10);
                const [todayRows] = await db.execute("SELECT COUNT(*) as total FROM transactions WHERE DATE(date) = ?", [todayStr]);

                const [activeRows] = await db.execute(
                    `SELECT p.name FROM transactions t
                     JOIN products p ON t.product_id = p.id
                     GROUP BY t.product_id
                     ORDER BY SUM(t.quantity) DESC
                     LIMIT 1`
                );

                res.writeHead(200, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify({
                    success: true,
                    data: {
                        totalIn: parseInt(inRows[0].total),
                        totalOut: parseInt(outRows[0].total),
                        todayCount: parseInt(todayRows[0].total),
                        mostActive: activeRows.length > 0 ? activeRows[0].name : '-'
                    }
                }));
            } catch (error) {
                res.writeHead(500, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify({ success: false, message: 'Terjadi kesalahan server' }));
            }
            return;
        }

        res.writeHead(404, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: false, message: 'API endpoint not found' }));
        return;
    }

    let filePath = path.join(PUBLIC_DIR, req.url === '/' ? 'index.html' : req.url);
    
    if (!filePath.startsWith(PUBLIC_DIR)) {
        res.writeHead(403);
        res.end('Forbidden');
        return;
    }

    const extname = String(path.extname(filePath)).toLowerCase();
    const contentType = mimeTypes[extname] || 'application/octet-stream';

    fs.readFile(filePath, (err, content) => {
        if (err) {
            if (err.code === 'ENOENT') {
                res.writeHead(404, { 'Content-Type': 'text/html' });
                res.end('<h1>404 Not Found</h1><p>Halaman tidak ditemukan.</p>', 'utf-8');
            } else {
                res.writeHead(500);
                res.end(`Server Error: ${err.code}`);
            }
        } else {
            res.writeHead(200, { 'Content-Type': contentType });
            res.end(content, 'utf-8');
        }
    });
});

server.listen(PORT, () => {
    console.log(`Server is running at http://localhost:${PORT}`);
    console.log(`Press Ctrl+C to stop`);
});
