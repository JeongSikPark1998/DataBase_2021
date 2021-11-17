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

<% //본인 정보
	if (loginType.equals("STUDENT")) {
		sql = "SELECT SId, SLName, SFName, SBirth, SAge, SPhone, SMail, SSex, SFco FROM STUDENT WHERE SId = '"+id+"'";
	}
	else if (loginType.equals("PROFESSOR")) {
		sql = "SELECT PId, PLName, PFName, PBirth, PAge, PPhone,PMail, PSex, PFco FROM PROFESSOR WHERE PId = '"+id+"'";
	}
	else {
		sql = "";
	}
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	while(rs.next()){
		out.println(rs.getString(1)); //id
		out.println(rs.getDouble(2)); //lname
		out.println(rs.getString(3)); //fname
		out.println(rs.getDouble(4)); //birth
		out.println(rs.getString(5)); //age
		out.println(rs.getDouble(6)); //phone
		out.println(rs.getString(7)); //mail
		out.println(rs.getDouble(8)); //sex
		out.println(rs.getDouble(9)); //fco
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
		out.println(rs.getString(1)); //id
		out.println(rs.getDouble(2)); //lname
		out.println(rs.getString(3)); //fname
	}
	rs.close();
	pstmt.close();
%>

</body>
</html>