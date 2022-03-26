import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'models/country.dart';

class CountriesPage extends StatelessWidget {

  final String code;

  const CountriesPage({Key? key,required this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HttpLink link = HttpLink('https://countries.trevorblades.com/');

    ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore()))
    );


    String readRepositories = """
       query GetContinents{
       continent(code:\"$code\"){
        countries{
         name
         code
        phone
        currency
        emoji
    }
  } 
}""";

    print(gql(readRepositories).toString());
    print(readRepositories);

    return GraphQLProvider(
      client: client,
      child: Scaffold(
        body: Query(
          options: QueryOptions(document: gql(readRepositories)),
          builder: (QueryResult result, {refetch, FetchMore? fetchMore }) {

            if(result.isLoading){
              return const Center(child: CircularProgressIndicator(),);
            }

            if(result.hasException){
              return const Center(child: Text('has Error'),);
            }

            print(result.data.toString());
             List<dynamic> list = result.data!['continent']!["countries"];
             List<ContinenCountries> listCountry = [];
             for (var element in list) {
               listCountry.add(ContinenCountries.fromJson(element));
             }

             return ListView(
              children: listCountry.map((e) => Card(
                child: ListTile(

                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('name: ${e.name.toString()}'),
                      Text('code: ${e.code.toString()}'),
                      Text('currency: ${e.currency.toString()}'),
                      Text('phone: ${e.phone.toString()}'),
                    ],
                  ),


                ),
              )).toList()
            );
          },
        ),

      ),
    );
  }


}