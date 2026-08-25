# Redeem voucher

Redeeming a voucher code, as a screen and via deep link.

## Caveats

- **Flat feature** by design: no cubit and no `data/`/`models/` folders. Three source files plus a barrel. It reuses the tickets feature's `TicketsRepository` and `OwnedTicketsCubit` directly.
- The submission flow contains a FIXME mock result and an artificial delay that must be removed before release.
