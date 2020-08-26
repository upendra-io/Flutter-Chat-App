class Utils {
  static String getUsername(String name) {
    return name;
  }

  static String getInitials(String name) {
    List<String> nameSplit = name.split(" ");
    String first = nameSplit[0][0];
    String last = nameSplit[1][0];
    return first + last;
  }

  static int stateToNum(UserState userState) {
    switch (userState) {
      case UserState.Offline:
        return 0;

      case UserState.Online:
        return 1;

      default:
        return 2;
    }
  }

  static UserState numToState(int number) {
    switch (number) {
      case 0:
        return UserState.Offline;

      case 1:
        return UserState.Online;

      default:
        return UserState.Waiting;
    }
  }
}

enum UserState {
  Offline,
  Online,
  Waiting,
}
