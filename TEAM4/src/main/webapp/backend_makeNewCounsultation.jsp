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
	//signUpConsultation 학생 상담 신청 - 동시성 제어
	String Consult_Type = request.getParameter("Consult_Type");
	String Consult_Space = request.getParameter("Consult_Space");
	String C_Max_Reserv_Num = request.getParameter("C_Max_Reserv_Num");
	String CTime = request.getParameter("CTime");
	String CDate = request.getParameter("CDate");
	
	String pname = (String)session.getAttribute("pname");
	String puco = (String)session.getAttribute("uco");
	String pid = (String)session.getAttribute("id");
	//cnum 자동증가
    //CProfName, PId, Uco를 제외한 나머지 정보들은 입력 받아야함.
    //위의 정보는 로그인 정보로 이전 페이지에서 불러와야함.
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

<%  //CONSULTATION 삽입
	//INSERT INTO CONSULTATION VALUES('FOLLOW', 'A7127', 4, '13:00 - 13:30', 'Arely', '0112', 'Jett', '2019171428', '2014135925', '2021-12-16', '11001');
	conn.setAutoCommit(false);
	sql = "INSERT INTO CONSULTATION VALUES('"+Consult_Type +"', '"+Consult_Space +"', "+C_Max_Reserv_Num+", '"+CTime+"', '"+pname+"', "+"(SELECT MAX(CNum) + 1 FROM CONSULTATION)"+", NULL, DEFAULT, '"+ pid +"', '"+ CDate +"', '"+ puco +"')";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	conn.commit(); //commit!!!
	response.sendRedirect("schedule_professor.jsp");
	rs.close();
	pstmt.close();
%>


</body>
</html>
