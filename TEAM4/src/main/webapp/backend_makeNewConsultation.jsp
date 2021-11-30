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
	
	String Consult_Type = request.getParameter("Consult_Type");
	String Consult_Space = request.getParameter("Consult_Space");
	String C_Max_Reserv_Num = request.getParameter("C_Max_Reserv_Num");
	String CTime = request.getParameter("CTime");
	String CDate = request.getParameter("CDate");
	
	String pname = (String)session.getAttribute("pname");
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
   ResultSet rs;
   String sql;
   int cnt;
   ResultSetMetaData rsmd;
   Class.forName("oracle.jdbc.driver.OracleDriver");
   conn = DriverManager.getConnection(url, user, pass);
%>

</head>
<body>

<%  //CONSULTATION
	//INSERT INTO CONSULTATION VALUES('FOLLOW', 'A7127', 4, '13:00 - 13:30', 'Arely', '0112', 'Jett', '2019171428', '2014135925', '2021-12-16', '11001');
	conn.setAutoCommit(false);
	sql = "INSERT INTO CONSULTATION VALUES('"+Consult_Type +"', '"+Consult_Space +"', "+C_Max_Reserv_Num+", '"+CTime+"', '"+pname+"', "+"(SELECT MAX(CNum) + 1 FROM CONSULTATION)"+", NULL, DEFAULT, '"+ pid +"', '"+ CDate +"', '"+ puco +"')";
	pstmt = conn.prepareStatement(sql);
	pstmt.executeQuery();
	conn.commit(); //commit!!!
	%>
	   <script>
	      alert('Consultation is created.\nPlease press the button to go main page.');
	      document.location.href="main_professor.jsp";
	   </script>
	<%
	pstmt.close();
%>


</body>
</html>
