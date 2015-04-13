package com.xzdbd.as3core.services
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.managers.CursorManager;
	import mx.rpc.AbstractOperation;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.soap.WebService;
	
	/*******************************************************************
	 * 该类实现了对远程服务器上基于 SOAP 的 Web 服务访问接口.
	 * 
	 * @example
     * 下面代码演示如何使用 <code>WebServiceHelper</code> 类： 
	 * <listing version="3.0">
	 * //执行服务方法调用（详见函数说明）
	 * WebServiceHelper.getInstance().execServiceFunc("GetDikesDistrictToJson", params, WebServiceHelper.TYPE_JSON, OnResult, OnFault);
	 * function OnResult(event:ServiceEvent):void
	 * {
	 * 	//调用成功返回执行过程
	 * }
	 * function OnFault(event:FaultEvent):void
	 * {
	 * 	//调用失败执行过程
	 * }
	 * </listing>
	 * 
	 * @author xzdbd
	 * 创建于 2013-5-16,上午10:13:02.
	 *
	 *******************************************************************/
	public class WebServiceHelper
	{
		/**
		 * XML 类型数据（返回值类型）。
		 */
		public static const TYPE_XML:String = "type_xml";
		/**
		 * JSON 类型数据（返回值类型）。
		 */
		public static const TYPE_JSON:String = "type_json";
		/**
		 * 泛型数据（返回值类型）。
		 */
		public static const TYPE_Generic:String = "type_generic";
		/**
		 * 简单类型数据（返回值类型）。
		 */
		public static const TYPE_SimpleData:String = "type_simpleData";
		/**
		 * DataTable 类型数据（返回值类型）。
		 */
		public static const TYPE_DataTable:String = "type_datatable";
		/**
		 * 数组类型数据（返回值类型）。
		 */
		public static const TYPE_Array:String = "type_array";
		/**
		 * 空类型数据（返回值类型）。
		 */
		public static const TYPE_NON:String = "type_non";
		
		/**
		 * 单实例。
		 */
		private static var webservice:WebServiceHelper;
		
		
		/**
		 * 获取单例对象引用。
		 * @param webserviceUrl WebService 服务 URL ，默认为 null。
		 */
		public static function getInstance(webserviceUrl:String=null):WebServiceHelper
		{
			if(webservice == null)
			{
				webservice = new WebServiceHelper(webserviceUrl);
			}
			
			return webservice;
		}
		
		
		/**
		 * 构造函数。
		 */
		public function WebServiceHelper(webserviceUrl:String=null)
		{
			if(webserviceUrl)
			{
				this.webserviceUrl = webserviceUrl;
			}
		}
		
		
		/**
		 * webservice URL.
		 */
		private var webserviceUrl:String = "";
		
		
		/**
		 * 调用WebService中指定的方法。
		 * @param functionName 调用WebService中的方法名称。
		 * @param args 调用WebService中的方法时传递的参数。
		 * @param returnType 调用后台方法需要返回的结果数据类型。
		 * @param Complete 执行成功回调函数。
		 * @param Fault 执行失败回调函数。
		 * @return 无。
		 */
		public function execServiceFunc(funcName:String, 
										args:Array, 
										returnType:String, 
										Complete:Function=null, 
										Fault:Function=null):void
		{
			callService(webserviceUrl, funcName, args, OnComplete, OnFault);
			function OnComplete(event:ResultEvent):void
			{
				var result:* = getResultData(event.result, returnType);
				var serviceEvent:ServiceEvent = new ServiceEvent(ServiceEvent.RESULT, result);
				Complete(serviceEvent);
			}
			
			function OnFault(event:FaultEvent):void
			{
				if(Fault != null)
				{
					Fault(event);
				}
			}
		}
		
		
		/**
		 * 根据远程返回来的结果和结果数据类型，重新组织数据格式。
		 * @param sourceObject 远程返回的结果对象。
		 * @param returnType 远程返回的结果数据类型。
		 * @return 解析后的结果对象数据。
		 */
		private function getResultData(sourceObject:Object, returnType:String):*
		{
			var result:*;
			switch(returnType)
			{
				//{"itemCount":2,"items":[{"id":1,"name":"jack","password":"123","role":"管理员"}]}
				//JSON
				case TYPE_JSON:
					var rstObj:Object;
					if(sourceObject != null)
					{
						//解析json为Object
						//rstObj = com.adobe.serialization.json.JSON.decode(event.result.toString());  
						if(sourceObject.toString() != null && sourceObject.toString() != "")
							rstObj = JSON.parse(sourceObject.toString());
					}
					result = rstObj;
					break;
				//XML
				case TYPE_XML:
					var xmlAC:ArrayCollection = new ArrayCollection();
					if(sourceObject != null)
					{
						var resultXML:XML = new XML(sourceObject.toString());
						var xmlList:XMLList = resultXML..row;
						for(var i:int=0; i<xmlList.length(); i++)
						{
							var obj:Object = new Object();
							convertXMLIntoObject(xmlList[i] as XML, obj);
							xmlAC.addItem(obj);
						}
					}
					result = xmlAC;
					break;
				//DataTable
				case TYPE_DataTable:
					var objectAC:ArrayCollection = new ArrayCollection();
					if(sourceObject && sourceObject.Tables && sourceObject.Tables.Table)
						objectAC = sourceObject.Tables.Table.Rows as ArrayCollection;
					result = objectAC;
					break;
				//Array
				case TYPE_Array:
					var resultArr:Array = [];
					if(sourceObject != null && sourceObject is ArrayCollection)
						resultArr = (sourceObject as ArrayCollection).source;
					result = resultArr;
					break;
				//泛型、简单数据类型或者整型
				case TYPE_Generic:
				case TYPE_SimpleData:
				case TYPE_NON:
					result = sourceObject;
					break;
				
				//default:
			}
			
			return result;
		}
		
		
		/**
		 * 远程调用WebService中的方法。
		 * @param serviceUrl 调用的WebService对应的URL。
		 * @param functionName 调用的WebService中的函数名称。
		 * @param args 调用WebService中的方法时传递的参数，即一个按原始参数顺序的数组。
		 * @param Complete 执行成功回调函数。
		 * @param Fault 执行失败回调函数。
		 * @return 无。
		 */
		private function callService(serviceUrl:String, functionName:String, args:Object, Complete:Function, Fault:Function):void
		{
			if(!webserviceUrl || webserviceUrl == "")
			{
				Alert.show("远程调用URL不可用，请核查！", "操作提示...");
				return;
			}
			
			//设置鼠标忙碌状态
			CursorManager.setBusyCursor();
			
			//创建服务访问对象
			var webService:WebService = new WebService();
			webService.wsdl = serviceUrl;
			webService.useProxy = false;
			webService.loadWSDL();
			
			var operation:AbstractOperation = webService.getOperation(functionName);
			operation.arguments = args;
			operation.addEventListener(ResultEvent.RESULT, OnRequestServiceComplete);
			operation.addEventListener(FaultEvent.FAULT, OnRequestServiceFault);
			operation.send();
			
			//成功回调
			function OnRequestServiceComplete(event:ResultEvent):void
			{
				CursorManager.removeBusyCursor();
				Complete(event);
			}
			
			//失败
			function OnRequestServiceFault(event:FaultEvent):void
			{
				CursorManager.removeBusyCursor();
				Alert.show("方法 [" + functionName + "] 远程调用不成功！" + event.fault);
				Fault(event);
			}
		}
		
		
		/**
		 * 将XML类型的数据转化成Object。
		 * @param source 源XML数据。
		 * @param target 目标存储对象。
		 * @return 目标对象。
		 */
		private function convertXMLIntoObject(source:XML, target:Object):Object
		{
			if (source && target) 
			{
				var localName:String;
				for each (var attribute:XML in source.*)
				{
					localName = attribute.localName();
					try
					{ 
						target[localName] = attribute.toString(); 
					}
					catch(e:Error) {}
				}
			}
			return target;
		}
		
		
	}
}





