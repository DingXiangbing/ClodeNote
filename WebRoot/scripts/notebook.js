/*******************************************************************************
 * 加载普通笔记本
 */
function loadNormalNoteBook(){
	// alert("加载普通笔记本");
	$.post(path + "/notebook/findNormal.do",{}, function(result) {
		if (result.success) {
			var list = result.data;
			var ul = $("#first_side_right ul");
			$(list).each(function() {
				var li = "<li class='online'>"
						+ "<a class='unchecked'>"
						+ "<i class='fa fa-book' title='笔记本'"
						+ "rel='tooltip-bottom'></i>"
						+ this.cn_notebook_name
						+ "<button type='button'"
						+ " class='btn btn-default btn-xs btn_position btn_delete'>"
						+ "<i class='fa fa-times'>" + "</i></button>" + "</a>"
						+ "</li>";
				ul.append(li);
				//将该笔记本帮顶到页面，将来做增删改查用
				$("#first_side_right ul li:last").data("notebook",this);
			});
		} else {
			alert(result.message);
		}
	})
}
/*******************************************************************************
 * 加载特殊笔记本
 *  ，为了后续开发默认笔记本回收站，收藏夹，活动列表功能的方便
 */
function loadSpecialNoteBook() {
	 //alert("加载特殊笔记本");
	$.post(path + "/notebook/findSepical.do",{}, function(result) {
		if (result.success) {
			var list = result.data;
			$(list).each(function() {
				var noteBookType=this.cn_notebook_type_id;
				if(noteBookType==1){
					//收藏笔记本
					$("#like_button").data("notebook",this);
				}else if(noteBookType==2){
					//回收站笔记本
					$("#rollback_button").data("notebook",this);
				}else if(noteBookType==3){
					//活动分享笔记本
					$("#action_button").data("notebook",this)
				}else{
					//默认笔记本
					$("#first_side_right ul li:first").data("notebook",this);
				}
			});
		} else {
			alert(result.message);
		}
	})
}

/*******************************************************************************
 * 添加笔记本
 */
function addNoteBook() {
	//alert("添加笔记本");
	var noteBookName=$("#input_notebook").val();//获取笔记本名称
	$.post(
		path+"/notebook/add.do",
		{"noteBookName":noteBookName},
		function(result){
			if(result.success){
				var data=result.data;
				var li = "<li class='online'>"
						+ "<a class='unchecked'>"
						+ "<i class='fa fa-book' title='笔记本'"
						+ "rel='tooltip-bottom'></i>"
						+ data.cn_notebook_name
						+ "<button type='button'"
						+ " class='btn btn-default btn-xs btn_position btn_delete'>"
						+ "<i class='fa fa-times'>" + "</i></button>" + "</a>"
						+ "</li>";
					var ul = $("#first_side_right ul");
					ul.append(li);
					$("#first_side_right ul li:last").data("notebook",data);
					$(".cancle").trigger("click");//创建完后自动点击取消按钮，关闭弹出框
			}else{
				alert(result.message);
			}
		}
	)
}

/*******************************************************************************
 * 重命名笔记本
 */
function updateNoteBook() {
	//获取到新笔记本名称
	var noteBookName=$("#input_notebook_rename").val();
	var li=$("#first_side_right .checked").parent();
	//获取旧笔记本对象(通过观察页面发现被选中的笔记本样式和其他的不一样，故而通过样式找到被选中的笔记本)
	var book=$("#first_side_right .checked").parent().data("notebook");
	//如果新笔记本名字为空，或者一样，就不做修改
	if(noteBookName==""||book.cn_notebook_name==noteBookName){
		alert("请检查新名字是否为空，或与之前一样");
		return;
	}
	book.cn_notebook_name=noteBookName;
	//向服务器发请求，修改名字
	/*var param = {"cn_notebook_desc": book.cn_notebook_desc,
		"cn_notebook_id": book.cn_notebook_id,
		"cn_notebook_name": book.cn_notebook_name,
		"cn_notebook_type_id": book.cn_notebook_type_id,
		"cn_user_id": book.cn_user_id};*/
	$.post(
		path+"/notebook/rename.do",
		book,
		function (result){
			if(result.success){
				var inner='<i class="fa fa-book" title="笔记本" rel="tooltip-bottom">' +
						'</i>'+noteBookName+'<button type="button" ' +
						'class="btn btn-default btn-xs btn_position btn_delete">' +
						'<i class="fa fa-times"></i></button>';
			$("#first_side_right .checked").html(inner);
			li.data("notebook",book);
			$(".cancle").trigger("click");//创建完后自动点击取消按钮，关闭弹出框
			}else{
				alert(result.message);
			}
		}
	)
	//alert("重命名笔记本");
}
/*******************************************************************************
 * 删除笔记本,删除前要保证该笔记本下没有笔记
 */
function deleteNoteBook() {
	var note_li=$("#second_side_right li").index(0);//判断是否有li
	if(note_li==0){
		//该ul下有li说明有笔记，不能删除笔记本
		alert("请先删除该笔记本旗下笔记");
		return;
	}
	var li=$("#first_side_right .checked").parent();
	var nb=li.data("notebook");
	$.post(
		path+"/notebook/del.do",
		{"bookId":nb.cn_notebook_id},
		function (result){
			if(result.success){
				li.remove();
			}else{
				alert(result.message);
			}
		}
	)
	$(".cancle").trigger("click");//创建完后自动点击取消按钮，关闭弹出框
	//alert("删除笔记本");
}
/*******************************************************************************
 * 将笔记本列表放置到select组件中
 */
function setNoteBookToSelect(id) {
	//console.log("将笔记本列表放置到select组件中");
	var li=$("#first_side_right li");
	var select=$(id);
	li.each(function(){
		var option=$(this).data("notebook").cn_notebook_name;
		select.append("<option>"+option+"</option>");
		//将每个笔记本的id绑定到option组件上
		//$("#moveSelect option:last").data("notebook",$(this).data("notebook").cn_notebook_id);
		$(id).children().last().data("notebook",$(this).data("notebook").cn_notebook_id);
	});
}

