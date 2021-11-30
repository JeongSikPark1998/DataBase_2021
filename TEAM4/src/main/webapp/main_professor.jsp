<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Main page</title>

<%
	request.setCharacterEncoding("UTF-8");
	String puco = (String)session.getAttribute("uco");
	String pid = (String)session.getAttribute("id");
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
	PreparedStatement pstmt2;
	PreparedStatement pstmt3;
	ResultSet rs;
	ResultSet rs2;
	ResultSet rs3;
	String sql;
	int cnt;
	ResultSetMetaData rsmd;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
%>

</head>
<button onclick="location.href='login.jsp'">Back to Login Page</button >
<body>
<header id="header">
		<h1>CONSULTATION</h1>
		<nav>
		<ul>
			<li><a href="mypage_professor.jsp">MY PAGE</a></li>
		</ul>
		</nav>
</header>

<form name="form1" method="post">
		<fieldset>
			<h3>Create consult</h3>
			<ul>
				<li><label for="FName">Consult_Type&emsp;&emsp;&emsp;Consult_Space&emsp;&emsp;&emsp;Max_reserv_num&emsp;&emsp;CTime(HH:MM - HH:MM)&emsp;CDate(YYYY-MM-DD)</label> 
				<br></br>
				<input type="text" id="Consult_Type" name="Consult_Type">
				<input type="text" id="Consult_Space" name="Consult_Space">
				<input type="text" id="C_Max_Reserv_Num" name="C_Max_Reserv_Num">
				<input type="text" id="CTime" name="CTime">
				<input type="text" id="CDate" name="CDate">
				<input type="submit" value="CREATE" onclick = "javascript: form1.action='backend_makeNewConsultation.jsp';">
				</li>
			</ul>
			<!-- Create new university with input name -->
			<h3>Delete Consult</h3>
			<ul>
				<li><label for="CNum">Select CNum to Delete: </label> 
				<select id="CNum" name="CNum" size="1">
					<%
						sql = "SELECT DISTINCT CNum FROM CONSULTATION WHERE CSUco = '"+puco+"' and CPId = '" +pid+ "' ORDER BY Cnum";
						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while(rs.next()){
							out.println("<option value= '" + rs.getString(1) + "'>" + rs.getString(1) + "</option>");
						}
					%>					
				</select>
				
				<input type="submit" value="DELETE" onclick = "javascript: form1.action='backend_professorConsultDone.jsp';"></li>
			</ul>
			<!-- Delete university with input code -->
		</fieldset>
	</form>

<%
	sql = "SELECT * FROM CONSULTATION WHERE CSUco = '"+puco+"' and CPId = '" +pid+ "' and CSId = '0000000000' ORDER BY Cnum";
	String sql2 = "SELECT COUNT(*) - 1 FROM CONSULTATION WHERE CSUco = '"+puco+"' and CPId = '" +pid+ "' GROUP BY Cnum";
	
	pstmt = conn.prepareStatement(sql);
	pstmt2 = conn.prepareStatement(sql2);
	
	rs = pstmt.executeQuery();
	rs2 = pstmt2.executeQuery();
	
	out.println("<h3>Scheduled Consultation</h3>");
	
	String pname = "";
	while(rs.next() && rs2.next()){
		out.println("<table border=\"1\">");
		out.println("<th>CNum</th>");
		out.println("<th>Consult_Type</th>");
		out.println("<th>Consult_Space</th>");
		out.println("<th>Consult_Date</th>");
		out.println("<th>Consult_Time</th>");
		out.println("<th>Reserv_Number</th>");
		pname = (String)rs.getString(9);
		out.println("<tr>");
		out.println("<td>" + rs.getString(6)+"</td>");
		out.println("<td>" + rs.getString(1)+"</td>");
		int max_r = rs.getInt(3);
		out.println("<td>" + rs.getString(2)+"</td>");
		String date = rs.getString(10);
		date = date.substring(0,10);
		out.println("<td>" + date+"</td>");
		out.println("<td>" + rs.getString(4)+"</td>");
		out.println("<td>" + rs2.getInt(1) + " / " + max_r +"</td>");
		out.println("</tr>");
		if(rs2.getInt(1) == 0) {
			out.println("</table><br></br>");
			continue;
		}
		else{
			out.println("<th>SName</th>");
			out.println("<th>School_Year</th>");
			out.println("<th>GPA</th>");
			out.println("<th>AGE</th>");
			out.println("<th>Military_served</th>");
			out.println("<th>Consult_content</th>");
			String sql3 ="SELECT * FROM CONSULT_INFO WHERE CICode = '" + rs.getString(6) +"'";
			pstmt3 = conn.prepareStatement(sql3);
			rs3 = pstmt3.executeQuery();
			while(rs3.next()){
				out.println("<tr><td>" + rs3.getString(2)+"</td>");
				out.println("<td>" + rs3.getString(3)+"</td>");
				out.println("<td>" + rs3.getString(4)+"</td>");
				out.println("<td>" + rs3.getString(5)+"</td>");
				out.println("<td>" + rs3.getString(6)+"</td>");
				out.println("<td>" + rs3.getString(7)+"</td></tr>");
			}
			rs3.close();
			pstmt3.close();
		}
		out.println("</table><br></br>");
	}
	session.setAttribute("pname", pname);
	rsmd = null;
	rs.close();
	rs2.close();
	pstmt.close();
	pstmt2.close();
%>

</body>
</html>

