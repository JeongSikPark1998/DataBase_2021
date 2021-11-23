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
	String SId = request.getParameter("SId"); // 신청하는 본인 정보
	String Consult_Type = request.getParameter("Consult_Type");
	String Consult_Space = request.getParameter("Consult_Space");
	String C_Max_Reserv_Num = request.getParameter("C_Max_Reserv_Num");
	String CTime = request.getParameter("CTime");
	String CProfName = request.getParameter("CProfName");
	String CNum = request.getParameter("CNum");
	String CStuName = request.getParameter("CStuName");
	String CPId = request.getParameter("CPId");
	String CDate = request.getParameter("CDate");
	String CSUco = request.getParameter("CSUco");
    //나머지 정보들은 이전의 consultation block에서 가져오면 될 것이고
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

<% //본인 정보
	//sql 순서가 들어가기 전에 체크를 해서 넘으면 내보내 에러랑 함께 내보내고 안 넘으면 받고,
	sql = "SELECT COUNT(*), C_Max_Reserv_Num FROM CONSULTATION WHERE CNum = '"+CNum+"' GROUP BY CNum, C_Max_Reserv_Num";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	String countMember = rs.getString(1);
	int maxCount = rs.getInt(2);
	if (Integer.parseInt(countMember) > maxCount) {
		//신청 불가!! 알림 띄우면서 alert() 보내면서, 페이지 안 보이게 하거나, 이전 페이지로 강제로 보내면 될 듯요!
	}
	rs.close();
	pstmt.close();
%>

<%
	//신청 form에서 받아올 정보들
	String SFName = "",grade= "";
	int age = 0;
	double GPA = 0;
	String military="",content="";
%>

<%  //CONSULTATION 삽입
	//INSERT INTO CONSULTATION VALUES('FOLLOW', 'A7127', 4, '13:00 - 13:30', 'Arely', '0112', 'Jett', '2019171428', '2014135925', '2021-12-16', '11001');
	sql = "INSERT INTO CONSULTATION VALUES('"+Consult_Type +"', '"+Consult_Space +"', "+C_Max_Reserv_Num+", '"+CTime+"', '"+CProfName+"', '"+CNum+"', '"+SFName+"', '"+SId+"', '"+CPId+"', '"+CDate+"', '"+CSUco+"')";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	conn.commit(); //commit!!!
	rs.close();
	pstmt.close();
%>

<%  //CONSULT_INFO 삽입
	sql = "INSERT INTO CONSULT_INFO VALUES('"+CNum+"', '"+SFName+"', "+grade+", "+GPA+", "+age+", "+military+", '"+content+"', '"+SId+"', '"+CPId+"')";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	conn.commit(); //commit!!!
	rs.close();
	pstmt.close();
%>


</body>
</html>