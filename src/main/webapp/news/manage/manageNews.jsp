<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/myTagLib" prefix="myTag"%>
<!doctype html>
<html>
 <head>
 	<meta charset="utf-8">
 	<link href="/news/css/1.css" rel="stylesheet" type="text/css">
 	<script type="text/javascript">
 	  function deleteANews(id){
		ids1=document.getElementById("ids"); 
	  	ids1.value=id;
	  	//提交
	  	document.getElementById('myform').setAttribute("target","_blank");
	  	document.getElementById('myform').action="/news/servlet/NewsServlet?type1=deleteANews";
		document.getElementById('myform').submit();
	  }
	  	
	  function editsANew(id){
		ids1=document.getElementById("ids"); 
	  	ids1.value=id;
	  	//提交
	  	document.getElementById('myform').setAttribute("target","_blank");
	  	document.getElementById('myform').action="/news/servlet/NewsServlet?type1=editANews";
		document.getElementById('myform').submit();
	  }	
	  
      function getOnePage(type){
    	  	var url1;
    	  	var page=document.getElementById("page");
    	  	var pageSize=document.getElementById("pageSize");
    	  	var totalPageCount=document.getElementById("totalPageCount");
    	  	
  			var order=document.getElementById("order");
  			var orderField=document.getElementById("orderField");
			
    	  	pageValue=parseInt(page.value);
    	  	if(type=="first")
    	  		page.value="1";
    	  	else if(type=="pre"){
    	  		pageValue-=1;
    	  		page.value=pageValue.toString();
    	  	}else if(type=="next"){
    	  		pageValue+=1;
    	  		page.value=pageValue.toString();
    	  	}else if(type=="last"){
    	  		page.value=totalPageCount.value;
    	  	}
    	  	//提交
    	  	ids1=document.getElementById("ids");
    	  	ids1.value="";
    	  	document.getElementById('myform').setAttribute("target","_self");
    	  	document.getElementById('myform').action="/news/servlet/NewsServlet?type1=manageNews";    	  	
    	  	document.getElementById('myform').submit();
      	}
	</script>  
  </head>
  
  <body>
  	<form action="/news/servlet/NewsServlet?type1=manageNews" id="myform" method="post">
  	 <table align="center"  class="tableDefault"  style="width:500px;">
	    <tr style="background-color:#FFACAC;">
	      <td>标题</td><td>作者</td><td>日期</td>
			<c:if test="${sessionScope.user.type =='manager'}">
				 <td>删除</td>  
			</c:if>	      
			<c:if test="${sessionScope.user.type =='newsAuthor'}">
				 <td>编辑</td>  
			</c:if>
		</tr>	    
	    <c:forEach items="${requestScope.newses}"  var="news">      
	   		<tr class="trDefault">    
		   		<td>${news.caption}</td>	
		   		<td>${news.author}</td>     
		   		<td><myTag:LocalDateTimeTag dateTime="${news.newsTime}" type="YMD-short"/></td>
		   		<c:if test="${sessionScope.user.type =='manager'}">
		   			<td><a href="javascript:void(0);" onclick="deleteANews(${news.newsId});">删除</a></td>
		   		</c:if>	 
		   		<c:if test="${sessionScope.user.type =='newsAuthor'}">
		   			<td><a href="javascript:void(0);" onclick="editsANew(${news.newsId});">编辑</a></td>
		   		</c:if>	
		   	</tr>
		</c:forEach> 	    
	</table>
	 <table align="center" class="tableDefault" >     
	   	<tr>			
			<c:if test="${requestScope.pageInformation.page > 1}">
				<td><a href="javascript:void(0);" onclick="getOnePage('first');">首页</a></td>  
			</c:if>
			
			<c:if test="${requestScope.pageInformation.page > 1}">
				<td><a href="javascript:void(0);" onclick="getOnePage('pre');">上一页</a></td>  
			</c:if>			 
			
			<c:if test="${requestScope.pageInformation.page < requestScope.pageInformation.totalPageCount}">
				<td><a href="javascript:void(0);" onclick="getOnePage('next');">下一页</a></td>
			</c:if>	  			
			<c:if test="${requestScope.pageInformation.page < requestScope.pageInformation.totalPageCount}">
				<td><a href="javascript:void(0);" onclick="getOnePage('last');">尾页</a></td>
			</c:if>	
			<td>共${requestScope.pageInformation.totalPageCount}页</td>   		
		</tr>    
	 </table>
	 	<input type="hidden" name="page" id="page" value="${requestScope.pageInformation.page}">
		<input type="hidden" name="pageSize" id="pageSize" value="${requestScope.pageInformation.pageSize}">
	 	<input type="hidden" name="totalPageCount" id="totalPageCount" value="${requestScope.pageInformation.totalPageCount}">
		<input type="hidden" name="allRecordCount" id="allRecordCount" value="${requestScope.pageInformation.allRecordCount}">
	 	<input type="hidden" name="orderField" id="orderField" value="${requestScope.pageInformation.orderField}">
		<input type="hidden" name="order" id="order" value="${requestScope.pageInformation.order}">
	 	<input type="hidden" name="ids" id="ids" value="${requestScope.pageInformation.ids}">
		<input type="hidden" name="searchSql" id="searchSql" value="${requestScope.pageInformation.searchSql}">
	 	<input type="hidden" name="result" id="result" value="${requestScope.pageInformation.result}">
  </form>
  </body>
</html>
