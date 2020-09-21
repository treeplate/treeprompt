import 'dart:io';
String path = "/home/runner/FileNavigation/workdir";
void main() {
  print("treeprompt: a simple command prompt\n\nOptions and arguments are seperated by commas and just commas\nread and print are the only commands\n");
  while(true) {
    stdout.write('>>> ');
    List<String> parts = stdin.readLineSync().split(' ');
    while(parts.length < 3) {
      parts.add("");
    }
    execute(cmds[parts[0]], parts[1].split(','), parts[2].split(','));
  }
}

Map<String, Command> cmds = {"read": read, "print": cprint};
void execute(Command command, List<String> options, List<String> args) {
  print(command(options, args).stdout);
}
RunResult read(List<String> options, List<String> args) {
  for(String option in options) {
    switch(option) {
      case "h":
      case "help":
        return RunResult("Usage: read <options/none> <file>\n\nOutputs the contents of <file>.\n\nOptions:\nhelp or h\n  Display this message");
      case "none": break;
      default:
        return RunResult("Unknown option $option: try 'read h' or 'read help' for more information.");
    }
  }
  if(args.length != 1) {
    return RunResult("Usage: read <options/none> <file>\n\nOutputs the contents of <file>.\n\nOptions:\nhelp or h\n  Display this message");
  }
  return RunResult(File(args.single[0] == "/" ? args.single : path+"/"+args.single).readAsStringSync());
}

RunResult cprint(List<String> options, List<String> args) {
  for(String option in options) {
    switch(option) {
      case "h":
      case "help":
        return RunResult("Usage: cprint [<options/none>] <str>\n\nOutputs <str>.\n\nOptions:\nhelp or h\n  Display this message");
      case "none": break;
      default:
        return RunResult("Unknown option $option: try 'cprint h' or 'cprint help' for more information.");
    }
  }
  if(args.length != 1) {
    return RunResult("Usage: cprint [<options/none>] <str>\n\nOutputs <str>.\n\nOptions:\nhelp or h\n  Display this message");
  }
  return RunResult(args.single);
}

typedef Command = RunResult Function(List<String> options, List<String> args);

class RunResult {
  RunResult(this.stdout);
  final String stdout;
}