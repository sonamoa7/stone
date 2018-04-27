package connect;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;

import java.net.URL;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;






class WebConnection {
	String json;
	WebConnection () throws Exception {
	
		String address = "https://crix-api-endpoint.upbit.com/v1/crix/candles/minutes/1?code=CRIX.UPBIT.KRW-BTC&count=10";
		BufferedReader br;
		URL url;
		HttpURLConnection conn;
		String protocol = "GET";
		
		url = new URL(address);
		conn = (HttpURLConnection)url.openConnection();
		conn.setRequestMethod(protocol);
		br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		
		json = br.readLine();
		System.out.println(json);
		//System.out.println(json.length());
		
		/*
		JSONParser parser = new JSONParser();
	    
		JSONObject univ = (JSONObject)parser.parse(json);
		
	    JSONArray arr = (JSONArray)univ.get("univ");
		
		//�׽�Ʈ���
		//System.out.println(arr.toJSONString());
		
		for(int i=0;i<arr.size();i++){
			JSONObject tmp = (JSONObject)arr.get(i);//�ε��� ��ȣ�� �����ؼ� �����´�.
			
			String professor = (String)tmp.get("code");
			String student = (String)tmp.get("candleDateTimeKst");
			
			System.out.println("----- "+i+"��° �ε��� �� -----");
			System.out.println("���� : "+professor);
			System.out.println("�л� : "+student);
		}
		*/
	}

}



public class main {
	
	public static void main(String[] args) throws Exception {
		
		WebConnection wc = new WebConnection();
		String jsonStr;
		//JSON���� Parsing�� ���ڿ� ������
         jsonStr = "{\"members\":["
                + "{\"name\":\"ȫ�浿\","
                + "\"email\":\"gildong@hong.com\","
                + "\"age\":\"25\""
                + "},"
                + "{\"name\":\"ȫ�漭\","
                + "\"email\":\"gilseo@hong.com\","
                + "\"age\":\"23\""
                + "}]}";
       
         jsonStr = "{\"members\":"+wc.json+"}";
         
         System.out.println(jsonStr);
        try {
            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObj = (JSONObject) jsonParser.parse(jsonStr);
            JSONArray memberArray = (JSONArray) jsonObj.get("members");

            System.out.println("=====Members=====");
            for(int i=0 ; i<memberArray.size() ; i++){
                JSONObject tempObj = (JSONObject) memberArray.get(i);
                System.out.println(""+(i+1)+"��° ����� �̸� : "+tempObj.get("code"));
                System.out.println(""+(i+1)+"��° ����� �̸��� : "+tempObj.get("candleDateTime"));
                System.out.println(""+(i+1)+"��° ����� ���� : "+tempObj.get("candleDateTimeKst"));
                System.out.println("----------------------------");
            }

        } catch (ParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
		

		
		
		
		
		
		
		
		
		
	}
}

