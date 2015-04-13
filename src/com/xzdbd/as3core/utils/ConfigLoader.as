package com.xzdbd.as3core.utils
{ 
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	/******************************************* 
	 * 外部配置文件(.xml)加载类.
	 * 
	 * @author xzdbd
	 * 创建于 2012-8-1,下午03:41:32.
	 * 
	 *******************************************/ 
	public class ConfigLoader 
	{ 
		/**
		 * 加载外部配置文件(.xml)中的指定节点对应数据信息。
		 * @param xmlUrl 外部文件路径（绝对路径）。
		 * @param node 指定的 XML 文件节点。
		 * @param onResult 加载成功完成时的回调函数，参数为 XMLList。
		 * @param onFault 加载失败时的回调函数。
		 */
		public static function getConfigByNode(xmlUrl:String, node:String, onResult:Function, onFault:Function=null):void
		{
			var configService:HTTPService = new HTTPService();
			configService.url = xmlUrl;
			configService.resultFormat = HTTPService.RESULT_FORMAT_E4X;
			
			configService.addEventListener(ResultEvent.RESULT, configService_resultHandler);
			configService.addEventListener(FaultEvent.FAULT, configService_faultHandler);
			configService.send();
			
			function configService_resultHandler(event:ResultEvent):void
			{
				try
				{
					var _configXML:XML = event.result as XML;
					if(node)
					{
						onResult(_configXML.child(node));
					}
					else
					{
						onResult(_configXML);
					}
				}
				catch (error:Error)
				{
					Alert.show("配置文件加载不成功！", "操作提示");
				}
			}
			
			function configService_faultHandler(event:FaultEvent):void
			{
				Alert.show("配置文件加载不成功！", "操作提示");
				if(onFault != null)
					onFault(event);
			}
		}
		
		
		/**
		 * 构造函数。
		 */
		public function ConfigLoader()
		{
		} 
	} 
} 





