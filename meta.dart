String makeStruct(String name) {
  return """
    
RunResult $name(List<String> options, List<String> args) {
  for(String option in options) {
    switch(option) {
      case "h":
      case "help":
        return RunResult("Usage: $name [<options/none>] <str>\\n\\nOutputs <str>.\\n\\nOptions:\\nhelp or h\\n  Display this message");
      case "none": break;
      default:
        return RunResult("Unknown option \$option: try '$name h' or '$name help' for more information.");
    }
  }
  if(args.length != 1) {
    return RunResult("Usage: $name [<options/none>] <str>\\n\\nOutputs <str>.\\n\\nOptions:\\nhelp or h\\n  Display this message");
  }
  return RunResult(args.single);
}
  """;
}