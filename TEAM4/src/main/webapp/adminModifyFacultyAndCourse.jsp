<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<%
	//삭제될 때마다 현황 다시 쿼리해서 새로운 페이지 보여줘야 할 것 같아요!
	//이번에는 불러와야할 정보가 조금 흩어져있어서 쿼리문 위에 필요한 정보 기입해둘게요! uco는 전부 필요해서 넣어둘게용
	String uco = request.getParameter("uco");
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

<% //학과 추가: 추가는 입력을 받아야합니다.
	String FName = request.getParameter("FName");
	String IFCo = request.getParameter("FCo");
	sql = "INSERT INTO FACULTY VALUES('"+FName+"','"+IFCo+"','"+uco+"')";
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();	
	rs.close();
	pstmt.close();
%>

<% //학과 삭제
	String DFCo = request.getParameter("DFCo");
	sql = "DELETE FROM FACULTY WHERE FCode = '"+DFCo+"' AND FUco ='"+uco+"'";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rs.close();
	pstmt.close();
%>

<% //코스 추가: 추가는 입력을 받아야합니다.
	String ICName = request.getParameter("ICName");
	String ICFCo = request.getParameter("ICFCo");
	String ICCode = request.getParameter("ICCode");
	sql = "INSERT INTO COURSE VALUES('"+ICName+"','"+ICCode+"','"+ICFCo+"','"+uco+"');";
			
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();	
	rs.close();
	pstmt.close();
%>

<% //코스 삭제
	String DCFCo = request.getParameter("DCFCo");
	String DCCode = request.getParameter("DCCode");
	sql = "DELETE FROM COURSE WHERE CCode = '"+DCCode+"' AND CFco = '"+DCFCo+"' AND CUco = '"+uco+"'";
			
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rs.close();
	pstmt.close();
%>


</body>
</html>