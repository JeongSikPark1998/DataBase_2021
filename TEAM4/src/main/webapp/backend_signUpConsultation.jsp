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
	//signUpConsultation �л� ��� ��û - ���ü� ����
	String SId = (String)session.getAttribute("id");
	String Consult_Type = (String)session.getAttribute("Consult_Type");
	String Consult_Space = (String)session.getAttribute("Consult_Space");
	int C_Max_Reserv_Num = (int)session.getAttribute("Max");
	String CTime = (String)session.getAttribute("Consult_time");
	String CProfName = (String)session.getAttribute("CProfName");
	String CDate = (String)session.getAttribute("Consult_date");
	String CSUco = (String)session.getAttribute("uco");
    String SFName = request.getParameter("Name");
    session.setAttribute("SFName", SFName);
    String CNum = (String)session.getAttribute("CNum");
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
<% //���� ����
	//sql ������ ���� ���� üũ�� �ؼ� ������ ������ ������ �Բ� �������� �� ������ �ް�,
	conn.setAutoCommit(false);
	String tr = "LOCK TABLE CONSULTATION IN SHARE MODE";
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
		conn.commit();
		%>
		<script>
			alert('This reservation is full reserved.');
			document.location.href="main_student.jsp";
		</script>
		<%
		return;
	}
%>

<%  //CONSULTATION ����
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
	//��û form���� �޾ƿ� ������
	String grade = request.getParameter("Grade");
	int age = Integer.parseInt(request.getParameter("age"));
	double GPA = Double.parseDouble(request.getParameter("GPA"));
	String military = request.getParameter("m_served");
	String content = request.getParameter("content");
	//session�� ��û form ���� ���
	session.setAttribute("grade", grade);
	session.setAttribute("age", age);
	session.setAttribute("GPA", GPA);
	session.setAttribute("military", military);
	session.setAttribute("content", content);
%>

<%  //CONSULT_INFO ����
	sql = "INSERT INTO CONSULT_INFO VALUES('"+CNum+"', '"
			+SFName+"', "+grade+", "+GPA+", "
			+age+", '"+military+"', '"+content+"', '"
			+SId+"', '"+CPId+"')";
	pstmt3 = conn.prepareStatement(sql);
	pstmt3.executeQuery();
	conn.commit(); //commit!!!
	response.sendRedirect("main_student.jsp");
	pstmt3.close();
%>


</body>
</html>