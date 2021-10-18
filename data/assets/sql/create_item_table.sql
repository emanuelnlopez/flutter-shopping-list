CREATE TABLE items
(
  categoryId TEXT,
  id TEXT PRIMARY KEY,
  name TEXT,
  price REAL,
  purchaseDate INTEGER,
  quantity INTEGER,
  shoppingListId TEXT,
  FOREIGN KEY (shoppingListId) REFERENCES shopping_lists (id) ON DELETE CASCADE,
  FOREIGN KEY (categoryId) REFERENCES categories (id) ON DELETE SET NULL,
);