# Receipts

Receipt history (purchases, ticket swipes, vouchers).

## Caveats

- **WIP.** Deviates from the standards in a few ways that will be fixed when the feature is finished:
  - The cubit has separate `getReceipts`/`refreshReceipts` methods instead of the standard single `load<Thing>()` method.
  - `PurchaseReceipt.status` is stored as a `String`; it should become a domain-level enum.
  - Mapping lives in `models/receipt_mappers.dart` instead of in the repository (see the "Folder layout and barrel files" section in `CONTRIBUTING.md`).
  - Pagination scaffolding (`continuationToken`, `batchSize`, commented-out `loadMoreReceipts`) is present but unused.
- Fetches **raw JSON** instead of the generated models, because the generated polymorphic decoding loses concrete receipt fields.
- Only *completed* purchases are shown; other receipt types are shown as-is. Unknown receipt types or purchase statuses fail the load (see the "API enum handling" section in `CONTRIBUTING.md`) instead of being dropped or crashing.
