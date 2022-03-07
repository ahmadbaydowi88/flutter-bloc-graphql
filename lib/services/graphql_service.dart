import 'package:graphql_flutter/graphql_flutter.dart';

final HttpLink httpLink = HttpLink(
  "https://examplegraphql.herokuapp.com/graphql",
);

// ValueNotifier<GraphQLClient> client = ValueNotifier(
//   GraphQLClient(
//     link: httpLink,
//     cache: GraphQLCache(
//       store: HiveStore(),
//     ),
//   ),
// );

GraphQLClient clientToQuery() {
  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );
}
