enum QueryStatus {
  success,
  error;
}

class FirebaseResponse {
  final QueryStatus _queryStatus;

  final String _message;

  FirebaseResponse(this._queryStatus, this._message);

  get queryStatus => _queryStatus;

  get message => _message;
}
