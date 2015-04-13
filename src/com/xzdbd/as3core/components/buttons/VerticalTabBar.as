package com.xzdbd.as3core.components.buttons
{
	import mx.controls.TabBar;
	import mx.core.ClassFactory;
	import mx.core.mx_internal;
	
	use namespace mx_internal;
	
	/*********************************************
	 * 纵向 TabBar 实现类.
	 * 
	 * @mxml
	 * <p> 
     * 下面代码演示如何使用 <code>VerticalTabBar</code> 类： 
	 * <p>首先，引用命名空间  <b><code>xmlns:as3core="http://www.xzdbd.net/2013/flex/as3core"</code></b>，调用如下：</p>
	 * <pre>
	 * &lt;as3core:VerticalTabBar 
	 * 	<b>Properties</b>
	 * 	dataProvider="{infoStack}" 
	 * 	direction="vertical"
	 * 
	 * 	<b>Styles</b>
	 * 	fontFamily="微软雅黑"
	 * 	fontSize="12"
	 * 	verticalGap="3"
	 * 	x="100"
	 * 	y="0"
	 * 	width="25"
	 * 	chromeColor="0xFFFF00" /&gt;
	 * 
	 * 其中，该组件的 dataProvider 属性值 infoStack 为一个 ViewStack 控件，为 VerticalTabBar 提供数据源.
	 * </pre>
     * </p>
	 * 
	 * @author xzdbd
	 * 创建于 2013-6-11,下午3:35:26.
	 *********************************************/
	public class VerticalTabBar extends TabBar
	{
		/**
		 * 构造函数。
		 */
		public function VerticalTabBar()
		{
			super();
			navItemFactory = new ClassFactory(VerticalButton);
		}
	}
}



