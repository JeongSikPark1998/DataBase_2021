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
	String UCode = request.getParameter("UCode");
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
   String sql;
   int cnt;
   ResultSetMetaData rsmd;
   Class.forName("oracle.jdbc.driver.OracleDriver");
   conn = DriverManager.getConnection(url, user, pass);
   
%>

</head>
<body>

<% //Consult_type에 따른 쿼리
	sql = "DELETE FROM UNIVERSITY WHERE UCode = '" + UCode + "'";	
	pstmt = conn.prepareStatement(sql);
	pstmt.executeQuery();
	response.sendRedirect("main_administrator.jsp");
	//팝업 창 안 띄우고 바로 돌아가버림.
			
	pstmt.close();
%>


</body>
</html>