import 'package:data/data.dart';
import 'package:mocktail/mocktail.dart';

class MockScheduleRepository extends Mock implements ScheduleRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockListUsersAppResult extends Mock implements AppResult<List<User>> {}

class MockUserAppResult extends Mock implements AppResult<User> {}

class MockListSchedulesAppResult extends Mock
    implements AppResult<List<Schedule>> {}

class MockCreateScheduleAppResult extends Mock implements AppResult<bool> {}

class MockSchedule extends Mock implements Schedule {}

class MockUser extends Mock implements User {}
