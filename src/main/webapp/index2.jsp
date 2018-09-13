<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/myTagLib" prefix="myTag"%>

<!doctype html>
<html>
 <head><link href="/news/css/1.css" rel="stylesheet" type="text/css"></head>
   <body>
	<div class="news">
	   <c:forEach items="${requestScope.newsTypes}"  var="newsType" varStatus="newsTypeStatus">		
		<div class="newsleft" name="news1">
			<table class="invisibleTable"><tbody>
				<tr class="newsColumn"><td>
					<c:choose>
					    <c:when test="${newsType == 'all'}">
							最新
						</c:when>
					    <c:otherwise>
					        ${newsType}
					    </c:otherwise>
					</c:choose>
				</td><td align="right">
					<a href="/news/servlet/NewsServlet?type1=showNewsByNewsType&newsType=${newsType}&page=1&pageSize=5">更多</a>
				</td></tr>
				<c:forEach items="${requestScope.newsesList[newsTypeStatus.index]}"  var="news" varStatus="status">
					<tr><td class="mainPageUl">
							<a href="/news/servlet/NewsServlet?type1=showANews&newsId=${news.newsId}&page=1&pageSize=2"
									title="${news.caption}">
								${requestScope.newsCaptionsList[newsTypeStatus.index].get(status.index)}
							</a>
						</td>
					<td align="right" width="130">
						<myTag:LocalDateTimeTag dateTime="${news.newsTime}" type="YMD"/></td></tr>
				</c:forEach>
			</tbody></table>
		</div>
       </c:forEach>
	</div>  
	<form>
		<input type="hidden" id="newsTypeNumber" value="${requestScope.newsTypesNumber}">
	</form>	
   </body>
  	<script type="text/javascript">
 		a=document.getElementById('newsTypeNumber');
 		var newsTypeNumber=parseInt(a.value);
 		var divs=document.getElementsByName("news1");
 		for(var i=0;i<divs.length;i++){
 			if(i%2==1)
 				divs[i].setAttribute("class", "newsRight");
 		} 		
 	</script>    
   
 </html>
