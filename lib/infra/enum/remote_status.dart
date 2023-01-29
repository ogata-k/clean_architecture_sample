enum RemoteStatus {
  ok, // 200
  created, // 201
  accepted, // 202,
  movedPermanently, // 301
  movedTemporary, // 302
  badRequest, //400
  unauthorized, // 401
  paymentRequired, // 402
  forbidden, // 403
  notFound, // 404
  methodNotAllowed, //405
  notAcceptable, // 406
  conflict, // 409
  internalServerError, // 500
  badGateway, // 502
  serviceUnavailable, // 503
  unknownError, // others
}

extension RemoteStatusExt on RemoteStatus
{
  int getValue() {
    switch(this) {
      case RemoteStatus.ok:
        return 200;
      case RemoteStatus.created:
        return 201;
      case RemoteStatus.accepted:
        return 202;
      case RemoteStatus.movedPermanently:
        return 301;
      case RemoteStatus.movedTemporary:
        return 302;
      case RemoteStatus.badRequest:
        return 400;
      case RemoteStatus.unauthorized:
        return 401;
      case RemoteStatus.paymentRequired:
        return 402;
      case RemoteStatus.forbidden:
        return 403;
      case RemoteStatus.notFound:
        return 404;
      case RemoteStatus.methodNotAllowed:
        return 405;
      case RemoteStatus.notAcceptable:
        return 406;
      case RemoteStatus.conflict:
        return 409;
      case RemoteStatus.internalServerError:
        return 500;
      case RemoteStatus.badGateway:
        return 502;
      case RemoteStatus.serviceUnavailable:
        return 503;
      case RemoteStatus.unknownError:
      default:
        return -1;
    }
  }

  RemoteStatus valueOf(int statusCode) {
    switch(statusCode){
      case 200:
        return RemoteStatus.ok;
      case 201:
        return RemoteStatus.created;
      case 202:
        return RemoteStatus.accepted;
      case 301:
        return RemoteStatus.movedPermanently;
      case 302:
        return RemoteStatus.movedTemporary;
      case 400:
        return RemoteStatus.badRequest;
      case 401:
        return RemoteStatus.unauthorized;
      case 402:
        return RemoteStatus.paymentRequired;
      case 403:
        return RemoteStatus.forbidden;
      case 404:
        return RemoteStatus.notFound;
      case 405:
        return RemoteStatus.methodNotAllowed;
      case 406:
        return RemoteStatus.notAcceptable;
      case 409:
        return RemoteStatus.conflict;
      case 500:
        return RemoteStatus.internalServerError;
      case 502:
        return RemoteStatus.badGateway;
      case 503:
        return RemoteStatus.serviceUnavailable;
      default:
        return RemoteStatus.unknownError;
    }
  }
}