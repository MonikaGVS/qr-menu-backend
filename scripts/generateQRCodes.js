import fs from "fs";
import QRCode from "qrcode";

const restaurantSlug = "tasty-bites";
const totalTables = 10; // change number of tables here

const generateQRCodes = async () => {
  if (!fs.existsSync("./qrcodes")) fs.mkdirSync("./qrcodes");

  for (let i = 1; i <= totalTables; i++) {
    const url = `http://localhost:5173/r/${restaurantSlug}/t/${i}`;
    const filePath = `./qrcodes/table-${i}.png`;
    await QRCode.toFile(filePath, url);
    console.log(`✅ QR Generated: Table ${i} -> ${url}`);
  }
};

generateQRCodes();
