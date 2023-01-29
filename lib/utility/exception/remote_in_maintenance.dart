class RemoteInMaintenanceException implements Exception{
  const RemoteInMaintenanceException();

  @override
  String toString() {
    return 'Remote Server in maintenance mode';
  }
}