
<%@page import="java.math.BigDecimal"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.BufferedReader" %>
<%@page import="java.net.URL" %>
<%@page import="java.net.HttpURLConnection" %>
<%@page import="java.io.InputStreamReader" %>
<%@page import="java.io.BufferedReader" %>
<%@page import="org.json.simple.parser.ParseException" %>
<%@page import="java.text.DecimalFormat" %>

<%@page import="connect.btc" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
/*  ▲ code : 종목코드
	▲ candleDateTime : 해당 캔들(봉) 생성 시각
	▲ candleDateTimeKst : 해당 캔들(봉) 생성 시각 (한국시각 기준. 한국은 UTC +09:00:00 임)
	
	▲ openingPrice : 해당 캔들(봉) 시가
	▲ highPrice : 해당 캔들(봉) 고가
	▲ lowPrice : 해당 캔들(봉) 저가
	▲ tradePrice : 해당 캔들(봉) 종가
	
	▲ candleAccTradeVolume : 해당 캔들(봉) 거래량
	▲ candleAccTradePrice : 해당 캔들(봉) 거래대금
	
	▲ timestamp : UNIX 기준의 타임 스탬프
	▲ unit : 조회 기준 (본문의 조회 요청문중 3번에 해당하는 값과 일치) */
//trx START------------------------------------------------------------------------------------------------------------
	String trxCode         = null;
         
    //가격
    String trxOneMinFirstOpeningPrice  = null;
    String trxOneMinSecOpeningPrice    = null;
    String trxTenMinSecOpeningPrice    = null;
    String trxThirtyMinSecOpeningPrice = null;
    String trxOneHourSecOpeningPrice   = null;
    
    //율
    String trxOneMinFirstOpeningRate  = null;
    String trxTenMinOpeningRate    = null;
    String trxThirtyMinOpeningRate = null;
    String trxOneHourOpeningRate   = null;
    
    //볼륨
    String trxOneMinFirstOpeningVol  = null;         
    String trxOneMinSecOpeningVol    = null;
    String trxTenMinOpeningVol    = null;
    String trxThirtyMinOpeningVol = null;
    String trxOneHourOpeningVol   = null;
    
   //볼륨
    String trxOneMinFirstOpeningVolRate  = null;         
    String trxOneMinSecOpeningVolRate    = null;
    String trxTenMinOpeningVolRate    = null;
    String trxThirtyMinOpeningVolRate = null;
    String trxOneHourOpeningVolRate   = null;
    
    //분차이
    String trxOneMinDiffOpeningPrice = null;
    String trxtenMinDiffOpeningPrice = null;
    String trxThirtyMinDiffOpeningPrice =null ;
    String trxOneHourDiffOpeningPrice  = null;
    
    //포맷
    DecimalFormat decimalFormat = new DecimalFormat("#.##");

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
	
	data = "{\"trx\":"+br.readLine()+"}" ;
		 
	 try {
         JSONParser jsonParser = new JSONParser();
         JSONObject jsonObj = (JSONObject) jsonParser.parse(data);
         JSONArray trxArray = (JSONArray) jsonObj.get("trx");         
         JSONObject tempAlltrxObj = null;
         JSONArray tempAlltrxArry = new JSONArray();
         //trx결과
         JSONObject oneMintrxObj = new JSONObject();
         //     
         //0 inx가 최근
         for(int i=0 ; i<trxArray.size() ; i++){
        	 //1분 단위 2개
        	 tempAlltrxObj = (JSONObject) trxArray.get(i);
			 
        	
        	// openingPrice = tempAlltrxObj.get("openingPrice").toString();
        	 /* 
        	 out.println(""+(i+1)+": code                 : "+tempAlltrxObj.get("code")+"<br>");
        	 out.println(""+(i+1)+": candleDateTime       : "+tempAlltrxObj.get("candleDateTime")+"<br>");
        	 out.println(""+(i+1)+": candleDateTimeKst    : "+tempAlltrxObj.get("candleDateTimeKst")+"<br>");
        	 out.println(""+(i+1)+": openingPrice         : "+tempAlltrxObj.get("openingPrice")+"<br>");
        	 out.println(""+(i+1)+": highPrice            : "+tempAlltrxObj.get("highPrice")+"<br>");
        	 out.println(""+(i+1)+": lowPrice             : "+tempAlltrxObj.get("lowPrice")+"<br>");
        	 out.println(""+(i+1)+": tradePrice           : "+tempAlltrxObj.get("tradePrice")+"<br>");
        	 out.println(""+(i+1)+": candleAccTradeVolume : "+tempAlltrxObj.get("candleAccTradeVolume")+"<br>");
        	 out.println(""+(i+1)+": candleAccTradePrice  : "+tempAlltrxObj.get("candleAccTradePrice")+"<br>");
        	 out.println(""+(i+1)+": timestamp          : "+tempAlltrxObj.get("timestamp")+"<br>");
        	 out.println(""+(i+1)+": unit                 : "+tempAlltrxObj.get("unit")+"<br>"); 
             out.println("<BR>");
        	 */
        	 if(i == 0) {
        		  trxCode 		             = tempAlltrxObj.get("code").toString().replace("CRIX.UPBIT.KRW-", "");	 
        		  trxOneMinFirstOpeningPrice = tempAlltrxObj.get("openingPrice").toString();
        		  trxOneMinFirstOpeningVol   = tempAlltrxObj.get("candleAccTradeVolume").toString();
        	 }else if (i == 1) {
        		  trxOneMinSecOpeningPrice = tempAlltrxObj.get("openingPrice").toString();
        		  trxOneMinSecOpeningVol   = tempAlltrxObj.get("candleAccTradeVolume").toString();
        	 }else if (i == 9){
        		  trxTenMinSecOpeningPrice = tempAlltrxObj.get("openingPrice").toString();
        		  trxTenMinOpeningVol   = tempAlltrxObj.get("candleAccTradeVolume").toString();
        	 }else if (i == 29){      	 
            	
        		 trxThirtyMinSecOpeningPrice = tempAlltrxObj.get("openingPrice").toString();
        		 trxThirtyMinOpeningVol   = tempAlltrxObj.get("candleAccTradeVolume").toString();
             }else if (i == 59){
            	 trxOneHourSecOpeningPrice   = tempAlltrxObj.get("openingPrice").toString();
            	 trxOneHourOpeningVol     = tempAlltrxObj.get("candleAccTradeVolume").toString();
             }
		 // 계산
         } //end for
         
         //금액
		 trxOneMinDiffOpeningPrice    = (new BigDecimal(trxOneMinFirstOpeningPrice).subtract(new BigDecimal(trxOneMinSecOpeningPrice))).toString();
         trxtenMinDiffOpeningPrice    = (new BigDecimal(trxOneMinFirstOpeningPrice).subtract(new BigDecimal(trxOneMinSecOpeningPrice))).toString();
         trxThirtyMinDiffOpeningPrice = (new BigDecimal(trxOneMinFirstOpeningPrice).subtract(new BigDecimal(trxThirtyMinSecOpeningPrice))).toString();         
         trxOneHourDiffOpeningPrice   = (new BigDecimal(trxOneMinFirstOpeningPrice).subtract(new BigDecimal(trxOneHourSecOpeningPrice))).toString();         
         //금액 rate 
         trxOneMinFirstOpeningRate   = (new BigDecimal(trxOneMinDiffOpeningPrice.toString()).divide(new BigDecimal(trxOneMinFirstOpeningPrice) ,4 ,BigDecimal.ROUND_DOWN) ).multiply(new BigDecimal("100")).toString();         
         trxTenMinOpeningRate        = (new BigDecimal(trxtenMinDiffOpeningPrice.toString()).divide(new BigDecimal(trxOneMinFirstOpeningPrice) ,4 ,BigDecimal.ROUND_DOWN) ).multiply(new BigDecimal("100")).toString();
         trxThirtyMinOpeningRate     = (new BigDecimal(trxThirtyMinDiffOpeningPrice.toString()).divide(new BigDecimal(trxOneMinFirstOpeningPrice) ,4 ,BigDecimal.ROUND_DOWN) ).multiply(new BigDecimal("100")).toString();
         trxOneHourOpeningRate       = (new BigDecimal(trxOneHourDiffOpeningPrice.toString()).divide(new BigDecimal(trxOneMinFirstOpeningPrice) ,4 ,BigDecimal.ROUND_DOWN) ).multiply(new BigDecimal("100")).toString();
         
         //거래량 율
		 trxOneMinFirstOpeningVolRate = ((new BigDecimal(trxOneMinFirstOpeningVol).subtract(new BigDecimal(trxOneMinSecOpeningVol))).divide(new BigDecimal(trxOneMinFirstOpeningVol),1  ,BigDecimal.ROUND_DOWN) ).multiply(new BigDecimal("100")).toString();		 
		 trxTenMinOpeningVolRate      = ((new BigDecimal(trxOneMinFirstOpeningVol).subtract(new BigDecimal(trxTenMinOpeningVol))).divide(new BigDecimal(trxOneMinFirstOpeningVol) ,1 ,BigDecimal.ROUND_DOWN) ).multiply(new BigDecimal("100")).toString();
		 trxThirtyMinOpeningVolRate   = ((new BigDecimal(trxOneMinFirstOpeningVol).subtract(new BigDecimal(trxThirtyMinOpeningVol))).divide(new BigDecimal(trxOneMinFirstOpeningVol) ,1 ,BigDecimal.ROUND_DOWN) ).multiply(new BigDecimal("100")).toString();
		 trxOneHourOpeningVolRate     = ((new BigDecimal(trxOneMinFirstOpeningVol).subtract(new BigDecimal(trxOneHourOpeningVol))).divide(new BigDecimal(trxOneMinFirstOpeningVol) ,1 ,BigDecimal.ROUND_DOWN) ).multiply(new BigDecimal("100")).toString();

     } catch (ParseException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
     } 
//trx END------------------------------------------------------------------------------------------------------------	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<title>Insert title here</title>
</head>
<body>
	
	<table border="0">
   <tr>
      <td align="left">Name</td>
      <td align="left">Now </td>
      <td align="left">OneMinDiff  </td>
      <td align="left">TenMinDiff </td>
      <td align="left">ThirtyMinDiff </td>
      <td align="left">OneHourDiff </td>
   </tr>
   <tr>
      <td align="center"><input  type="text" name=trxName      value="<%=trxCode %>"                               size="10" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" ></td>
      <td align="center"><input  type="text" name=trxNow       value="<%=trxOneMinFirstOpeningPrice.toString() %>" size="10" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" ></td>
      <td align="center"><input  type="text" name=trxOneMin    value="<%=trxtenMinDiffOpeningPrice.toString()    +"  (" +decimalFormat.format(new BigDecimal(trxOneMinFirstOpeningRate))  +")"  +"  [" +trxOneMinFirstOpeningVolRate  +"]" %>" size="20" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" ></td>
      <td align="center"><input  type="text" name=trxTenMin    value="<%=trxtenMinDiffOpeningPrice.toString()    +"  (" +decimalFormat.format(new BigDecimal(trxTenMinOpeningRate)) +")"        +"  [" +trxTenMinOpeningVolRate       +"]" %>" size="20" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" ></td>
      <td align="center"><input  type="text" name=trxThirtyMin value="<%=trxThirtyMinDiffOpeningPrice.toString() +"  (" +decimalFormat.format(new BigDecimal(trxThirtyMinOpeningRate)) +")"     +"  [" +trxThirtyMinOpeningVolRate    +"]" %>" size="20" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" ></td>
      <td align="center"><input  type="text" name=trxOneHour   value="<%=trxOneHourDiffOpeningPrice              +"  (" +decimalFormat.format(new BigDecimal(trxOneHourOpeningRate)) +")"       +"  [" +trxOneHourOpeningVolRate      +"]" %>" size="20" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" ></td>
      <td></td>
   </tr>
   <tr>
      
      <td></td>
   </tr>
</table>

</body>
</html>