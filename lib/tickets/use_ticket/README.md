# use_ticket feature

This feature handles spending an owned ticket on a selected drink.

## Entry point

The feature entry point is:

- The static method `UseTicketModal.show(...)` in [`ui/use_ticket_modal.dart`](./ui/use_ticket_modal.dart).

It is currently invoked from:

- `MyTicketsSection` from the `my_tickets` feature in [`../my_tickets/ui/my_tickets_section.dart`](../my_tickets/ui/my_tickets_section.dart), when the user taps an active owned ticket.

## High-level flow

1. A user taps an owned ticket in `my_tickets`.
2. `UseTicketModal.show(...)` opens a fullscreen transparent route and creates the feature dependencies:
   - `UseTicketRepository`
   - `UseTicketRemoteDataProvider`
   - `UseTicketCubit`
3. `UseTicketCubitListener` wraps the modal UI and reacts to cubit states:
   - shows loading overlay during `UseTicketLoading`
   - hides loading when loading ends
   - closes the modal on `UseTicketSuccess`
   - closes the modal on `UseTicketFailure`
4. After the modal route is dismissed with a success/failure outcome,
   `UseTicketModal.show(...)` displays either a success dialog or an error
   dialog in the parent context.
5. `UseTicketCard` drives the user interaction:
   - user selects a drink
   - user swipes to confirm usage
6. On swipe submit, the selected `Drink.id` and ticket id are sent to:
   - `UseTicketCubit.useTicket(ticketId, drinkId)`
7. Cubit calls repository -> remote provider -> API (`v2.ticketsUsePost`).

## Folder structure

- `bloc/`
  - `use_ticket_cubit.dart`: orchestration and state transitions.
  - `use_ticket_state.dart`: `Initial`, `Loading`, `Success`, `Failure`.
- `data/`
  - `use_ticket_repository.dart`: maps transport models to domain model.
  - `use_ticket_remote_data_provider.dart`: API call execution.
  - `used_ticket_info.dart`: successful result model.
- `ui/`
  - `use_ticket_modal.dart`: route composition + state listener side effects.
  - `use_ticket_card.dart`: two-step UX (select + swipe).
  - small UI building blocks (`slide_action.dart`, `next_button.dart`, etc.).

## State contract

`UseTicketCubit` emits:

- `UseTicketInitial`: idle/default.
- `UseTicketLoading`: ticket spend request in progress.
- `UseTicketSuccess`: spend succeeded (contains drink name, ticket name, timestamp).
- `UseTicketFailure`: spend failed (contains failure reason).

UI side effects are intentionally state-driven and centralized in `UseTicketCubitListener`.

## Notes

- Drink selection is modeled with `Drink` objects (not only names), so API calls use stable ids.
- The feature currently creates its cubit/repository stack at route-entry (`UseTicketModal.show`) rather than app-level dependency injection.
