# Tickets

Buying drink tickets (via MobilePay), viewing owned tickets and spending a ticket on a drink.

## Caveats

- **Contains subflows**: `presentation/` has three subfolders (`buy_tickets/`, `my_tickets/` and `use_ticket/`), each with its own `bloc/`, `screens/` and `widgets/` folders and barrel files, sharing the feature-level `data/` and `models/`.
- `PurchaseFlowCubit` states are named after flow steps (not the `<Feature><Verb>` pattern). After verification it resets to `PurchaseFlowIdle`, and `PurchaseFlowCoordinator` navigates home when `Idle` is emitted. The state machine thus encodes a UI behaviour.
- `OwnedTicketsCubit` is cache-first: the initial load shows cached tickets before fresh API data, preserving the user's preferred order. It guards against overlapping fetches with an in-flight flag.
- `UseTicketCubit` is created per modal via `UseTicketScreen.show`.
- Purchase verification polls once after a second when the status is still pending (a temporary workaround for backend timing).
- `OwnedTicketsCubit` and `TicketCatalogCubit` are scoped to the `/tickets` shell in `app/router.dart`. `PurchaseFlowCubit` is app-scoped because a router redirect reads it.
