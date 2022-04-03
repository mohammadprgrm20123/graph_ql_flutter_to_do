


import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ApiClient{

  static Link createUrl() {
    final HttpLink httpLink = HttpLink(
      'https://hasura.io/learn/graphql',
    );
    final AuthLink authLink = AuthLink(
      headerKey: 'Authorization',
      getToken: () async => 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik9FWTJSVGM1UlVOR05qSXhSRUV5TURJNFFUWXdNekZETWtReU1EQXdSVUV4UVVRM05EazFNQSJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWRlZmF1bHQtcm9sZSI6InVzZXIiLCJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbInVzZXIiXSwieC1oYXN1cmEtdXNlci1pZCI6ImF1dGgwfDYyNDk2ZjkxODM0OTE2MDA3MDJkMjg0YSJ9LCJuaWNrbmFtZSI6ImthemVtaW5lamFkOTk1Lml0c3UiLCJuYW1lIjoia2F6ZW1pbmVqYWQ5OTUuaXRzdUB5YWhvby5jb20iLCJwaWN0dXJlIjoiaHR0cHM6Ly9zLmdyYXZhdGFyLmNvbS9hdmF0YXIvNWZjMzgwYTU5YmE0YjI0NmVkZjE2NDgxMjI0YjNjNjI_cz00ODAmcj1wZyZkPWh0dHBzJTNBJTJGJTJGY2RuLmF1dGgwLmNvbSUyRmF2YXRhcnMlMkZrYS5wbmciLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNC0wM1QwOTo1NzozOC42NjRaIiwiaXNzIjoiaHR0cHM6Ly9ncmFwaHFsLXR1dG9yaWFscy5hdXRoMC5jb20vIiwic3ViIjoiYXV0aDB8NjI0OTZmOTE4MzQ5MTYwMDcwMmQyODRhIiwiYXVkIjoiUDM4cW5GbzFsRkFRSnJ6a3VuLS13RXpxbGpWTkdjV1ciLCJpYXQiOjE2NDg5OTA0NDksImV4cCI6MTY0OTAyNjQ0OSwiYXRfaGFzaCI6ImJ1UEhkWlFONld0NU84Q0w2MDl0UWciLCJub25jZSI6IjRaRXcwd0l6SDdrQ2xUNUUwZW15QVRvSGUxSXRoWVpMIn0.ZktLe58azPJqqw3J5bBARDgjJHCB2cadjY6vgk9ytCYsnoDnhypbQ3Fzf0Sk0udc5VOJbI_CpfhQVt8Cc2Mn5HqK64Y4JEpDEtbRt5pHHjiksYa0wGTEtaJ-L7ipbPHNznQhtl_kwz7SE-YSE6Ch7FQHlV6Lct1sD437DoZ9uq2VutRoRLCv2Y6gJUG3ZL82YVhB5IQXemQ87LlVPtkhXagczu5JuN0L-U0Flqzn_CSeZNT3kQ0XCQ4DG9zb7Il2ru0Io2X11vXYdQQnV2gGp0Z7PLkkWTfDyOfVbbp_tNbbdfBgP3Hd9yjQiGx4qPHOBQLLaEVoZ641ofka0itsTw',
    );
    final Link link = authLink.concat(httpLink);
    return link;
  }

  static ValueNotifier<GraphQLClient> createClient(){
    return ValueNotifier<GraphQLClient>(
        GraphQLClient(link: createUrl(), cache: GraphQLCache(store: HiveStore())));
  }

}