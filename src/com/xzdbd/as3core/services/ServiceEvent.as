package com.xzdbd.as3core.services
{ 
	import flash.events.Event;

	/************************************************ 
	 * 服务类自定义内部事件类.
	 * 
	 * @author xzdbd
	 * 创建于 2013-5-16,上午10:13:02.
	 * 
	 ************************************************/ 
	public class ServiceEvent extends Event
	{
		/**
		 * 远程调用结果返回事件。
		 */
		public static const RESULT:String = "result";
		
		/**
		 * 远程调用返回结果数据对象。
		 */
		public var data:Object;
		
		/**
		 * 构造函数。
		 * @param type 事件类型。
		 * @param data 事件数据对象。
		 * @param bubbles 确定 Event 对象是否参与事件流的冒泡阶段。默认值为 false。
		 * @param cancelable 确定是否可以取消 Event 对象。默认值为 false。
		 */
		public function ServiceEvent(type:String=RESULT, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		} 
	} 
} 





