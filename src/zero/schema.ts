// These data structures define your client-side schema.
// They must be equal to or a subset of the server-side schema.
// Note the "relationships" field, which defines first-class
// relationships between tables.
// See https://github.com/rocicorp/mono/blob/main/apps/zbugs/src/domain/schema.ts
// for more complex examples, including many-to-many.

import {
  ANYONE_CAN,
  type ExpressionBuilder,
  type PermissionsConfig,
  type Row,
  createSchema,
  definePermissions,
  number,
  relationships,
  string,
  table,
} from "@rocicorp/zero";

const category = table("categories")
  .columns({
    id: string(),
    parentId: string().optional().from("parent_id"),
    name: string(),
    slug: string(),
    description: string().optional(),
    createdAt: number().from("created_at"),
    updatedAt: number().from("updated_at"),
  })
  .primaryKey("id");

const user = table("users")
  .columns({
    id: string(),
    firstName: string().from("first_name"),
    lastName: string().from("last_name"),
    email: string(),
    passwordHash: string().from("password_hash"),
    createdAt: number().from("created_at"),
    updatedAt: number().from("updated_at"),
  })
  .primaryKey("id");

const product = table("products")
  .columns({
    id: string(),
    categoryId: string().optional().from("category_id"),
    name: string(),
    slug: string(),
    sku: string(),
    price: number(),
    imageUrl: string().optional().from("image_url"),
    quantity: number(),
    description: string().optional(),
    createdAt: number().from("created_at"),
    updatedAt: number().from("updated_at"),
  })
  .primaryKey("id");

const order = table("orders")
  .columns({
    id: string(),
    userId: string().optional().from("user_id"),
    status: string<"cart" | "ordered">(),
    createdAt: number().from("created_at"),
    updatedAt: number().from("updated_at"),
  })
  .primaryKey("id");

const orderItem = table("order_items")
  .columns({
    orderId: string().from("order_id"),
    productId: string().from("product_id"),
    quantity: number(),
    unitPrice: number().from("unit_price"),
  })
  .primaryKey("orderId", "productId");

// Define relationships
const categoryRelationships = relationships(category, ({ one, many }) => ({
  parent: one({
    sourceField: ["parentId"],
    destField: ["id"],
    destSchema: category,
  }),
  products: many({
    sourceField: ["id"],
    destField: ["categoryId"],
    destSchema: product,
  }),
  subCategories: many({
    sourceField: ["id"],
    destField: ["parentId"],
    destSchema: category,
  }),
  parentCategory: one({
    sourceField: ["parentId"],
    destField: ["id"],
    destSchema: category,
  }),
}));

const productRelationships = relationships(product, ({ one }) => ({
  category: one({
    sourceField: ["categoryId"],
    destField: ["id"],
    destSchema: category,
  }),
}));

const orderRelationships = relationships(order, ({ one, many }) => ({
  user: one({
    sourceField: ["userId"],
    destField: ["id"],
    destSchema: user,
  }),
  items: many({
    sourceField: ["id"],
    destField: ["orderId"],
    destSchema: orderItem,
  }),
}));

const orderItemRelationships = relationships(orderItem, ({ one }) => ({
  order: one({
    sourceField: ["orderId"],
    destField: ["id"],
    destSchema: order,
  }),
  product: one({
    sourceField: ["productId"],
    destField: ["id"],
    destSchema: product,
  }),
}));

export const schema = createSchema({
  tables: [category, user, product, order, orderItem],
  relationships: [
    categoryRelationships,
    productRelationships,
    orderRelationships,
    orderItemRelationships,
  ],
});

export type Schema = typeof schema;
export type Category = Row<typeof schema.tables.categories>;
export type User = Row<typeof schema.tables.users>;
export type Product = Row<typeof schema.tables.products>;
export type Order = Row<typeof schema.tables.orders>;
export type OrderItem = Row<typeof schema.tables.order_items>;

// The contents of your decoded JWT.
type AuthData = {
  sub: string | null;
};

export const permissions = definePermissions<AuthData, Schema>(schema, () => {
  const allowIfLoggedIn = (
    authData: AuthData,
    { cmpLit }: ExpressionBuilder<Schema, keyof Schema["tables"]>
  ) => cmpLit(authData.sub, "IS NOT", null);

  const allowIfOrderOwner = (
    authData: AuthData,
    { or, cmp }: ExpressionBuilder<Schema, "orders">
  ) => {
    return or(cmp("userId", "IS", null), cmp("userId", "=", authData.sub ?? ""));
  };

  return {
    categories: {
      row: {
        select: ANYONE_CAN,
      },
    },
    users: {
      row: {
        select: ANYONE_CAN,
        // Users can only update their own profile
        update: {
          preMutation: [allowIfLoggedIn],
          postMutation: [(authData, { cmp }) => cmp("id", "=", authData.sub ?? "")],
        },
      },
    },
    products: {
      row: {
        select: ANYONE_CAN,
      },
    },
    orders: {
      row: {
        select: [allowIfOrderOwner],
        insert: ANYONE_CAN,
        update: {
          preMutation: [allowIfOrderOwner],
          postMutation: [allowIfOrderOwner],
        },
        delete: [allowIfOrderOwner],
      },
    },
    order_items: {
      row: {
        select: ANYONE_CAN,
        insert: ANYONE_CAN,
        update: {
          preMutation: ANYONE_CAN,
          postMutation: ANYONE_CAN,
        },
        delete: ANYONE_CAN,
      },
    },
  } satisfies PermissionsConfig<AuthData, Schema>;
});

export default {
  schema,
  permissions,
};
