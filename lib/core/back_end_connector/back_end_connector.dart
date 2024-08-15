import 'package:http/http.dart' as http;

class BackEndConnector {
  final String _baseUrl = 'https://raw.githubusercontent.com/'
      'WellingtonBipo/delivery_test/main/backend_mock/apis';

  Future<BackEndConnectorResponse> getTopOffers() async {
    final response = await http.get(Uri.parse('$_baseUrl/top_offers.json'));
    return BackEndConnectorResponse._fromResponse(response);
  }

  Future<BackEndConnectorResponse> getCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/categories.json'));
    return BackEndConnectorResponse._fromResponse(response);
  }

  Future<BackEndConnectorResponse> getSpecialOffers() async {
    final response = await http.get(Uri.parse('$_baseUrl/special_offers.json'));
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

final class BackEndConnectorResponseError extends BackEndConnectorResponse {
  BackEndConnectorResponseError({
    required super.statusCode,
    required this.error,
  });
  final String error;
}
