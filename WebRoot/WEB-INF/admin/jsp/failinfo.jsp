<%@page import="com.vo.Employees"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../../page/page.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	Employees emp = (Employees)request.getSession().getAttribute("adminsession");
	int employeeid = emp.getInt("employeeid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
	$("#netparticipate option[value='${netparticipate}']").attr("selected", true);
	$("#netstate option[value='${netstate}']").attr("selected", true);
	$("#netlock option[value='${netlock}']").attr("selected", true);
	

</script>
</head>
<body>
	<form id="pagerForm" method="post" action="<%=adminbasePath%>/failinfo/MyQueryList/">
		<input type="hidden" name="pageNum" value="1" /> <input type="hidden"
			name="numPerPage" value="${numPerPage}" /> <input type="hidden"
			name="netstarttime" value="${netstarttime}" /> <input type="hidden"
			name="netendtime" value="${netendtime }" /> <input type="hidden"
			name="netparticipate" value="${netparticipate}" /> <input
			type="hidden" name="netstate" value="${netstate}" /> <input
			type="hidden" name="netorderid" value="${netorderid}" /> <input
			type="hidden" name="netname" value="${netname}" /> <input
			type="hidden" name="netlock" value="${netlock}" /><input
			type="hidden" name="p2_Order" value="${p2_Order}" />
	</form>

	<div class="pageHeader">
		<form rel="pagerForm" action="<%=adminbasePath%>/failinfo/MyQueryList/"
			onsubmit="return navTabSearch(this)" method="post">
			<input type="hidden" name="pageNum" value="1" /> <input
				type="hidden" name="numPerPage" value="20" />
			<div class="searchBar">
				<table class="searchContent">
					<tr>
						<td>订单编号：<input type="text" name="netorderid"
							value="${netorderid}"></td>
						<td>用户id：<input type="text" name="netname" value="${netname }"></td>
						<td>日期：
						
							<input type="text"  name="netstarttime" value="${netstarttime }" class="date netstarttime" dateFmt="yyyy-MM-dd" /> --
							<input type="text" name="netendtime" value="${netendtime }" class="date netendtime" dateFmt="yyyy-MM-dd" />
						
						</td>
						<td><select class="combox" name="netparticipate"
							id="netparticipate" style="width: 200px">
								<option value="0">支付方式</option>
								<c:forEach items="${partici}" varStatus="l" var="par">
									<option value="${par.codeid}">
										<c:out value="${par.payable}"></c:out>
									</option>
								</c:forEach>
						</select></td>
						<td><select class="combox" name="netstate" id="netstate"
							style="width: 100px">
								<option value="0">订单状态</option>
								<option value="1">成功</option>
								<option value="2">处理中</option>
								<option value="3">失败</option>
								<option value="4">失效</option>
						</select></td>
					</tr>
					<tr>
						<td>商户订单：<input type="text" name="p2_Order" value="${p2_Order}" /></td>
						<td>&nbsp;</td>
						<td>
							<div>
								<input type="button" name="today" value=" 今天 " onClick="MyDate(1,this);">
								<input type="button" name="yesteday" value=" 昨天 " onClick="MyDate(2,this);">
								<input type="button" name="week" value=" 本周 " onClick="MyDate(4,this);">
							</div>
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div class="subBar">
					<ul>
						<li><div class="buttonActive">
								<div class="buttonContent">
									<button type="submit">检索</button>
								</div>
							</div></li>
					</ul>
				</div>
			</div>
		</form>
	</div>
	<div class="pageContent">
		<div class="panelBar">
			
			<ul class="toolBar">
			
				 <li><a title="确实要对这些记录进行通知吗?" target="selectedTodo"
					rel="netlist" href="<%=adminbasePath%>/failinfo/doretunet"
					class="delete"><span>批量通知</span></a>
				</li>				
					
				<%-- <li class="line">line</li>				
				<li><a title="确实要对此记录进行扣单吗?" target="ajaxTodo"
					href="<%=adminbasePath%>/net/netDeduction?netorderid={orderid}"
					class="delete"><span>扣单</span></a></li> --%>
				<!-- <li class="line">line</li>
				<li><a class="edit" href="demo_page4.html?uid={orderid}"
					target="navTab"><span>修改</span></a></li>
				<li class="line">line</li>
				<li><a class="icon" href="demo_page4.html?uid={orderid}"
					target="navTab"><span>查看</span></a></li>
				<li class="line">line</li> -->
			</ul>
			
			<h1 align="center" style="color: red;">订单总数：${totalCount}条&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				交易金额：${netstatis.p3_Amt }（元）&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 实际金额：${netstatis.amount }（元）
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;收益金额：${netstatis.deducted }（元）</h1>
		</div>
		<table class="table" width="1200" layoutH="138">
			<thead>
				<tr>
					<th><input type="checkbox" group="netlist"
						 value="${order.orderid }" class="checkboxCtrl"></th>
					<th>订单编号</th>
					<th>用户</th>
					<th>商户订单编号</th>
					<th>支付金额</th>
					<th>实际金额</th>
					<th>交易方式</th>
					<th>ip</th>
					<th>支付结果</th>
					<th>是否反馈</th>				
					<th>创建时间</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${orderlist}" var="order">
					<tr target="orderid" rel="${order.orderid }">
						<td><input name="netlist" value="${order.orderid }"
							type="checkbox"></td>
						<td><c:out value="${order.orderid}"></c:out></td>
						<td><c:out value="${order.p1_MerId}"></c:out></td>
						<td><c:out value="${order.p2_Order}"></c:out></td>
						<td><c:out value="${order.p3_Amt}"></c:out></td>
						<td><c:out value="${order.amount}"></c:out></td>
						<td><c:out value="${order.pd_FrpId}"></c:out></td>
						<td><c:out value="${order.ip}"></c:out></td>
						<td><c:choose>
								<c:when test="${order.r1_Code==1}">
								成功
							</c:when>
								<c:when test="${order.r1_Code==2}">
								处理中
							</c:when>
								<c:when test="${order.r1_Code==3}">
								失败
							</c:when>
								<c:when test="${order.r1_Code==4}">
								失效
							</c:when>
							</c:choose></td>
						<td><c:choose>
								<c:when test="${order.success==1}">是</c:when>
								<c:when test="${order.success==2}">否</c:when>
							</c:choose></td>					
						<td><c:out value="${order.CreateTime}"></c:out></td>					
					</tr>
				</c:forEach>
				<tr><td colspan="11">&nbsp;</td></tr>
				<tr>
					<td colspan="11">
						<div class="panelBar">
			<div class="pages">
				<span>显示</span> <select class="combox" name="numPerPage"
					onchange="navTabPageBreak({numPerPage:this.value})">
					<option value="20">20</option>
					<option value="50">50</option>
					<option value="100">100</option>
					<option value="200">200</option>
				</select> <span>条，共${totalCount}条</span>
			</div>

			<div class="pagination" targetType="navTab"
				totalCount="${totalCount}" numPerPage="${numPerPage}"
				currentPage="${pageNum}"></div>
		</div>
					</td>
				</tr>
			</tbody>
		</table>
		
	</div>
</body>
</html>