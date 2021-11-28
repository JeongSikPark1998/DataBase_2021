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
	String UName = request.getParameter("UName");
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

<%
	sql = "INSERT INTO UNIVERSITY VALUES('" + UName + "', "
			+ "(SELECT MAX(UCode) + 1 FROM UNIVERSITY))";
			
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	//있는 대학교를 넣었을 경우의 예외 처리 안됨.
	response.sendRedirect("main_administrator.jsp");
	//팝업 창 안 띄우고 바로 돌아가버림.
	rs.close();
	pstmt.close();
%>


</body>
</html>