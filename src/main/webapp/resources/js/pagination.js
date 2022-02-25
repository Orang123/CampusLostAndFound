(function($, win) {
	//itemscount 所有页总共的数据条目数
	$.fn.wrpage = function(itemscount,options) {
		if (options.pagesize <= 0) {
			return;
		}
		var defaults = { //defaults 使我们设置的默认参数。
			items_per_page:3,//每页显示的数据个数
			wr_current: 1,
			cb: function() {}
		};
		var options = $.extend(defaults, options); //将传入参数和默认参数合并
		//size 总页数
		var size = Math.ceil(itemscount/options.items_per_page);
		var cur = options.wr_current;
		var cb = options.cb;
		var em = $(this);//this在JAVA里的意思，简单的说，谁在调用它，它就代表文谁。这里是指index.html里的div id=wr-page
		em.empty();//每次加载都得清空前端的分页逻辑,避免后台用户查询那里 分页累积追加
		init(size, cur);

		function init(size, cur) {
			var _html = "";
			//头
			if (cur <= 1) {
				_html += '<span class="wrpage" style="cursor:auto;">首页</span><span class="wrpage" style="cursor:auto;">上一页</span>';
			} else {
				_html +=
					'<a href="javascript:;" class="wrpage wr_pagefirst">首页</a><a href="javascript:;" class="wrpage wr_pagepre">上一页</a>';
			}
			//中间
			if (cur < 7) {
				for (var i = 1; i <= 6; i++) {
					if (i>size) {
						break;
					}
					if (i == cur) {
						_html += '<span class="curwrpage wrpage wrpage_number">' + cur + '</span>';
					} else {
						_html += '<a href="javascript:;" class="wrpage wrpage_number">' + i + '</a>';
					}
				}
			} else if (cur >= 7) {

				_html += '<span class="wr_dotted">...</span>';

				if (size - cur >= 6) {
					for (var i = cur; i <= cur * 1 + 5; i++) {
						if (i == cur) {
							_html += '<span class="curwrpage wrpage wrpage_number">' + cur + '</span>';
						} else {
							_html += '<a href="javascript:;" class="wrpage wrpage_number">' + i + '</a>';
						}
					}
					_html += '<span class="wr_dotted">...</span>';
				} else {

					for (var i = size - 5; i <= size; i++) {
						if (i == cur) {
								_html += '<span class="curwrpage wrpage wrpage_number">' + cur + '</span>';
						} else {
								_html += '<a href="javascript:;" class="wrpage wrpage_number">' + i + '</a>';
						}
					}
				}
				// 					
			}
			//尾
			if (cur >= size) {
				_html +=
					'<span href="javascript:;" class="wrpage" style="cursor:auto;">下一页</span><span href="javascript:;" class="wrpage" style="cursor:auto;">尾页</span>';
			} else {
				_html +=
					'<a href="javascript:;" class="wrpage wr_pagenext">下一页</a><a href="javascript:;" class="wrpage wr_pageend">尾页</a>';
			}
			_html += '<span class="wrpage" style="cursor:auto;">总共'+itemscount+'条记录</span>';
			em.append(_html);
		}
		
		em.off("click");//事件绑定之前一定要 确保没有绑定,否则重复绑定事件会出错
		em.on("click", "a.wrpage_number", function() {
			em.empty();
			//$(this).text()表示class=wrpage_number的a标签
			init(size, $(this).text());
			cb($(this).text(),options.items_per_page);
		});
		em.on("click", "a.wr_pagefirst", function() {
			em.empty();
			init(size, 1);
			cb(1,options.items_per_page);
		});
		em.on("click", "a.wr_pageend", function() {
			em.empty();
			init(size, size);
			cb(size,options.items_per_page);
		});
		em.on("click", "a.wr_pagenext", function() {
			var cu = parseInt(em.children("span.curwrpage").text());//只有当前页才是span标签
			em.empty();
			init(size, cu + 1);
			cb(cu + 1,options.items_per_page);
		});
		em.on("click", "a.wr_pagepre", function() {
			var cu = parseInt(em.children("span.curwrpage").text());//获取当前页面页码
			em.empty();//移除id=wr-page div标签的内容
			init(size, cu - 1);//重新处理前端分页逻辑
			cb(cu - 1,options.items_per_page);//函数回调处理ajax请求后台传入页码参数
		});
		
	}
})(jQuery, window);
