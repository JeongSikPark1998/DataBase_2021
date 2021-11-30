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
	//String SId = request.getParameter("SId"); // 신청하는 본인 정보
	String SId = (String)session.getAttribute("id");
	//String Consult_Type = request.getParameter("Consult_Type");
	String Consult_Type = (String)session.getAttribute("Consult_Type");
	//String Consult_Space = request.getParameter("Consult_Space");
	String Consult_Space = (String)session.getAttribute("Consult_Space");
	//String C_Max_Reserv_Num = request.getParameter("C_Max_Reserv_Num");
	int C_Max_Reserv_Num = (int)session.getAttribute("Max");
	//String CTime = request.getParameter("CTime");
	String CTime = (String)session.getAttribute("Consult_time");
	//String CProfName = request.getParameter("CProfName");
	String CProfName = (String)session.getAttribute("CProfName");
	//String CDate = request.getParameter("CDate");
	String CDate = (String)session.getAttribute("Consult_date");
	//String CSUco = request.getParameter("CSUco");
	String CSUco = (String)session.getAttribute("uco");
    //나머지 정보들은 이전의 consultation block에서 가져오면 될 것이고
    String SFName = request.getParameter("Name");
    session.setAttribute("SFName", SFName);
    //String CNum = request.getParameter("CNum");
    String CNum = (String)session.getAttribute("CNum");
    //String CPId = request.getParameter("CPId");
    String CPId = (String)session.getAttribute("CPId");
%>

<%
   String serverIP = "localhost";
   String strSID = "orcl";
   String portNum = "1521";
   String user = "TEAM4";
   String pass = "1234";
   String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
   Connection conn = null;
   PreparedStatement pstmt,pstmt2,pstmt3;
   PreparedStatement trstmt;
   ResultSet rs;
   String sql;
   int cnt;
   ResultSetMetaData rsmd;
   Class.forName("oracle.jdbc.driver.OracleDriver");
   conn = DriverManager.getConnection(url, user, pass);
   conn.setAutoCommit(false); 
%>

</head>
<body>
<h1>sign-up consultation</h1>
<% //본인 정보
	//sql 순서가 들어가기 전에 체크를 해서 넘으면 내보내 에러랑 함께 내보내고 안 넘으면 받고,
	conn.setAutoCommit(false);
	String tr = "SELECT Cnum FROM CONSULTATION WHERE Cnum = '"+CNum+"' FOR UPDATE";
	trstmt = conn.prepareStatement(tr);
	trstmt.executeQuery();
	
	sql = "SELECT COUNT(*), C_Max_Reserv_Num FROM CONSULTATION WHERE CNum = '"+CNum+"' GROUP BY CNum, C_Max_Reserv_Num";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rsmd = rs.getMetaData();
	rs.next();
	String countMember = rs.getString(1);
	String maxCount = rs.getString(2);
	rs.close();
	pstmt.close();
	if (Integer.parseInt(countMember) > Integer.parseInt(maxCount)) {
		System.out.println("eerrrrorr");
		%><jsp:forward page="main_student.jsp"/><%
	}
%>

<%  //CONSULTATION 삽입
	//INSERT INTO CONSULTATION VALUES('FOLLOW', 'A7127', 4, '13:00 - 13:30', 'Arely', '0112', 'Jett', '2019171428', '2014135925', '2021-12-16', '11001');
	StringTokenizer st = new StringTokenizer(CDate);
	CDate = st.nextToken();
	CDate = "to_date('"+CDate+"','YYYY-MM-DD')";
	sql = "INSERT INTO CONSULTATION VALUES('"+Consult_Type
			+"', '"+Consult_Space +"', "
			+C_Max_Reserv_Num+", '"
			+CTime+"', '"+CProfName+"', '"
			+CNum+"', '"+SFName+"', '"
			+SId+"', '"+CPId+"', "
			+CDate+", '"+CSUco+"')";
	pstmt2 = conn.prepareStatement(sql);	
	pstmt2.executeQuery();
	conn.commit();
	pstmt2.close();
%>

<%
	//신청 form에서 받아올 정보들
	String grade = request.getParameter("Grade");
	int age = Integer.parseInt(request.getParameter("age"));
	double GPA = Double.parseDouble(request.getParameter("GPA"));
	String military = request.getParameter("m_served");
	String content = request.getParameter("content");
	//session에 신청 form 정보 등록
	session.setAttribute("grade", grade);
	session.setAttribute("age", age);
	session.setAttribute("GPA", GPA);
	session.setAttribute("military", military);
	session.setAttribute("content", content);
%>

<%  //CONSULT_INFO 삽입
	sql = "INSERT INTO CONSULT_INFO VALUES('"+CNum+"', '"
			+SFName+"', "+grade+", "+GPA+", "
			+age+", '"+military+"', '"+content+"', '"
			+SId+"', '"+CPId+"')";
	pstmt3 = conn.prepareStatement(sql);
	pstmt3.executeQuery();
	conn.commit(); //commit!!!
	//등록을 마치면 main_student.jsp로 이동
	//등록된 정보는 mypage의 upcoming schedule에서 확인 가능
	response.sendRedirect("main_student.jsp");
	pstmt3.close();
%>


</body>
</html>
