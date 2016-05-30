/*******************************************************************************
 * 加载普通笔记
 */
function getNormalNoteList() {
	// var nbul=$("#second_side_right ul");
	var ul = $("#second_side_right ul");
	var li = $("#first_side_right .checked").parent();
	var data = li.data("notebook");
	$.post(path + "/note/find.do", {
				"noteBookId" : data.cn_notebook_id
			}, function(result) {
				if (result.success) {
					ul.empty();// 先将笔记列表清空
					var list = result.data;
					$(list).each(function() {
						var li = '<li class="online"><a>'
								+ '<i class="fa fa-file-text-o" title="online" rel="tooltip-bottom">'
								+ '</i> '
								+ this.cn_note_title
								+ '<button type="button" '
								+ 'class="btn btn-default btn-xs btn_position btn_slide_down">'
								+ '<i class="fa fa-chevron-down"></i>'
								+ '</button></a><div class="note_menu" tabindex="-1">'
								+ '<dl><dt><button type="button" class="btn btn-default btn-xs btn_move" title="移动至...">'
								+ '<i class="fa fa-random"></i></button></dt><dt><button type="button"'
								+ ' class="btn btn-default btn-xs btn_share" title="分享"><i class="fa fa-sitemap">'
								+ '</i></button></dt><dt><button type="button" class="btn btn-default btn-xs btn_delete" title="删除">'
								+ '<i class="fa fa-times"></i></button></dt></dl></div></li>';
						ul.append(li);
						$("#second_side_right li:last").data("note", this);// 帮顶笔记数据
					})

				} else {
					alert(result.message);
				}
			})
	// console.log("加载普通笔记");

}

/*******************************************************************************
 * 查询普通笔记内容
 */
function getNoteDetail() {
	var li = $("#second_side_right .checked").parent();
	var note = li.data("note");// 获取被点击的笔记的数据
	var title = note.cn_note_title;
	var content = note.cn_note_body;
	$("#input_note_title").val(title);// 插入笔记标题
	if (content != null) {
		um.setContent(content);
	} else {
		um.setContent("");
	}
	um.focus();
	// console.log("查询普通笔记内容");
}

/*******************************************************************************
 * 创建普通笔记
 */
function createNormalNote() {
	var li = $("#first_side_right .checked").parent();
	var nb = li.data("notebook");
	var nb_id = nb.cn_notebook_id;// 选中笔记本id
	var title = $("#input_note").val();// 获取用户输入的笔记名称
	if (!title) {
		alert("笔记名不能为空");
		return;
	}
	$.post(path + "/note/add.do", {
				"cn_notebook_id" : nb_id,
				"noteTitle" : title
			}, function(result) {
				if (result.success) {
					var note = result.data;
					var inner = '<li class="online"><a>'
							+ '<i class="fa fa-file-text-o" title="online" rel="tooltip-bottom">'
							+ '</i> '
							+ note.cn_note_title
							+ '<button type="button" '
							+ 'class="btn btn-default btn-xs btn_position btn_slide_down">'
							+ '<i class="fa fa-chevron-down"></i>'
							+ '</button></a><div class="note_menu" tabindex="-1">'
							+ '<dl><dt><button type="button" class="btn btn-default btn-xs btn_move" title="移动至...">'
							+ '<i class="fa fa-random"></i></button></dt><dt><button type="button"'
							+ ' class="btn btn-default btn-xs btn_share" title="分享"><i class="fa fa-sitemap">'
							+ '</i></button></dt><dt><button type="button" class="btn btn-default btn-xs btn_delete" title="删除">'
							+ '<i class="fa fa-times"></i></button></dt></dl></div></li>';
					$("#second_side_right ul").append(inner);// 将笔记插入笔记列表
					$("#second_side_right li:last").data("note", note);
					$("#second_side_right li:last").trigger("click");// 默认选中刚添加的笔记
					$(".cancle").trigger("click");// 将新建笔记框关闭
				} else {
					alert(result.message);
				}
			})
	// alert("创建普通笔记");
}

/*******************************************************************************
 * 更新普通笔记
 */
function updateNormalNote() {
	// 判断用户是否选中一个笔记
	var c = $("#second_side_right .checked").parent().data("note");
	if (!c) {
		alert("请先选择一个笔记");
		return;
	}
	var title = $("#input_note_title").val();// 获取笔记标题
	var content = um.getContent();// 获取笔记编辑框内容
	var note = $("#second_side_right .checked").parent().data("note")// 获取笔记信息
	if (!title) {
		alert("笔记标题不能为空");
		return;
	}
	note.cn_note_title = title;
	note.cn_note_body = content;
	$.post(path + "/note/change.do", note, function(result) {
		if (result.success) {
			// 要将笔记列表中的笔记标题做修改
			var inner = '<li class="online"><a>'
					+ '<i class="fa fa-file-text-o" title="online" rel="tooltip-bottom">'
					+ '</i> '
					+ title
					+ '<button type="button" '
					+ 'class="btn btn-default btn-xs btn_position btn_slide_down">'
					+ '<i class="fa fa-chevron-down"></i>'
					+ '</button></a><div class="note_menu" tabindex="-1">'
					+ '<dl><dt><button type="button" class="btn btn-default btn-xs btn_move" title="移动至...">'
					+ '<i class="fa fa-random"></i></button></dt><dt><button type="button"'
					+ ' class="btn btn-default btn-xs btn_share" title="分享"><i class="fa fa-sitemap">'
					+ '</i></button></dt><dt><button type="button" class="btn btn-default btn-xs btn_delete" title="删除">'
					+ '<i class="fa fa-times"></i></button></dt></dl></div></li>';
			$("#second_side_right .checked").parent().remove();
			$("#second_side_right ul").append(inner);
			// 绑定数据
			$("#second_side_right li:last").data("note", note);
			// 刚刚修改的笔记排在最后，修改完默认点击
			$("#second_side_right li:last").trigger("click");
			// alert("保存笔记成功");
			$("footer strong").text("保存成功").parent().fadeIn(1000).fadeOut(3000);
		} else {
			alert(result.message)
		}
	})
	// alert("更新普通笔记");
}

/*******************************************************************************
 * 删除普通笔记(放入回收站)
 */
function deleteNormalNote() {
	var note = $("#second_side_right .checked").parent().data("note");
	// 获取回收站按钮上的笔记本数据
	var recycle = $("#rollback_button").data("notebook");
	var nb_id = recycle.cn_notebook_id;// 获取回收站笔记本的id
	// console.log("回收站笔记本id："+nb_id);
	// console.log("普通笔记本id："+note.cn_notebook_id);
	note.cn_notebook_id = nb_id;// 将放入回收站的笔记的笔记本id改为回收站笔记本的id
	// console.log("修改后："+note.cn_notebook_id);
	$.post(path + "/note/movetorecycle.do", note, function(result) {
				if (result.success) {
					$("#second_side_right .checked").parent().remove();// 将li移除
					// 将编辑笔记本内容清空
					$("#input_note_title").val("");
					um.setContent("");
					$(".cancle").trigger("click");
				} else {
					alert(result.message);
				}
			})

	// alert("删除普通笔记");
}

/*******************************************************************************
 * 移动笔记
 */
function moveNote(note) {

	$.post(path + "/note/change.do", note, function(result) {
				if (result.success) {
					$("#second_side_right .checked").parent().remove();
					$("#four_side_right .checked").parent().remove();
					$(".cancle").trigger("click");
				} else {
					alert(result.message);
				}
			})

	// alert("移动笔记");
}

/*******************************************************************************
 * 分享笔记
 */
function createShareNote() {
	// 获取选中的笔记
	var li = $("#second_side_right .checked").parent();
	var data = li.data("note");
	$.post(path + "/note/addShare.do", data, function(result) {
				if (result.success) {
					$("footer div strong").text("分享成功").parent().fadeIn(100);
					setTimeout(function() {
								$("footer div").fadeOut(500);
							}, 1500);
				} else {
					alert(result.message)
				}
			}

	)

}

/*******************************************************************************
 * 查询回收站笔记列表
 */
function getRecycleNoteList() {
	var recycle = $("#rollback_button").data("notebook");
	var nb_id = recycle.cn_notebook_id;// 获取回收站笔记本的id
	$.post(path + "/note/recycle.do", {
				"noteBookId" : nb_id
			}, function(result) {
				if (result.success) {
					var note = result.data;
					var ul = $("#four_side_right ul");// 回收站ul
					ul.empty();
					$(note).each(function() {
						var li = '<li class="disable"><a ><i class="fa fa-file-text-o"'
								+ ' title="online" rel="tooltip-bottom">'
								+ '</i> '
								+ this.cn_note_title
								+ '<button type="button" class="btn btn-default btn-xs btn_position btn_delete">'
								+ '<i class="fa fa-times"></i></button><button type="button" '
								+ 'class="btn btn-default btn-xs btn_position_2 btn_replay">'
								+ '<i class="fa fa-reply"></i></button></a></li>'
						ul.append(li);
						$("#four_side_right li:last").data("note", this);// 绑定笔记数据
					})
				} else {
					alert(result.message);
				}
			})
	// alert("查询回收站笔记列表");
}

/*******************************************************************************
 * 查看回收站笔记内容
 */
function getRecycleNoteDetail() {
	var title = $("#noput_note_title")// 预览笔记框框
	var note = $("#four_side_right .checked").parent().data("note");// 被点中的笔记的数据
	var data = note.cn_note_title;
	var contants = note.cn_note_body;// 获取笔记内容
	// var subdata=data.substring(0);//截取内容中的一部分
	$("#contants").html(contants);
	title.html(data);// 将截取的笔记内容插入到预览框中

}
/*******************************************************************************
 * 删除回收站笔记
 */
function deleteRecycleNote() {
	var note = $("#four_side_right .checked").parent().data("note");// 获取笔记数据
	var li = $("#four_side_right .checked").parent();
	var noteID = note.cn_note_id;
	$.post(path + "/note/delete.do", {
				"noteID" : noteID
			}, function(result) {
				if (result.success) {
					li.remove();
					$(".cancle").trigger("click");
					$("#noput_note_title").val("");
				} else {
					alert(result.message);
				}
			})

	// alert("删除回收站笔记");
}

/*******************************************************************************
 * 搜索分享笔记列表(需要调用方传入当前页面值)
 */
function getShareNoteList(condition, current_page) {

	// 获取搜索关键字
	// var condition = $("#search_note").val();
	// 进行搜索
	$.post(path + "/note/search.do", {
				"condition" : condition,
				"currentPage" : current_page
			}, function(result) {
				if (result.success) {
					// 有查询数据的时候
					var list = result.data;// 获取数据
					if ($(list).length>0) {
						$(list).each(function() {
							var li = '<li class="online"><a href="#">'
									+ '<i class="fa fa-file-text-o" title="online" '
									+ 'rel="tooltip-bottom">'
									+ '</i>'
									+ this.cn_share_title
									+ '<button type="button"'
									+ ' class="btn btn-default btn-xs btn_position btn_like">'
									+ '<i class="fa fa-star-o"></i></button><div class="time"></div></a>'
							$("#sixth_side_right ul").append(li);
							// 绑定数据
							$("#sixth_side_right li:last").data("share", this);
						})
					} else {
						// 没有查询到结果
						$("footer strong").text("无数据");
						$("footer div").fadeIn(500).fadeOut(3000);
					}
				} else {
					alert(result.message);
				}
			})
	// alert("搜索分享笔记列表");
}

/*******************************************************************************
 * 查询分享笔记内容
 */
function getShareNoteDetail() {
	// alert("查询分享笔记内容");
	var data = $("#sixth_side_right .checked").parent().data("share");
	$("#noput_note_title").text(data.cn_share_title);
	if (!data.cn_share_body) {
		$("#contants").text("无内容");
	} else {
		$("#contants").html(data.cn_share_body);
	}
}

/*******************************************************************************
 * 收藏分享笔记
 */
function likeShareNote(shareId, dom) {
	//alert("收藏分享笔记");
	var note=$("#sixth_side_right .checked").parent().data("share");
	var notebook=$("#like_button").data("notebook");
	note.cn_share_id=notebook.cn_notebook_id;//将笔记所属笔记本的id改为收藏笔记本的id
	note.cn_user_id=notebook.cn_user_id;//将该笔记的用户id改过来
	$.post(
		path+"/note/saveFavority.do",
		note,
		function(result){
			if(result.success){
				$("footer strong").text("收藏成功");
				$("footer div").fadeIn(500).fadeOut(3000);
				$(".cancle").trigger("click");
			}else{
				alert(result.message);
			}
		}
	)
}

/*******************************************************************************
 * 加载收藏笔记
 */
function getLikeNoteList(likeNoteId) {
	//alert("加载收藏笔记");
	var notebook=$("#like_button").data("notebook");
	var notebookid=notebook.cn_notebook_id;
	var ul=$("#seventh_side_right ul");
	$.post(
		path+"/note/findFavority.do",
		{"noteBookId":notebookid},
		function(result){
			var b=result.data;
			ul.empty();
			if(result.success){
				var note=result.data;
				
				$(note).each(function(){
					var li='<li class="idle"><a ><i class="fa fa-file-text-o" ' +
							'title="online" rel="tooltip-bottom"></i> ' +
							''+this.cn_note_title+'<button type="button" class="btn btn-default btn-xs' +
							' btn_position btn_delete"><i class="fa fa-times"></i></button></a></li>';
					ul.append(li);
					$("#seventh_side_right li:last").data("note",this);
				})
			}else{
				alert(result.message);
			}
		}
	)
	
	
}

/*******************************************************************************
 * 查看收藏笔记内容
 */
function getLikeNoteDetail(noteId) {
	//console.log("查看收藏笔记内容");
	var note=$("#seventh_side_right .checked").parent().data("note");
	$("#noput_note_title").text(note.cn_note_title);//插入到预览笔记标题框中
	if(note.cn_note_body){
		$("#contants").html(note.cn_note_body);
	}else{
		$("#contants").text("无内容");
	}
	
}

/*******************************************************************************
 * 删除收藏笔记
 */
function deleteLikeNote(noteId, dom) {
	//alert("删除收藏笔记");
	var note=$("#seventh_side_right .checked").parent().data("note");
	var noteID=note.cn_note_id;
	$.post(
		path+"/note/delete.do",
		{"noteID":noteID},
		function(result){
			if(result.success){
				$("#seventh_side_right .checked").parent().remove();
				$("footer strong").text("删除成功");
				$("footer div").fadeIn(500).fadeOut(3000);
				$(".cancle").trigger("click");
			}else{
				alert(result.message);
			}
		}
	)
}

/*******************************************************************************
 * 加载本用户参加活动笔记列表
 */
function getNoteActivityList(noteBookId) {
	alert("加载本用户参加活动笔记列表");
}

/*******************************************************************************
 * 查询参加活动的笔记内容
 */
function getActivityNoteDetail(noteId) {
	console.log("查询参加活动的笔记内容");
}