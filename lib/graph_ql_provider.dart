import 'package:flutter/material.dart';
import 'package:graph_ql_2/api_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ClientProvider extends StatelessWidget {
  ClientProvider({Key? key,
    required this.child,
  }) : client = ApiClient.createClient(), super(key: key);

  final Widget child;
  final ValueNotifier<GraphQLClient> client;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: child,
    );
  }
}