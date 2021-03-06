<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

<%--	分页查询插件    --%>
<link href="jquery/bs_pagination-master/css/jquery.bs_pagination.min.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="jquery/bs_pagination-master/localization/en.js"></script>

<script type="text/javascript">

	$(function(){
	//	入口函数
	// 添加分页查询函数
		queryClueByConditionForPage(1,5);
		//	创建按钮添加单击事件
		$("#createClue").click(function () {

			// 清空表单
			$("#createClueFrom").get(0).reset();
			//   弹出模态窗口
			$("#createClueModal").modal("show");
		});


	//	给保存按钮添加单机事件
		$("#saveClue").click(function () {
			// alert("进入了单击函数");
			// 收集参数
			$.trim($("#create-address").val());
			var owner = $("#create-clueOwner").val(); // 所有者
			var company = $.trim($("#create-company").val()); // 公司
			var appellation = $("#create-appellation").val(); // 称呼
			var fullname =$.trim($("#create-surname").val());  // 全名
			var job = $.trim($("#create-job").val()); // job
			var email = $.trim($("#create-email").val()); // email
			var phone = $.trim($("#create-phone").val()); // phone
			var website = $.trim($("#create-website").val()); // website
			var mphone = $.trim($("#create-mphone").val());  // mphone
			var state = $("#create-status").val();  // state
			var source = $("#create-source").val();  // source
			var description = $.trim($("#create-describe").val());  // 线索描述
			var contactSummary = $.trim($("#create-contactSummary").val()); // 联系纪要
			var nextContactTime = $("#create-nextContactTime").val();  //下次联系时间
			var address = $.trim($("#create-address").val()); // address
			// 表单验证
			if (owner == ""){
				alert("所有者不能为空");
				return;
			}
			if (appellation == ""){
				alert("称呼不能为空");
				return;
			}
			if (state == ""){
				alert("线索状态不能为空");
				return;
			}
			if (source == ""){
				alert("线索来源不能为空");
				return;
			}
			if(company == ""){
				alert("公司不能为空")
				return;
			}
			if (fullname == ""){
				alert("姓名不能为空")
				return;
			}
			if (email != ""){
				var ints1 = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
				if (!ints1.test(email)){
					alert("email格式错误");
					return;
				}
			}
			if (phone == ""){
				/*var ints2 = /^0\d{2,3}-?\d{7,8}$/;
				if (!ints2.test(phone)){
					alert("座机格式错误");
					return;
				}*/
				alert("座机不能为空")
			}
			/*网站格式检验
			if (website != ""){
				var ints3 = /[a-zA-z]+://[^\s]*!/;
				if (!ints3.test(website)){
					alert("公司网站格式错误");
					return;
				}
			}*/
			if (mphone != ""){
				var ints4 = /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
				if (!ints4.test(mphone)){
					alert("电话号码格式错误");
					return;
				}
			}
			if(description == ""){
				alert("线索描述不能为空")
				return;
			}
			if (address == ""){
				alert("详细地址不能为空")
				return;
			}

			// 发送请求
			$.ajax({
				url : 'workbench/clue/saveCreateClue.do',
				data : {
					owner : owner,
					company : company,
					appellation : appellation,
					fullname : fullname,
					job : job,
					email : email,
					phone : phone,
					website : website,
					mphone : mphone,
					state : state,
					source : source,
					description : description,
					contactSummary : contactSummary,
					nextContactTime : nextContactTime,
					address : address
				},
				type : 'post',
				dataType : 'json',
				success : function (data) {
					if(data.code == "1"){
						// 保存成功，关闭模态窗口
						$("#createClueModal").modal("hide");
						queryClueByConditionForPage(1,$("#demo_pag1").bs_pagination('getOption','rowsPerPage'));
						//	刷新页面

					}else {
						alert(data.message);
						//	模态窗口不关闭
						$("#createClueModal").modal("show");
					}
				}
			});

		});

		//给查询按钮添加单机事件
		$("#select_submit").click(function () {
			//	查询符合条件的条件的记录总条数
			queryClueByConditionForPage(1,$("#demo_pag1").bs_pagination('getOption','rowsPerPage'));//rowsPerPage
		});

		//	调用工具函数
		$(".myDate").datetimepicker({
			language : 'zh-CN',   //选择的语言
			format : 'yyyy-mm-dd',  // 日期的格式
			minView : 'month',  // 精确选择到哪一位
			initialDate : new Date(),  // 默认选择的日期
			autoclose : true, // 选完了之后自动关闭
			todayBtn : true,  // 存在今天选项
			clearBtn : true  // 存在清空选项
		});
		//  给全选按钮添加单击事件
		$("#cheAll").click(function () {
			$("#tB input[type='checkbox']").prop("checked",this.checked);
		});

		//给变化的元素添加事件，因为这个列表是Ajax 返回过来的所以是变化的
		$("#tB").on("click","input[type='checkbox']",function () {
			if($("#tB input[type='checkbox']").size() == $("#tB input[type='checkbox']:checked").size()){
				$("#cheAll").prop("checked",true);
			}else {
				$("#cheAll").prop("checked",false);
			}
		});

		// 给删除按钮添加单击事件
		$("#deleteClueByIds").click(function () {
			var checkedIds = $("#tB input[type='checkbox']:checked");
			if (checkedIds.size() == 0 ){
				alert("还未选择市场活动");
				return;
			}
			if (window.confirm("确定要删除吗？")) {
				var id = "";
				$.each(checkedIds,function () {
					id += "id=" + this.value +"&";
				});
				// 去掉最后一个&
				id = id.substring(0,id.length-1);
				//	发送请求
				$.ajax({
					url : 'workbench/clue/deleteClueByIds.do',
					data : id,
					type : 'post',
					dataType : 'json',
					success : function (data){
						if (data.code == "1"){
							alert(data.message)
							queryClueByConditionForPage(1,$("#demo_pag1").bs_pagination('getOption','rowsPerPage'));
						}else {
							alert(data.message);
						}
					}
				});
			}
		});

		// 给修改按钮添加单击事件
		$("#editClue").click(function () {
		//	收集参数
			//	收集参数
			var checkedIds = $("#tB input[type='checkbox']:checked");
			if(checkedIds.size() == 0){
				alert("还未选择");
				return;
			}
			if (checkedIds.size() > 1){
				alert("不能同时选中多个");
				return;
			}
			// 收集id
			var id = checkedIds[0].value;

			//	发送请求
			$.ajax({
				url : 'workbench/clue/queryClueById.do',
				data : {
					id : id
				},
				type : 'post',
				dataType : 'json',
				success : function (data) {

					// 把信息添加到模态窗口上

					$("#edit-id").val(data.id);

					$("#edit-clueOwner").val(data.owner);

					$("#edit-company").val(data.company);

					$("#edit-call").val(data.appellation);

					$("#edit-surname").val(data.fullname);

					$("#edit-job").val(data.job);

					$("#edit-email").val(data.email);

					$("#edit-phone").val(data.phone);

					$("#edit-website").val(data.website);

					$("#edit-mphone").val(data.mphone);

					$("#edit-status").val(data.state);

					$("#edit-source").val(data.source);

					$("#edit-describe").val(data.description);

					$("#edit-contactSummary").val(data.contactSummary);

					$("#edit-nextContactTime").val(data.nextContactTime);

					$("#edit-address").val(data.address);
					//	弹出模态窗口
					$("#editClueModal").modal("show");
				}
			});
		});

		$("#edit-submit").click(function () {
			// 收集参数
			var id = $("#edit-id").val();

			var owner = $("#edit-clueOwner").val();

			var company = $("#edit-company").val();
 
			var appellation = $("#edit-call").val();

			var fullname = $("#edit-surname").val();

			var job = $("#edit-job").val();

			var email = $("#edit-email").val();

			var phone = $("#edit-phone").val();

			var website = $("#edit-website").val();

			var mphone = $("#edit-mphone").val();
 
			var state = $("#edit-status").val();

			var source = $("#edit-source").val();

			var description = $("#edit-describe").val();

			var contactSummary = $("#edit-contactSummary").val();

			var nextContactTime= $("#edit-nextContactTime").val();

			var address = $("#edit-address").val();

			// 表单验证
			if (owner == ""){
				alert("所有者不能为空");
				return;
			}
			if (appellation == ""){
				alert("称呼不能为空");
				return;
			}
			if (state == ""){
				alert("线索状态不能为空");
				return;
			}
			if (source == ""){
				alert("线索来源不能为空");
				return;
			}
			if(company == ""){
				alert("公司不能为空")
				return;
			}
			if (fullname == ""){
				alert("姓名不能为空")
				return;
			}
			if (email != ""){
				var ints1 = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
				if (!ints1.test(email)){
					alert("email格式错误");
					return;
				}
			}
			if (phone == ""){
				alert("座机不能为空")
			}
			if (mphone != ""){
				var ints4 = /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
				if (!ints4.test(mphone)){
					alert("电话号码格式错误");
					return;
				}
			}
			if(description == ""){
				alert("线索描述不能为空")
				return;
			}
			if (address == ""){
				alert("详细地址不能为空")
				return;
			}

			//	发送异步请求
			$.ajax({
				url : 'workbench/clue/saveEditClueById.do',
				data : {
					id : id,
					owner : owner,
					company : company,
					appellation : appellation,
					fullname : fullname,
					job : job,
					email : email,
					phone : phone,
					website : website,
					mphone : mphone,
					state : state,
					source : source,
					description : description,
					contactSummary : contactSummary,
					nextContactTime : nextContactTime,
					address : address
				},
				type : 'post',
				dataType : 'json',
				success : function (data) {
					if(data.code == "1"){
						// 保存成功，关闭模态窗口
						$("#editClueModal").modal("hide");
						queryClueByConditionForPage($("#demo_pag1").bs_pagination('getOption','currentPage'),$("#demo_pag1").bs_pagination('getOption','rowsPerPage'));
						return;
						//	刷新页面

					}else {
						alert(data.message);
						//	模态窗口不关闭
						$("#editClueModal").modal("show");
					}
				}
			});
			
		});


	});


	// 分页查询函数
	function queryClueByConditionForPage(pageNo,pageSize) {
		// alert("函数执行了");
		//	收集参数
		var owner = $("#select_owner").val(); // 所有者
		var company = $.trim($("#select_company").val()); // 公司
		var fullname =$.trim($("#select_fullname").val());  // 全名

		var phone = $.trim($("#select_phone").val()); // phone

		var mphone = $.trim($("#select_mphone").val());  // mphone
		var state = $("#select_state").val();  // state
		var source = $("#select_source").val();  // source

		// var  = 1;
		// var  = 10;
		$.ajax({
			url : "workbench/clue/queryClueConditionForPage.do",
			data : {
				pageNo: pageNo,
				pageSize: pageSize,
				owner :owner,
				company:company,
				fullname:fullname,
				phone :phone,
				mphone :mphone,
				state :state,
				source :source
			},
			type: 'post',
			dataType: 'json',
			success:function (data){
				// 将查询出来的记录的总条数显示到页面上
				//$("#totalRows").text(data.totalRows)
				//	遍历list
				var htmlStr = "";
				$.each(data.clueList,function (index, obj) {
						htmlStr += "<tr class=\"active\">";
						htmlStr += "<td><input type=\"checkbox\" value='"+obj.id+"'/></td>";
						htmlStr += "<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='workbench/clue/detailClue.do?id="+obj.id+"';\">"+obj.fullname+obj.appellation+"</a></td>";
						htmlStr += "<td>"+obj.company+"</td>";
						htmlStr += "<td>"+obj.phone+"</td>";
						htmlStr += "<td>"+obj.mphone+"</td>";
						htmlStr += "<td>"+obj.source+"</td>";
						htmlStr += "<td>"+obj.owner+"</td>";
						htmlStr += "<td>"+obj.state+"</td>";
						htmlStr += "</tr>";
				})
				$("#tB").html(htmlStr);

				// 调用工具函数
				$("#tB").prop("checked",false);
				var totalPages = 1;
				if(data.totalRows%pageSize == 0){
					totalPages = data.totalRows/pageSize;
				}else {
					totalPages = parseInt(data.totalRows/pageSize)+1;
				}

				$("#demo_pag1").bs_pagination({
					currentPage:pageNo, // 当前页号，相当于pageNo
					rowsPerPage:pageSize, //每页显示条数，相当于
					totalRows:data.totalRows,  // 最大条数
					totalPages:totalPages,  // 总页数

					visiblePageLinks: 5, // 最多可以显示的卡片数量
					showGoToPage: true,
					showRowsPerPage: true,
					showRowsInfo: true,
					onChangePage: function (event,pageObj) {
						queryClueByConditionForPage(pageObj.currentPage,pageObj.rowsPerPage);
					}
				})
			}
		});
	}

	
</script>
</head>
<body>

	<!-- 创建线索的模态窗口 -->
	<div class="modal fade" id="createClueModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">创建线索</h4>
				</div>
				<div class="modal-body">

					<form id="createClueFrom" class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-clueOwner">
									<option></option>
									<C:forEach items="${userList}" var="user">
										<option value="${user.id}">${user.name}</option>
									</C:forEach>
								</select>
							</div>
							<label for="create-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-company">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-appellation" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-appellation">
								  <option></option>
									<C:forEach items="${appellationList}" var="appellation">
										<option value="${appellation.id}">${appellation.value}</option>
									</C:forEach>
								</select>
							</div>
							<label for="create-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-surname">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-job">
							</div>
							<label for="create-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-email">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-phone">
							</div>
							<label for="create-website" class="col-sm-2 control-label">公司网站</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-website">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-mphone">
							</div>
							<label for="create-status" class="col-sm-2 control-label">线索状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-status">
								  <option></option>
									<C:forEach items="${clueStateList}" var="clueState">
										<option value="${clueState.id}">${clueState.value}</option>
									</C:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-source" class="col-sm-2 control-label">线索来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-source">
								  <option></option>
									<C:forEach items="${sourceList}" var="source">
										<option value="${source.id}">${source.value}</option>
									</C:forEach>
								</select>
							</div>
						</div>
						

						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">线索描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-describe"></textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control myDate" id="create-nextContactTime" readonly>
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>
						
						<div style="position: relative;top: 20px;">
							<div class="form-group">
                                <label for="create-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="create-address"></textarea>
                                </div>
							</div>
						</div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveClue">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改线索的模态窗口 -->
	<div class="modal fade" id="editClueModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">修改线索</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">

						<input type="hidden" id="edit-id">
						<div class="form-group">
							<label for="edit-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-clueOwner">
									<option></option>
									<C:forEach items="${userList}" var="user">
										<option value="${user.id}">${user.name}</option>
									</C:forEach>
								</select>
							</div>
							<label for="edit-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-company" value="XXXX">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-call">
								  <option></option>
									<C:forEach items="${appellationList}" var="appellation">
										<option value="${appellation.id}">${appellation.value}</option>
									</C:forEach>
								</select>
							</div>
							<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-surname" value="XX">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-job" value="XX">
							</div>
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email" value="cpy20021234@163.com">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-phone" value="010-84846003">
							</div>
							<label for="edit-website" class="col-sm-2 control-label">公司网站</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-website" value="http://lscss.ltd">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mphone" value="12345678901">
							</div>
							<label for="edit-status" class="col-sm-2 control-label">线索状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-status">
								  <option></option>
									<C:forEach items="${clueStateList}" var="clueState">
										<option value="${clueState.id}">${clueState.value}</option>
									</C:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-source" class="col-sm-2 control-label">线索来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-source">
								  <option></option>
									<C:forEach items="${sourceList}" var="source">
										<option value="${source.id}">${source.value}</option>
									</C:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-describe">这是一条线索的描述信息</textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="edit-contactSummary">这个线索即将被转换</textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control myDate" id="edit-nextContactTime" value="2022-05-01" readonly>
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="edit-submit">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>线索列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="select_fullname">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司</div>
				      <input class="form-control" type="text" id="select_company">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司座机</div>
				      <input class="form-control" type="text" id="select_phone">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">线索来源</div>
					  <select class="form-control" id="select_source">
					  	  <option></option>
						  <C:forEach items="${sourceList}" var="source">
							  <option value="${source.id}">${source.value}</option>
						  </C:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
						<select class="form-control" id="select_owner">
							<option></option>
							<C:forEach items="${userList}" var="user">
								<option value="${user.id}">${user.name}</option>
							</C:forEach>
						</select>
				    </div>
				  </div>
				  
				  
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">手机</div>
				      <input class="form-control" type="text" id="select_mphone">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">线索状态</div>
					  <select class="form-control" id="select_state">
					  	<option></option>
						  <C:forEach items="${clueStateList}" var="clueState">
							  <option value="${clueState.id}">${clueState.value}</option>
						  </C:forEach>
					  </select>
				    </div>
				  </div>

				  <button type="button" class="btn btn-default" id="select_submit">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 40px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" data-toggle="modal" id="createClue"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" data-toggle="modal" id="editClue"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteClueByIds"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
				
			</div>
			<div style="position: relative;top: 50px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="cheAll"/></td>
							<td>名称</td>
							<td>公司</td>
							<td>公司座机</td>
							<td>手机</td>
							<td>线索来源</td>
							<td>所有者</td>
							<td>线索状态</td>
						</tr>
					</thead>
					<tbody id="tB">
						<%--<tr>
							<td><input type="checkbox" /></td>
							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">李四先生</a></td>
							<td>动力节点</td>
							<td>010-84846003</td>
							<td>12345678901</td>
							<td>广告</td>
							<td>zhangsan</td>
							<td>已联系</td>
						</tr>
                        <tr class="active">
                            <td><input type="checkbox" /></td>
                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">李四先生</a></td>
                            <td>动力节点</td>
                            <td>010-84846003</td>
                            <td>12345678901</td>
                            <td>广告</td>
                            <td>zhangsan</td>
                            <td>已联系</td>
                        </tr>--%>
					</tbody>
				</table>
				<div id="demo_pag1"></div>
			</div>

			
			<%--<div style="height: 50px; position: relative;top: 60px;">
				<div>
					<button type="button" class="btn btn-default" style="cursor: default;">共<b>50</b>条记录</button>
				</div>
				<div class="btn-group" style="position: relative;top: -34px; left: 110px;">
					<button type="button" class="btn btn-default" style="cursor: default;">显示</button>
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
							10
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li><a href="#">20</a></li>
							<li><a href="#">30</a></li>
						</ul>
					</div>
					<button type="button" class="btn btn-default" style="cursor: default;">条/页</button>
				</div>
				<div style="position: relative;top: -88px; left: 285px;">
					<nav>
						<ul class="pagination">
							<li class="disabled"><a href="#">首页</a></li>
							<li class="disabled"><a href="#">上一页</a></li>
							<li class="active"><a href="#">1</a></li>
							<li><a href="#">2</a></li>
							<li><a href="#">3</a></li>
							<li><a href="#">4</a></li>
							<li><a href="#">5</a></li>
							<li><a href="#">下一页</a></li>
							<li class="disabled"><a href="#">末页</a></li>
						</ul>
					</nav>
				</div>
			</div>--%>
		</div>
		
	</div>
</body>
</html>