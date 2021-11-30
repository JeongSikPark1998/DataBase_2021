<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Team4: Consultation</title>
<%
   request.setCharacterEncoding("UTF-8");
    String id = (String)session.getAttribute("id");
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
<button onclick="location.href='mypage_student.jsp'">Back to MyPage</button >
<h2>Upcoming Schedule</h2>
   <form name="form" action="update_consultation_student.jsp" method="post">
<% 
   //Consult_type에 따른 쿼리
   sql = "SELECT consult_type, cprofname, cdate, ctime, consult_space, c_max_reserv_num, cnum, cpid from consultation where csid = '" + id + "'";
   System.out.println(sql);
   pstmt = conn.prepareStatement(sql);
   rs = pstmt.executeQuery();
   rsmd = rs.getMetaData();
   cnt = rsmd.getColumnCount();
   
   //store data
   String[] c = new String[100];
   String[] p = new String[100];
   String[] d = new String[100];
   String[] t = new String[100];
   String[] pl = new String[100];
   int[] m = new int[100];
   String[] CNum = new String[100];
   String[] CPId = new String[100];
   int i = 0;
   
   StringTokenizer st;
   while(rs.next()){
      c[i] = rs.getString(1);
      p[i] = rs.getString(2);
      d[i] = rs.getString(3);
      st = new StringTokenizer(d[i]);
      d[i] = st.nextToken();
      t[i] = rs.getString(4);
      pl[i] = rs.getString(5);
      m[i] = rs.getInt(6);
      CNum[i] = rs.getString(7);
      CPId[i] = rs.getString(8);
      i++;
   }
   int total_cnt = i;
   
   //print
   out.println("<table border=\"1\">");
   out.println("<th>");
   out.println("<td><b>consult type</b></td>");
   out.println("<td><b>professor</b></td>");
   out.println("<td><b>date</b></td>");
   out.println("<td><b>time</b></td>");
   out.println("<td><b>place</b></td>");
   out.println("<td><b>max participant number</b></td>");
   out.println("</th>");
   
   for(i=0; i<total_cnt; i++){
      out.println("<tr>");
      out.println("<td>" + (i+1) + "</td>");
      out.println("<td>" + c[i] + "</td>");//Consult_type
      out.println("<td>" + p[i] + "</td>");//profname
      out.println("<td>" + d[i] + "</td>");//Cdate
      out.println("<td>" + t[i] + "</td>");//ctime
      out.println("<td>" + pl[i] + "</td>");//consult_space
      out.println("<td>" + m[i] + "</td>");//c_max_reserv_num
      out.println("</tr>");
   }
   out.println("</table>");
   
   //select consultation number
   out.println("<br><label for=\"select_num2\">상담 선택</label>");
   out.println("<select name = \"select_num2\" id=\"select_num2\">");
   for(i=1; i<total_cnt+1; i++){
      out.println("<option value = \"" + i +"\">"+ i +"</option>");
   }
   out.println("</select>");
      
   //button
   out.println("<div id=\"buttons\">");
   out.println("<input type=\"submit\" value=\"update consultation\"></div>");

   //session enroll
   session.setAttribute("c2", c);
   session.setAttribute("p2", p);
   session.setAttribute("d2", d);
   session.setAttribute("t2", t);
   session.setAttribute("pl2", pl);
   session.setAttribute("m2", m);
   session.setAttribute("CNum2", CNum);
   session.setAttribute("CPId2", CPId);
   
   rs.close();
   pstmt.close();
%>
   </form>
</body>
</html>