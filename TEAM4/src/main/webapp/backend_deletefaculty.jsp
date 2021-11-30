<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Modify Faculty and Course</title>

<%
	request.setCharacterEncoding("UTF-8");
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

<% //학과 삭제
	conn.setAutoCommit(false);
	
	String DFCo = request.getParameter("DFCo");
	String uco = (String)session.getAttribute("uco2");
	sql = "DELETE FROM FACULTY WHERE FCode = '"+DFCo+"' and fuco ='" +uco+"'";
	pstmt = conn.prepareStatement(sql);
	pstmt.executeQuery();
	conn.commit();
	response.sendRedirect("backend_adminSeeFacultyAndCourse.jsp");
	pstmt.close();
	
%>


</body>
</html>