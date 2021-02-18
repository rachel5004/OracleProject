<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.util.*,com.sist.dao.*"%>
<%
	MusicDAO dao = new MusicDAO();
	ArrayList<MusicVO> list = dao.musicListData();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
	<div style="height: 30px"></div>
	<div class="container-fluid">
	<h3 class="text-center">뮤직 탑 200</h3>
		<div class="row">
			<table class="table table-boardered">
			<tr class="success">
				<th>순위</th>
				<th></th>
				<th></th>
				<th>곡명</th>
				<th>가수명</th>
				<th>앨범</th>
			</tr>
			<% 
				for(MusicVO vo:list){
					
			%>
			<tr>
				<td><%=vo.getNo() %></td>
				<td>
					<%
						String state=vo.getState();
						String str="";
						if(state.equals("상승")){
							str="▲"+vo.getIdcrement();
						}else if(state.equals("하강")){
							str="▼"+vo.getIdcrement();
						}else if(state.equals("new")){
							str="new";
						}else{
							str="-";
						}
					%>
					<%=str%>
				</td>
				<td><img src="<%=vo.getPoster()%>" width=30 height=30></td>
				<td><%=vo.getTitle() %></td>
				<td><%=vo.getSinger() %></td>
				<td><%=vo.getAlbum() %></td>
			</tr>
			<%
				}
			%>
			</table>
		</div>
	</div>
</body>
</html>