<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.util.*,com.sist.dao.*"%>
<%
     try
     {
    	  request.setCharacterEncoding("EUC-KR");// �ѱ� �������� 
     }catch(Exception ex){}
     String dong=request.getParameter("dong"); 
     
     ZipcodeDAO dao=new ZipcodeDAO();
     ArrayList<ZipcodeVO> list=null;
     
     if(dong!=null)// ���� �Է��� �Ǿ������� �����ȣ �˻��� �Ѵ� 
     {
    	 list=dao.postFind(dong);
     }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
.row {
  margin: 0px auto;
  width:410px;
}
h3 {
   text-align: center;
}
</style>
<script type="text/javascript">
function ok(zip,addr)
{
	opener.frm.post1.value=zip.substring(0,3);
	opener.frm.post2.value=zip.substring(4,7);
	opener.frm.addr.value=addr;
	self.close();
}
</script>
</head>
<body>
   <div class="container">
     <h3>�����ȣ �˻�</h3>
     <div class="row">
      <form method=post action="postfind.jsp">
       <table class="table">
         <tr>
          <td>
           �Է�:<input type=text name="dong" class="input-sm">
           <input type=submit value="�˻�" class="btn btn-sm btn-danger">
          </td>
         </tr>
       </table>
      </form>
     </div>
     <div class="row">
       <%
         if(list!=null)
         {
       %>
            <table class="table">
             <tr class="danger">
               <th class="text-center">�����ȣ</th>
               <th class="text-center">�ּ�</th>
             </tr> 
            
       <%
        	 for(ZipcodeVO vo:list)
        	 {
       %>
               <tr>
                 <td class="text-center"><%=vo.getZipcode() %></td>
                 <td><a href="javascript:ok('<%=vo.getZipcode() %>','<%=vo.getAddrss() %>')"><%=vo.getAddrss() %></a></td>
               </tr>
       <%
        	 }
       %>
            </table>
       <%
         }
       %>
     </div>
   </div>
</body>
</html>









