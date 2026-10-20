# Receipts

Receipt history (purchases, ticket swipes, vouchers).

## Caveats

- `PurchaseReceipt.status` is a domain-level `PurchaseStatus` enum; unknown backend values fail the load rather than being dropped.
- **WIP.** Remaining deviation from the standards: mapping lives in `models/receipt_mappers.dart` instead of in the repository (see the "Folder layout and barrel files" section in `CONTRIBUTING.md`).
- Fetches **raw JSON** instead of the generated models, because the generated polymorphic decoding loses concrete receipt fields.
- Pagination: `ReceiptsCubit.loadReceipts` loads the first page and `loadMoreReceipts` appends the next page. The backend always returns a continuation token, so the cubit uses an empty page (`hasMore == false`) to detect the end. A failed next page keeps the loaded receipts visible and offers a retry.
- Filtering (all / swipes / purchases / vouchers) is done client-side over the pages loaded so far. Loading more continues to fetch all receipt types, so the filter never gets stuck on a type with no entries.
- Receipts have no backend identifier, so [ReceiptDetailsScreen](presentation/screens/receipt_details_screen.dart) is opened with the already-loaded `Receipt` as route `extra`; there is no deep link to an individual receipt.
- Only *completed* purchases are shown; other receipt types are shown as-is. Unknown receipt types or purchase statuses fail the load (see the "API enum handling" section in `CONTRIBUTING.md`) instead of being dropped or crashing.
