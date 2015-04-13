package com.xzdbd.as3core.components.labels 
{ 
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import spark.components.Label;
	
	/*******************************************************************
	 * 用来作为短暂通知的 Label 组件，设置通知之后，通知文本在显示指定的时间间隔后消失.
	 * 
	 * <p>该类继承自 spark.components.Label.</p>
	 * 
	 * @mxml
	 * <p> 
     * 下面代码演示如何使用 <code>InfoText</code> 类： 
	 * <p>首先，引用命名空间  <b><code>xmlns:as3core="http://www.xzdbd.net/2013/flex/as3core"</code></b>，调用如下：</p>
	 * <pre>
	 * &lt;as3core:InfoText 
	 * 	<b>Properties</b>
	 * 	text="请输入关键字进行查询..."
	 * 
	 * 	<b>Styles</b>
	 * 	color="0x000000" /&gt;
	 * 
	 * 说明：该组件需要通过其属性方法 <code>setNotice(notice:String, interval:Number)</code> 设置通知文本.
	 * </pre>
     * </p>
	 * 
	 * @author xzdbd
	 * 创建于 2013-7-16,下午5:16:28.
	 * 
	 ******************************************************************/ 
	public class NoticeLabel extends Label 
	{ 
		/**
		 * 构造函数。
		 */
		public function NoticeLabel()
		{
			super();
			
			this.visible = false;
			this.includeInLayout = false;
		} 
		
		//控制通知标签显示与隐藏的计时器 id。
		private var intervalId:uint;
		
		/**
		 * 设置新的通知消息。
		 * @param notice 要显示的通知内容。
		 * @param interval 通知显示的时间，默认为 4000 毫秒。 
		 */
		public function setNotice(notice:String, interval:Number=4000):void
		{
			this.text = notice;
			this.visible = true;
			this.includeInLayout = true;
			this.intervalId = setInterval(intervalFun, interval);
			
			function intervalFun():void
			{
				this.visible = false;
				this.includeInLayout = false;
				this.text = "";
				clearInterval(intervalId);
			}
		}
		
		/**
		 * 取消通知消息显示。
		 */
		private function clearNotice():void
		{
			clearInterval(intervalId);
		}
	} 
} 






