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
	String CNum = request.getParameter("CNum");
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
	conn.setAutoCommit(false);
	sql = "DELETE FROM CONSULTATION "
			+ "WHERE CNum = '" + CNum + "' ";
			
	pstmt = conn.prepareStatement(sql);
	pstmt.executeQuery();
	
	conn.commit();
	%>
	   <script>
	      alert('Consultation is Done or Deleted.\nPlease press the button to go main page.');
	      document.location.href="main_professor.jsp";
	   </script>
	<%
	pstmt.close();
		
%>


</body>
</html>
