import 'package:cafe_analog_app/core/profile_picture.dart';
import 'package:cafe_analog_app/features/settings/data/data_providers/account_api.dart';
import 'package:cafe_analog_app/features/settings/data/data_providers/programmes_api.dart';
import 'package:cafe_analog_app/features/settings/data/settings_repository.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockAccountApi extends Mock implements AccountApi;

class _MockProgrammesApi extends Mock implements ProgrammesApi;

api.UserResponse _response({
  api.ProfileIcon icon = api.ProfileIcon.milkCarton,
  api.ProfileBackgroundColor background = api.ProfileBackgroundColor.mossGreen,
}) {
  return api.UserResponse(
    id: 7,
    name: 'Monir',
    email: 'monir@example.com',
    privacyActivated: false,
    role: api.UserRole.customer,
    programme: const api.ProgrammeResponse(
      id: 1,
      shortName: 'SWU',
      fullName: 'Software Development',
    ),
    rankAllTime: 0,
    rankSemester: 0,
    rankMonth: 0,
    profileIcon: icon,
    profileBackgroundColor: background,
  );
}

void main() {
  late _MockAccountApi accountApi;
  late SettingsRepository repository;

  setUpAll(() {
    registerFallbackValue(const api.UpdateUserRequest());
  });

  setUp(() {
    accountApi = _MockAccountApi();
    repository = SettingsRepository(
      accountApi: accountApi,
      programmesApi: _MockProgrammesApi(),
    );
  });

  test('getProfile: maps the backend picture to a domain picture', () async {
    when(() => accountApi.getUser())
        .thenAnswer((_) => TaskEither.right(_response()));

    final result = await repository.getProfile().run();

    final profile = result.getOrElse((_) => fail('Expected a profile'));
    expect(
      profile.profilePicture,
      // `milkCarton` is the 5th icon and `mossGreen` the 9th color.
      const ProfilePicture(iconId: 4, backgroundColorId: 8),
    );
  });

  test('updateProfilePicture: sends the backend enums and returns the '
      'updated profile', () async {
    const picture = ProfilePicture(iconId: 5, backgroundColorId: 1);
    when(() => accountApi.updateUser(any())).thenAnswer(
      (_) => TaskEither.right(
        _response(
          icon: api.ProfileIcon.portaFilter,
          background: api.ProfileBackgroundColor.mintGreen,
        ),
      ),
    );

    final result = await repository.updateProfilePicture(picture).run();

    final request =
        verify(() => accountApi.updateUser(captureAny())).captured.single
            as api.UpdateUserRequest;
    expect(request.profileIcon, api.ProfileIcon.portaFilter);
    expect(
      request.profileBackgroundColor,
      api.ProfileBackgroundColor.mintGreen,
    );

    final profile = result.getOrElse((_) => fail('Expected a profile'));
    expect(profile.profilePicture, picture);
  });
}
