import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Config {
  static final WebSocketLink socketLink = WebSocketLink(
    'wss://pet-drake-49.hasura.app/v1/graphql',
    config: SocketClientConfig(
      queryAndMutationTimeout: Duration(minutes: 1),
      initialPayload: () {
        return {
          'headers': {
            'x-hasura-admin-secret':
                "U8bcmJUM441Zh0n8OaqQrTa3fEktZa4rVM33gdA9A4sSdIQdKDx0eBaUsQf7AjW1"
          },
        };
      },
    ),
  );
  static ValueNotifier<GraphQLClient> initailizeClient() {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: socketLink,
      ),
    );
    return client;
  }
}

// class Config2 {
//   static final HttpLink socketLink = HttpLink(
//     'https://pet-drake-49.hasura.app/v1/graphql',
//   );
//   static ValueNotifier<GraphQLClient> initailizeClient() {
//     ValueNotifier<GraphQLClient> client = ValueNotifier(
//       GraphQLClient(
//         cache: GraphQLCache(),
//         link: socketLink,
//       ),
//     );
//     return client;
//   }
// }
