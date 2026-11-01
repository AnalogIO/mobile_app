# Receipts

Receipt history (purchases, ticket swipes, vouchers).

## Caveats

- `PurchaseReceipt.status` is a domain-level `PurchaseStatus` enum; unknown backend values fail the load rather than being dropped.
- Uses the Tonik-generated `ReceiptResponseReceiptsArrayOneOfModel` sealed union, so purchase, voucher and used-ticket receipts are decoded into their concrete types.
- Mapping from the generated union to the domain `Receipt` models lives in `ReceiptsRepository`.
- Pagination: `ReceiptsCubit.loadReceipts` loads the first page and `loadMoreReceipts` appends the next page. The backend always returns a continuation token, so the cubit uses an empty page (`hasMore == false`) to detect the end. A failed next page keeps the loaded receipts visible and offers a retry.
- Filtering (all / swipes / purchases / vouchers) is done client-side over the pages loaded so far. Loading more continues to fetch all receipt types, so the filter never gets stuck on a type with no entries.
- Receipts have no backend identifier, so [ReceiptDetailsScreen](presentation/screens/receipt_details_screen.dart) is opened with the already-loaded `Receipt` as route `extra`; there is no deep link to an individual receipt.
- Only *completed* purchases are shown; other receipt types are shown as-is. Unrecognised values fail during Tonik decoding instead of being dropped or crashing.
