package com.xzdbd.as3core.components.buttons 
{ 
	import flash.events.MouseEvent;
	
	import spark.components.Image;
	import spark.filters.GlowFilter;
	
	
	/*************************************************
	 * 该类实现了图片按钮化，即将图片以按钮的形式进行呈现.
	 * 
	 * <p>
	 * 调用该组件时，不需要对图片的 <code>width</code> 和 <code>height</code> 属性进行设置，组件默认使用其原始属性，
	 * 但如果可以要拉伸，则需显式设置.
	 * </p>
	 * 
	 * @mxml
	 * <p> 
     * 下面代码演示如何使用 <code>ButtonImage</code> 类： 
	 * <p>首先，引用命名空间  <b><code>xmlns:as3core="http://www.xzdbd.net/2013/flex/as3core"</code></b>，调用如下：</p>
	 * <pre>
	 * &lt;as3core:ButtonImage 
	 * 	<b>Properties</b>
	 * 	source="assets/images/close.png" 
	 * 	click="closeWindow()"
	 * 	toolTip="关闭" 
	 * 
	 * 	<b>Styles</b>
	 * 	alpha="0.4" /&gt;
	 * </pre>
     * </p>
	 * 
	 * @author xzdbd
	 * 创建于 2013-7-12,上午8:25:28.
	 * 
	 *************************************************/ 
	public class ButtonImage extends Image 
	{ 
		/**
		 * 构造函数。
		 */
		public function ButtonImage()
		{
			super();
			
			this.width = this.sourceWidth;
			this.height = this.sourceHeight;
			this.buttonMode = true;
			this.addEventListener(MouseEvent.ROLL_OVER, mouseRollOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, mouseRollOutHandler);
		} 
		
		//发光效果对象
		private var _glowFilter:GlowFilter = new GlowFilter(0x0000FF, 1.0, 4.0, 4.0, 1, 1, false);
		
		/**
		 * MouseEvent.ROLL_OVER 事件的默认处理函数。
		 */
		protected function mouseRollOverHandler(event:MouseEvent):void
		{
			this.filters = [ _glowFilter ];
		}
		
		/**
		 * MouseEvent.ROLL_OUT 事件的默认处理函数。
		 */
		protected function mouseRollOutHandler(event:MouseEvent):void
		{
			this.filters = [ ];
		}
	} 
} 






