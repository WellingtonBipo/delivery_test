import 'package:http/http.dart' as http;

class BackEndConnector {
  final String _baseUrl = 'https://raw.githubusercontent.com/'
      'WellingtonBipo/delivery_test/main/backend_mock/apis';

  final _errorsCount = <String, int>{};

  Future<Uri> _url(int errorFrequency, String path) async {
    final errorCount = (_errorsCount[path] ?? 0) + 1;
    _errorsCount[path] = errorCount;
    final uri = Uri.parse('$_baseUrl/$path');

    if (errorCount % errorFrequency == 0) {
      await Future.delayed(const Duration(milliseconds: 1000));
      throw Exception('Forced error on => $uri');
    }
    await Future.delayed(Duration(seconds: (errorCount % errorFrequency) + 1));
    return uri;
  }

  Future<BackEndConnectorResponse> getTopOffers() async {
    final response = await http.get(await _url(2, 'top_offers.json'));
    return BackEndConnectorResponse._fromResponse(response);
  }

  Future<BackEndConnectorResponse> getCategories() async {
    final response = await http.get(await _url(3, 'categories.json'));
    return BackEndConnectorResponse._fromResponse(response);
  }

  Future<BackEndConnectorResponse> getSpecialOffers() async {
    final response = await http.get(await _url(4, 'special_offers.json'));
    return BackEndConnectorResponse._fromResponse(response);
  }
}

sealed class BackEndConnectorResponse {
  const BackEndConnectorResponse({
    required this.statusCode,
  });

  factory BackEndConnectorResponse._fromResponse(http.Response response) {
    final statusCode = response.statusCode;
    if (statusCode >= 200 && statusCode < 300) {
      return BackEndConnectorResponseSuccess(
        statusCode: statusCode,
        body: response.body,
      );
    } else {
      return BackEndConnectorResponseError(
        statusCode: statusCode,
        error: response.reasonPhrase ?? 'Unknown error',
      );
    }
  }

  final int statusCode;

  T fold<T>({
    required T Function(BackEndConnectorResponseSuccess) onSuccess,
    required T Function(BackEndConnectorResponseError) onError,
  }) {
    final _this = this;
    return switch (_this) {
      BackEndConnectorResponseSuccess() => onSuccess(_this),
      BackEndConnectorResponseError() => onError(_this),
    };
  }
}

final class BackEndConnectorResponseSuccess extends BackEndConnectorResponse {
  BackEndConnectorResponseSuccess({
    required super.statusCode,
    required this.body,
  });
  final dynamic body;
}

final class BackEndConnectorResponseError extends BackEndConnectorResponse
    implements Exception {
  BackEndConnectorResponseError({
    required super.statusCode,
    required this.error,
  });
  final String error;
}
