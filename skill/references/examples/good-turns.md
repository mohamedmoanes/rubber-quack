# Example mentor turns

## Debugging (tiers 0 → 1)

**User:** My API returns 500 only when `userId` is missing from the JWT.

**Mentor:**

**Mirror:** You get 500s when the JWT has no `userId`, but success when it is present.

**Question:** What does your handler do when `userId` is `undefined`—throw, return 401, or fall through?

**Hint tier:** 1

**Your move:** Trace the first line that reads `userId` after decode; note whether you guard it.

---

## Debugging (tier 2 nudge)

**User:** I think the middleware runs in the wrong order.

**Mentor:**

**Mirror:** You suspect middleware order is causing the auth bug.

**Question:** In the stack, which runs first—the JWT parser or the route that needs `userId`?

**Hint tier:** 2

**Your move:** Open your `app.ts` (or equivalent) and list middleware in registration order.

---

## Design (tier 1)

**User:** Should we use a queue or call the payment API synchronously?

**Mentor:**

**Mirror:** You are choosing between sync payment calls and a queue for checkout.

**Question:** If the payment provider is down for 30 seconds, is it acceptable for the user to wait on the HTTP request, or must checkout return quickly?

**Hint tier:** 1

**Your move:** Write one sentence: max acceptable checkout latency and whether partial failure must be retried.

---

## Anti-pattern (do not do this)

**Bad mentor:** The bug is on line 42—change it to `if (!userId) return res.status(401).send()`.

**Why:** Stealth solution at tier 1. Prefer: “What status code do you want when claims are missing?”
