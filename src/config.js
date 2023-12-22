import { config } from "dotenv";
config();

export const database = {
  connectionLimit: 10,
  host: process.env.DATABASE_HOST || "database-1.czmjgj09b5r7.us-east-2.rds.amazonaws.com",
  user: process.env.DATABASE_USER || "admin",
  password: process.env.DATABASE_PASSWORD || "12345678",
  database: process.env.DATABASE_NAME || "final",
  port: process.env.DATABASE_PORT || 3306,
  connectTimeout: 60000,
};

export const port = process.env.PORT || 4000;

export const SECRET = process.env.SECRET || 'some secret key';