<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<%
	request.setCharacterEncoding("UTF-8");
	//seeMyProfile
	String loginType  = (String)session.getAttribute("loginType");
    String id = (String)session.getAttribute("id");
    //System.out.println(id);
    //System.out.println(loginType);
%>

<%
   String serverIP = "localhost";
   String strSID = "orcl";
   String portNum = "1521";
   String user = "TEAM4";
   String pass = "1234";
   String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
   Connection conn = null;
   PreparedStatement pstmt;
   ResultSet rs;
   String sql;
   int cnt;
   ResultSetMetaData rsmd;
   Class.forName("oracle.jdbc.driver.OracleDriver");
   conn = DriverManager.getConnection(url, user, pass);
%>

</head>
<body>
<h1> My Page </h1>
<form name="form" action="pwUpdate.jsp" method="post">
<% //본인 정보
	if (loginType.equals("STUDENT")) {
		sql = "SELECT SId, SLName, SFName, SBirth, SAge, SPhone, SMail, SSex, SFco FROM STUDENT WHERE SId = '"+id+"'";
	}
	else if (loginType.equals("PROFESSOR")) {
		sql = "SELECT PId, PLName, PFName, PBirth, PAge, PPhone, PMail, PSex, PFco FROM PROFESSOR WHERE PId = '"+id+"'";
	}
	else {
		sql = "";
	}
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	
	StringTokenizer st;
	rs.next();
		String myId = rs.getString(1);
		String myLname = rs.getString(2);
		String myFname = rs.getString(3);
		String myBirth = rs.getString(4);
		st = new StringTokenizer(myBirth);
		int myAge = rs.getInt(5);
		String myPhone = rs.getString(6);
		String myMail = rs.getString(7);
		String mySex = rs.getString(8);
		String myFco = rs.getString(9);
		
		session.setAttribute("myId", myId);
		session.setAttribute("myLname", myLname);
		session.setAttribute("myFname", myFname);
		session.setAttribute("myBirth", myBirth);
		session.setAttribute("myAge", myAge);
		session.setAttribute("myPhone", myPhone);
		session.setAttribute("myMail", myMail);
		session.setAttribute("mySex", mySex);
		session.setAttribute("myFco", myFco);
	
		out.println("<h3>ID: " + myId + "</h3>");
		out.println("<h3>Name: " + myFname + " " + myLname + "</h3>");
		out.println("<h3>Birth: " + myBirth + "</h3>");
		out.println("<h3>Age: " + myAge + "</h3>");
		out.println("<h3>Phone #: " + myPhone + "</h3>");
		out.println("<h3>mail address: " + myMail + "</h3>");
		out.println("<h3>gender: " + mySex + "</h3>");
		out.println("<h3>faculty code: " + myFco + "</h3>");
	
	rs.close();
	pstmt.close();
%>
<% //지도 교수 및 지도 학생 불러오기
	if (loginType.equals("STUDENT")) {
		sql = "SELECT PId, PLName, PFName FROM PROFESSOR WHERE PId = (SELECT TPId FROM FOLLOW_STUDENT WHERE TSId = '"+id+"')";
	}
	else if (loginType.equals("PROFESSOR")) {
		sql = "SELECT SId, SLName, SFName FROM STUDENT WHERE SId IN (SELECT TSId FROM FOLLOW_STUDENT WHERE TPId = '"+id+"')";
	}
	else {
		sql = "";
	}
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	rs.next();
	
		String mysubId = rs.getString(1);
		String mysubLname = rs.getString(2);
		String mysubFname = rs.getString(3);
	
		session.setAttribute("mysubId", mysubId);
		session.setAttribute("mysubLname", mysubLname);
		session.setAttribute("mysubFname", mysubFname);
		if(loginType.equals("STUDENT")){
		out.println("<h3>academic advisor ID: " + mysubId + "</h3>");
		out.println("<h3>academic advisor Name: " + mysubFname + " " + mysubLname + "</h3>");
		}
		else if (loginType.equals("PROFESSOR")) {
			out.println("<h3>academic advisee ID: " + mysubId + "</h3>");
			out.println("<h3>academic advisee Name: " + mysubFname + " " + mysubLname + "</h3>");
		}
		
	rs.close();
	pstmt.close();
%>
<div id="buttons">
			<input type="submit" value="Update Password">
</div>
</form>
</body>
</html>