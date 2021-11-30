<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!--  import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Team4: Administrator</title>
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
	ResultSet rs;
	String sql;
	int cnt;
	ResultSetMetaData rsmd;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
%>
</head>
<body>
<button onclick="location.href='login.jsp'">Back to Login Page</button >
	<header id="header">
		<h1>Admin</h1>
	</header>
<%//�대�� ��援� 媛��� ��怨� 遺��ъ�ㅺ린
	sql = "SELECT * FROM UNIVERSITY ORDER BY UCODE";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	out.println("<h2>University List</h2>");
	out.println("<table border=\"1\">");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i = 1; i<= cnt; i++)
		out.println("<th>" + rsmd.getColumnName(i)+"</th>");
	rs.next();
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>" + rs.getString(1)+"</td>");
		out.println("<td>" + rs.getString(2)+"</td>");
		out.println("</tr>");
	}
	out.println("</table><br></br>");
	rsmd = null;
	rs.close();
	pstmt.close();
%>
	
	
	<form name="form" method="post">
		<h3>Create New University</h3>
		<fieldset>
			<ul>
				<li><label for="UName">University Name: </label> 
				<input type="text" id="UName" name="UName">
				<input type="submit" value="CREATE" onclick = "javascript: form.action='backend_adminCreateUniversity.jsp';">
				</li>
			</ul>
			<!-- Create new university with input name -->
		</fieldset>
		<h3>Delete University</h3>
		<fieldset>
			<ul>
				<li><label for="UCode">University Code: </label> 
				<input type="text" id="UCode" name="UCode">
				<input type="submit" value="DELETE" onclick = "javascript: form.action='backend_adminDeleteUniversity.jsp';"></li>
			</ul>
			<!-- Delete university with input code -->
		</fieldset>
		<h3>See Faculty and Course in University</h3>
		<fieldset>
			<ul>
				<li><label for="UCode">University Code: </label> 
				<input type="text" id="UCo1" name="UCo1">
				<input type="submit" value="SUBMIT" onclick = "javascript: form.action='backend_adminSeeFacultyAndCourse.jsp';"></li>
			</ul>
			<!-- See university with input code -->
		</fieldset>
	</form>

	
</body>
</html>
