part of ace;

abstract class OptionsProvider {
  
  getOption(String name);
  
  Map<String, dynamic> getOptions(List<String> optionNames);
  
  void setOption(String name, value);
  
  void setOptions(Map<String, dynamic> options);
}
