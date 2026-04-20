# use_ticket feature

This feature handles spending an owned ticket on a selected drink.

## Entry point

The feature entry point is:

- The static method `UseTicketModal.show(...)` in [`ui/use_ticket_modal.dart`](./ui/use_ticket_modal.dart). The method currently takes:
  - `context`
  - `ticket`
  - `onTicketUsedSuccessfully` (callback used to refresh owned tickets in the caller context)

It is currently invoked from:

- `OwnedTicketCard` in [`../my_tickets/ui/owned_ticket_card.dart`](../my_tickets/ui/owned_ticket_card.dart), which is rendered by `MyTicketsSection` (from the `my_tickets` feature).

## High-level flow

1. A user taps an owned ticket in `my_tickets`.
2. `OwnedTicketCard` calls `UseTicketModal.show(...)` and passes `onTicketUsedSuccessfully`, currently bound to `OwnedTicketsCubit.refreshOwnedTickets()`.
3. `UseTicketModal.show(...)` pushes a fullscreen transparent route on the root navigator (with fade transitions).
4. `UseTicketModal` creates feature dependencies at route entry:
   - `UseTicketRepository`
   - `UseTicketRemoteDataProvider`
   - `UseTicketCubit`
5. A `BlocConsumer<UseTicketCubit, UseTicketState>` drives the modal UI:
   - `UseTicketInitial` -> `UseTicketScreen`
   - `UseTicketLoading` -> `UseTicketLoadingScreen`
   - `UseTicketSuccess` -> `UseTicketSuccessScreen` (currently placeholder)
   - `UseTicketFailure` -> `UseTicketFailureScreen`
6. In the cubit listener, on `UseTicketSuccess`,
   `onTicketUsedSuccessfully()` is called to refresh owned tickets.
7. `UseTicketCard` drives the user interaction:
   - user selects a drink
   - user swipes to confirm usage
8. On swipe submit, the selected `Drink.id` and ticket id are sent to:
   - `UseTicketCubit.useTicket(ticketId, drinkId)`
9. Cubit emits loading, calls repository -> remote provider -> API (`v2.ticketsUsePost`), then emits success or failure.

## Folder structure

- `bloc/`
  - `use_ticket_cubit.dart`: orchestration and state transitions.
  - `use_ticket_state.dart`: `Initial`, `Loading`, `Success`, `Failure`.
- `data/`
  - `use_ticket_repository.dart`: maps transport models to domain model.
  - `use_ticket_remote_data_provider.dart`: API call execution.
  - `used_ticket_info.dart`: successful result model.
- `ui/`
  - `use_ticket_modal.dart`: route composition, state-driven screen switching, and success refresh callback invocation.
  - `use_ticket_card.dart`: two-step UX (select + swipe).
  - small UI building blocks (`animated_fade_switcher_sized.dart`, `slide_action.dart`, `next_button.dart`, etc.).

## State contract

`UseTicketCubit` emits:

- `UseTicketInitial`: idle/default.
- `UseTicketLoading`: ticket spend request in progress.
- `UseTicketSuccess`: spend succeeded
  (contains `drinkName`, `ticketName`, `usedAt`).
- `UseTicketFailure`: spend failed (contains failure reason).

UI side effects are state-driven and currently handled inside `BlocConsumer` in `use_ticket_modal.dart`.

## Notes

- Drink selection is modeled with `Drink` objects (not only names), so API calls use stable ids.
- The feature currently creates its cubit/repository stack at route-entry (`UseTicketModal.show`) rather than app-level dependency injection.
- `UseTicketCubit.useTicket(...)` currently includes a temporary 3-second simulated delay before calling the repository.
- The success screen is still a placeholder dialog; there is an in-code `FIXME` to replace it with a proper receipt view.
