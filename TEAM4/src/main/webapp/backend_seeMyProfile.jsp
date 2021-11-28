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
	String loginType = request.getParameter("loginType");
    String id = request.getParameter("id");
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
<form name="form" action="account.jsp" method="post">
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
	while(rs.next()){
		String myId = rs.getString(1);
		String myLname = rs.getString(2);
		String myFname = rs.getString(3);
		String myBirth = rs.getString(4);
		String myAge = rs.getInt(5);
		String myPhone = rs.getString(6);
		String myMail = rs.getString(7);
		String mySex = rs.getString(8);
		String myFco = rs.getString(9);
	}
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
	while(rs.next()){
		String mysubId = rs.getString(1);
		String mysubLname = rs.getString(2);
		String mysubFname = rs.getString(3);
	}
	rs.close();
	pstmt.close();
%>
</form>
</body>
</html>