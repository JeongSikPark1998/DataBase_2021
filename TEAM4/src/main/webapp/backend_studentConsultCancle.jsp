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
	String CNum = (String)session.getAttribute("CNum21");
	String SId = (String)session.getAttribute("id");
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

<% //Consult_type에 따른 쿼리
	sql = "DELETE FROM CONSULTATION "
			+ "WHERE CNum = '" + CNum + "' and " + "CSId = '" + SId + "'";

	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	//완료 출력?
	conn.setAutoCommit(false);
	conn.commit();
	%>
	<script>
		alert('This reservation is Deleted Successfully.');
		document.location.href="main_student.jsp";
	</script>
	<%
	rs.close();
	pstmt.close();
%>
</body>
</html>