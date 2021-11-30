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
	String uco = request.getParameter("UCo1"); //입력받아야함!
%>

<%
	if(uco != null)
		session.setAttribute("uco2", uco);
	else
		uco = (String)session.getAttribute("uco2");
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
<button onclick="location.href='main_administrator.jsp'">Back to Main Page</button >
<%//해당 학교 개설 학과 불러오기
	sql = "SELECT * FROM FACULTY WHERE FUco = '"+uco+"'";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	out.println("<h2>Open Faculty</h2>");
	out.println("<table border=\"1\">");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i = 1; i< cnt; i++)
		out.println("<th>" + rsmd.getColumnName(i)+"</th>");
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>" + rs.getString(1)+"</td>");
		out.println("<td>" + rs.getString(2)+"</td>");
		rs.getString(3);
		out.println("</tr>");
	}
	out.println("</table><br></br>");
	rsmd = null;
	rs.close();
	pstmt.close();
%>
	<form name="form1" method="post">
		<fieldset>
			<h3>Create Faculty</h3>
			<ul>
				<li><label for="FName">Faculty Name & Faculty Code: </label> 
				<input type="text" id="FName" name="FName">
				<input type="text" id="FCo" name="FCo">
				<input type="submit" value="CREATE" onclick = "javascript: form1.action='backend_createfaculty.jsp';">
				</li>
			</ul>
			<!-- Create new university with input name -->
			<h3>Delete Faculty</h3>
			<ul>
				<li><label for="DFCo">Faculty Code: </label> 
				<input type="text" id="DFCo" name="DFCo">
				<input type="submit" value="DELETE" onclick = "javascript: form1.action='backend_deletefaculty.jsp';"></li>
			</ul>
			<!-- Delete university with input code -->
		</fieldset>
	</form>


<%//해당 학교 개설 강좌 불러오기
	sql = "SELECT * FROM COURSE WHERE CUco = '"+uco+"' ORDER BY CFco, CCode";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();	
	out.println("<h2>Open Course</h2>");
	out.println("<table border=\"1\">");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i = 1; i< cnt; i++)
		out.println("<th>" + rsmd.getColumnName(i)+"</th>");
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>" + rs.getString(1)+"</td>");
		out.println("<td>" + rs.getString(2)+"</td>");
		out.println("<td>" + rs.getString(3)+"</td>");
		rs.getString(4);
		out.println("</tr>");
	}
	out.println("</table>");
	
	rs.close();
	pstmt.close();
%>

	<form name="form2" method="post">
		<fieldset>
			<h3>Create Course</h3>
			<ul>
				<li><label for="ICName">Course Name & Course Code & Faculty Code: </label> 
				<input type="text" id="ICName" name="ICName">
				<input type="text" id="ICCode" name="ICCode">
				<input type="text" id="ICFCo" name="ICFCo">
				<input type="submit" value="CREATE" onclick = "javascript: form2.action='backend_createcourse.jsp';">
				</li>
			</ul>
			<!-- Create new university with input name -->
			<h3>Delete Course</h3>
			<ul>
				<li><label for="DCFCo">Course Code & Faculty Code: </label> 
				<input type="text" id="DCCode" name="DCCode">
				<input type="text" id="DCFCo" name="DCFCo">
				<input type="submit" value="DELETE" onclick = "javascript: form2.action='backend_deletecourse.jsp';"></li>
			</ul>
			<!-- Delete university with input code -->
		</fieldset>
	</form>


</body>
</html>

