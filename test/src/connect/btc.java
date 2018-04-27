package connect;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;



class BtcWebConnection {
	
	JSONArray BtcWebConnection () throws Exception {
		
		JSONArray returnBtcArray = null;
		String data;
		String address = "https://crix-api-endpoint.upbit.com/v1/crix/candles/minutes/1?code=CRIX.UPBIT.KRW-TRX&count=60";
		BufferedReader br;
		URL url;
		HttpURLConnection conn;
		String protocol = "GET";
		
		url = new URL(address);
		conn = (HttpURLConnection)url.openConnection();
		conn.setRequestMethod(protocol);
		br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		
		data = "{\"btc\":"+br.readLine()+"}" ;

		 try {
	         JSONParser jsonParser = new JSONParser();
	         JSONObject jsonObj = (JSONObject) jsonParser.parse(data);
	         JSONArray btcArray = (JSONArray) jsonObj.get("btc");

	         //System.arraycopy(btcArray, 0, returnBtcArray, 0, btcArray.size());
	         //System.out.println(btcArray.size());
	         returnBtcArray = btcArray;

	        /* for(int i=0 ; i<returnBtcArray.size() ; i++){

	        	 JSONObject tempObj = (JSONObject) returnBtcArray.get(i);

	        	 System.out.println(""+(i+1)+": code                 : "+tempObj.get("code")+"<br>");
	        	 System.out.println(""+(i+1)+": candleDateTime       : "+tempObj.get("candleDateTime")+"<br>");
	        	 System.out.println(""+(i+1)+": candleDateTimeKst    : "+tempObj.get("candleDateTimeKst")+"<br>");
	        	 System.out.println(""+(i+1)+": openingPrice         : "+tempObj.get("openingPrice")+"<br>");
	        	 System.out.println(""+(i+1)+": highPrice            : "+tempObj.get("highPrice")+"<br>");
	        	 System.out.println(""+(i+1)+": lowPrice             : "+tempObj.get("lowPrice")+"<br>");
	        	 System.out.println(""+(i+1)+": tradePrice           : "+tempObj.get("tradePrice")+"<br>");
	        	 System.out.println(""+(i+1)+": candleAccTradeVolume : "+tempObj.get("candleAccTradeVolume")+"<br>");
	        	 System.out.println(""+(i+1)+": candleAccTradePrice  : "+tempObj.get("candleAccTradePrice")+"<br>");
	        	 //out.println(""+(i+1)+": timestamp            : "+tempObj.get("timestamp")+"<br>");
	        	 System.out.println(""+(i+1)+": unit                 : "+tempObj.get("unit")+"<br>");

	        	  
	        	 System.out.println("\n----------------------------<BR>");
	         }*/

	     } catch (ParseException e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	     }
		 
		return returnBtcArray;

	}

}

public class btc {

	public static void main(String[] args) throws Exception {
		
		
		JSONArray arr = null;
		BtcWebConnection btc = new BtcWebConnection();
		arr = btc.BtcWebConnection();
		
		 for(int i=0 ; i<arr.size() ; i++){

        	 JSONObject tempObj = (JSONObject) arr.get(i);

        	 System.out.println(""+(i+1)+": code                 : "+tempObj.get("code")+"<br>");
        	 System.out.println(""+(i+1)+": candleDateTime       : "+tempObj.get("candleDateTime")+"<br>");
        	 System.out.println(""+(i+1)+": candleDateTimeKst    : "+tempObj.get("candleDateTimeKst")+"<br>");
        	 System.out.println(""+(i+1)+": openingPrice         : "+tempObj.get("openingPrice")+"<br>");
        	 System.out.println(""+(i+1)+": highPrice            : "+tempObj.get("highPrice")+"<br>");
        	 System.out.println(""+(i+1)+": lowPrice             : "+tempObj.get("lowPrice")+"<br>");
        	 System.out.println(""+(i+1)+": tradePrice           : "+tempObj.get("tradePrice")+"<br>");
        	 System.out.println(""+(i+1)+": candleAccTradeVolume : "+tempObj.get("candleAccTradeVolume")+"<br>");
        	 System.out.println(""+(i+1)+": candleAccTradePrice  : "+tempObj.get("candleAccTradePrice")+"<br>");
        	 //out.println(""+(i+1)+": timestamp            : "+tempObj.get("timestamp")+"<br>");
        	 System.out.println(""+(i+1)+": unit                 : "+tempObj.get("unit")+"<br>");

        	  
        	 System.out.println("\n----------------------------<BR>");
         }
	}
	
}


	
	