import fs from "node:fs/promises";

export const cleanupPreviousData = async () => {
  const seedFiles = await fs
    .readdir("./docker/seeds")
    .then((files) => files.filter((file) => file.includes("generated_products_")));

  await Promise.all(
    seedFiles.map(async (fileName) => {
      const file = Bun.file(`./docker/seeds/${fileName}`);
      await file.delete();
    })
  );

  process.exit(0);
};

cleanupPreviousData().catch(console.error);
