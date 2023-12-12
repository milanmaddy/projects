class TrimName{
  static String getInitials(String username) => username.isNotEmpty?
    username.trim().split(' ').map((s) => s[0]).take(2).join() : '';
}