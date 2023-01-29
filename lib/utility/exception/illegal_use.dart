class IllegalUseException implements Exception
{
  final String? description;
  const IllegalUseException([this.description]);

  @override
  String toString() {
    String result = 'IllegalUseException';
    if(description != null){
      result += ": $description";
    }

    return result;
  }
}