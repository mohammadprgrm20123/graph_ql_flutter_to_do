import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graph_ql_2/contiries_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'models/continentes.dart';

void main() async {
  await initHiveForFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      'https://countries.trevorblades.com/',
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: httpLink, cache: GraphQLCache(store: HiveStore()))
    );


    String readRepositories = """
        query GetContinents{
        continents{
        name
        code
         } 
        }
         """;
    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(title: Text('graphQl'),),
        body: Query(
          options: QueryOptions(document: gql(readRepositories)),
          builder: (QueryResult result,{refetch, FetchMore? fetchMore }) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return const CircularProgressIndicator();
            }

            List<dynamic> listData = result.data!['continents'];
            List<Continent> listContinent = [];

            for (var element in listData) {
              listContinent.add(Continent.fromJson(element));
            }

            return ListView(

              children:
                listContinent.map((e) =>Card(child:
                ListTile(title: Text(e.name.toString()),onTap: (){
                  Get.to(()=>CountriesPage(code: e.code.toString()));
                },))
                ).toList(),
            );
          },

        ),
      ),
    );
  }
}
