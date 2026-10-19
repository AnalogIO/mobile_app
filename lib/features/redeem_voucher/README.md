# Redeem voucher

Redeeming a voucher code, as a screen and via deep link.

## Caveats

- **Flat feature** by design: no cubit and no `data/`/`models/` folders. Three source files plus a barrel. It reuses the tickets feature's `TicketsRepository` and `OwnedTicketsCubit` directly.
- The submission calls `TicketsRepository.redeemVoucher` directly; the backend is the single source of truth for whether a code is valid, unused and belongs to the signed-in user. Failures are shown inline in the form (or in a dialog for the deep-link flow).
