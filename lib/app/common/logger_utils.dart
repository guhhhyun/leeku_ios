class Logger {
  static void write(String text, {bool isError = false}) {
    Future.microtask(() {
      if (isError) {
        print('** $text. isError: [$isError]');
      }else{
        print('** $text. ');
      }
    });
  }
}
