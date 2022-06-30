import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:group28/utils/cart.dart';
import 'package:group28/utils/strings.dart';

class FetchPage2 extends StatelessWidget {
  
  FetchPage2({Key? key, required this.selectedDatePace,required this.obbiettivo}) : super(key: key);
   DateTime selectedDatePace;
   double? obbiettivo;
  static const route = '/';
  static const routename = 'Fetchpage2';
  
  @override
   Widget build(BuildContext context)  {
     //final List<ChartSampleData> chartData = <ChartSampleData>[];
   List <double?> stepsvalue= [null,null,null,null,null,null,null];
   List <DateTime?> datevalue= [null,null,null,null,null,null,null];
  String? userId = null;
   Future<void> _authorized() async {
      String? userId = await FitbitConnector.authorize(
        context: context,
        clientID: '238KFW',
        clientSecret: 'dab6ca5632932b7b319567a1db642803',
        redirectUri: 'example://fitbit/auth',
        callbackUrlScheme: 'example',
      );
      //Instantiate a proper data manager
     FitbitActivityTimeseriesDataManager
                    fitbitActivityTimeseriesDataManager =
                    FitbitActivityTimeseriesDataManager(
                  clientID: Strings.fitbitClientID,
                  clientSecret: Strings.fitbitClientSecret,
                  type: 'minutesSedentary', //type of resource
                );
      //Fetch data Instantiate the url of the end point of the Restful API that you want to call in order to get data
      final minutesSedentary =  await fitbitActivityTimeseriesDataManager
                    .fetch(FitbitActivityTimeseriesAPIURL.weekWithResource(
        baseDate: selectedDatePace, //We choose to fetch 1 week Data
        userID: userId,
        resource: fitbitActivityTimeseriesDataManager.type,
      )) as List<FitbitActivityTimeseriesData>;

      for (var i = 0; i < 7; i++) {
        stepsvalue[i] = minutesSedentary[i].value;
        datevalue[i] = minutesSedentary[i].dateOfMonitoring;
      }
      print('\n');
      print(stepsvalue);
      print(datevalue);

      return Provider.of<Cart>(context, listen: false)
          .addProduct(stepsvalue, datevalue);
    }
    _authorized();
         
      return Consumer <Cart>(
            builder: (context, cart, child) { 
                final chartData = _riempimento(cart.datevalue2, cart.stepsvalue2);
                 return Scaffold(
                         appBar: AppBar(
          title: Text('GraphicPage'),
          backgroundColor: Colors.purple,
        ),
            body: Column(
              children: [
                const SizedBox(height: 30.0),
                Center(
                    child: Container(
                        child:SfCartesianChart(
    primaryXAxis: CategoryAxis(),
     primaryYAxis: NumericAxis(   
       plotBands: <PlotBand>[
        PlotBand(
         // text:'GOAL_BOUND' ,
          start: obbiettivo,
          end: obbiettivo,
          //Specify the width for the line
          borderWidth: 2,
         )
      ]),
      series: <ChartSeries<ChartSampleData, DateTime>> [
        LineSeries<ChartSampleData, DateTime> (
          color: Colors.orangeAccent ,
          dataSource: chartData,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          width:3,                                
          markerSettings: MarkerSettings(
          isVisible: true,
          height:  4,
          width:  4,
          shape: DataMarkerType.circle,
          borderWidth: 3,
          borderColor: Colors.black,
         ),
        )
        
      ]
                        )       
                        )
                    ),
                     const SizedBox(height: 100.0), 
                 ElevatedButton(
              onPressed: () async {
                await FitbitConnector.unauthorize(
                    clientID: Strings.fitbitClientID,
                    clientSecret: Strings.fitbitClientSecret,);
              },
               child: Text('Tap to unauthorize',style: TextStyle(fontSize: 20),),
              style: ElevatedButton.styleFrom(
                primary: Colors.purpleAccent,
          ),
            ),
              ],
            )
            );                           
            }
      );            
}
   }
    List<ChartSampleData> _riempimento(List<DateTime?> k, List<double?> j){
      final chartData = <ChartSampleData>[];
      for (var i = 0; i < 7; i++) {
        chartData.add(ChartSampleData(x:k[i], y: j[i]));      
      }
      return chartData;
    }
       class ChartSampleData {
  ChartSampleData({this.x, this.y});
  final DateTime? x;
  final double? y;
}

    