import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function main() {
  // 1️⃣ Find the restaurant by slug
  const restaurant = await prisma.restaurant.findUnique({
    where: { slug: "tasty-bites" },
  });

  if (!restaurant) {
    console.log("❌ Restaurant not found. Please create it first.");
    return;
  }

  // 2️⃣ Create a category
  const starters = await prisma.menuCategory.create({
    data: {
      name: "Starters",
      restaurantId: restaurant.id,
    },
  });

  // 3️⃣ Add menu items
  await prisma.menuItem.createMany({
    data: [
      {
        name: "Spring Rolls",
        price: 120,
        restaurantId: restaurant.id,
        categoryId: starters.id,
      },
      {
        name: "Paneer Tikka",
        price: 180,
        restaurantId: restaurant.id,
        categoryId: starters.id,
      },
      {
        name: "Grilled Chicken",
        price: 350,
        restaurantId: restaurant.id,
        categoryId: starters.id,
      },
    ],
  });

  console.log("✅ Menu data seeded successfully!");
}

main()
  .then(() => prisma.$disconnect())
  .catch((e) => {
    console.error(e);
    prisma.$disconnect();
  });
