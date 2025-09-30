import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import { PrismaClient } from "@prisma/client";
import { Server } from "socket.io";
import http from "http";

dotenv.config();
const prisma = new PrismaClient();
const app = express();
app.use(cors());
app.use(express.json());

const server = http.createServer(app);
const io = new Server(server, { cors: { origin: "*" } });

const PORT = process.env.PORT || 8080;

// ✅ Add this health check route here 👇
app.get("/", (req, res) => {
  res.send("🚀 QR Menu backend is running successfully!");
});

/* ✅ Fetch menu for a specific restaurant + table */
app.get("/api/menu/:slug/:tableNumber", async (req, res) => {
  try {
    const { slug } = req.params;

    const restaurant = await prisma.restaurant.findUnique({
      where: { slug },
      include: { categories: { include: { items: true } } },
    });

    if (!restaurant) {
      return res.status(404).json({ error: "Restaurant not found" });
    }

    res.json({
      name: restaurant.name,
      categories: restaurant.categories.map(c => ({
        id: c.id,
        name: c.name,
        items: c.items,
      })),
    });
  } catch (error) {
    console.error("❌ Failed to load menu:", error);
    res.status(500).json({ error: "Failed to load menu" });
  }
});

/* ✅ Place a new order + store customer info */
app.post("/api/order", async (req, res) => {
  try {
    const { slug, tableNumber, customerName, phone, items } = req.body;

    const restaurant = await prisma.restaurant.findUnique({ where: { slug } });
    if (!restaurant) return res.status(404).json({ error: "Restaurant not found" });

    const table = await prisma.table.findFirst({
      where: { restaurantId: restaurant.id, number: parseInt(tableNumber) },
    });
    if (!table) return res.status(404).json({ error: "Table not found" });

    // ✅ Create or update customer by phone (ensure phone is @unique in Prisma schema)
    const customer = await prisma.customer.upsert({
      where: { phone },
      update: { name: customerName },
      create: {
        name: customerName,
        phone,
        restaurantId: restaurant.id,
      },
    });

    // ✅ Create order with items
    const order = await prisma.order.create({
      data: {
        restaurantId: restaurant.id,
        tableId: table.id,
        customerId: customer.id,
        total: items.reduce((sum, i) => sum + i.price * i.qty, 0),
        status: "PLACED",
        items: {
          create: items.map(i => ({
            quantity: i.qty,
            unitPrice: i.price,
            menuItemId: i.id,
          })),
        },
      },
      include: {
        customer: true,
        table: true,
        items: { include: { menuItem: true } },
      },
    });

    // 🔔 Notify admin dashboard in real-time
    io.emit("newOrder", order);

    res.json({ message: "✅ Order placed!", order });
  } catch (e) {
    console.error("❌ Failed to place order:", e);
    res.status(500).json({ error: "Failed to place order" });
  }
});

/* ✅ Get all orders */
app.get("/api/orders", async (req, res) => {
  try {
    const orders = await prisma.order.findMany({
      include: {
        table: true,
        customer: true,
        items: { include: { menuItem: true } }
      },
      orderBy: { createdAt: "desc" }
    });
    res.json(orders);
  } catch (err) {
    console.error("❌ Failed to fetch orders:", err);
    res.status(500).json({ error: "Failed to fetch orders" });
  }
});


/* ✅ Get all waiters */
app.get("/api/waiters", async (req, res) => {
  try {
    const waiters = await prisma.user.findMany({
      where: { role: "WAITER" },
      select: { id: true, name: true, email: true },
    });
    res.json(waiters);
  } catch (error) {
    console.error("❌ Failed to fetch waiters:", error);
    res.status(500).json({ error: "Failed to fetch waiters" });
  }
});

/* ✅ Assign waiter to order */
app.post("/api/orders/:id/assign", async (req, res) => {
  const { id } = req.params;
  const { waiterId } = req.body;

  try {
    // 1️⃣ Create assignment
    const assignment = await prisma.assignment.create({
      data: {
        orderId: parseInt(id),
        waiterId: parseInt(waiterId),
      },
    });

    // 2️⃣ Update order status
    const updatedOrder = await prisma.order.update({
      where: { id: parseInt(id) },
      data: { status: "ASSIGNED" },
      include: {
        table: true,
        customer: true,
        items: { include: { menuItem: true } },
        assignment: { include: { waiter: true } },
      },
    });

    // 🔔 Notify dashboard
    io.emit("orderUpdated", updatedOrder);

    res.json({ message: "✅ Waiter assigned successfully", assignment });
  } catch (error) {
    console.error("❌ Failed to assign waiter:", error);
    res.status(500).json({ error: "Failed to assign waiter" });
  }
});

server.listen(PORT, () =>
  console.log(`✅ Server running on http://localhost:${PORT}`)
);
