package com.xzdbd.as3core.services
{
	import mx.controls.Alert;
	import mx.managers.CursorManager;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	/*******************************************************************
	 * 该类实现了通过 HttpService 对远程服务器上的 Web 服务进行访问的接口.
	 * 
	 * @example
     * 下面代码演示如何使用 <code>HttpServiceHelper</code> 类： 
	 * <listing version="3.0">
	 * //执行服务方法调用（详见函数说明）
	 * HttpServiceHelper.getInstance().execServiceFunc("GetDikesDistrictToJson", params, HttpServiceHelper.GET_METHOD, OnResult, OnFault);
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
	 * 创建于 2013-9-9,上午09:21:31.
	 *
	 *******************************************************************/
	public class HttpServiceHelper
	{
		/**
		 * GET（服务访问方式）。
		 */
		public static const GET_METHOD:String = "get_method";
		/**
		 * POST（服务访问方式）。
		 */
		public static const POST_METHOD:String = "post_method";
		
		/**
		 * JSON 类型数据（返回值类型）。
		 */
		public static const TYPE_JSON:String = "type_json";
		/**
		 * 空类型数据（返回值类型）。
		 */
		public static const TYPE_NON:String = "type_non";
		
		/**
		 * 单实例。
		 */
		private static var httpservice:HttpServiceHelper;
		
		
		/**
		 * 获取单例对象引用。
		 * @param webserviceUrl WebService 服务 URL ，默认为 null。
		 */
		public static function getInstance(httpserviceUrl:String=null):HttpServiceHelper
		{
			if(httpservice == null)
			{
				httpservice = new HttpServiceHelper(httpserviceUrl);
			}
			
			return httpservice;
		}
		
		
		/**
		 * 构造函数。
		 */
		public function HttpServiceHelper(httpserviceUrl:String=null)
		{
			if(httpserviceUrl)
			{
				this.httpserviceUrl = httpserviceUrl;
			}
		}
		
		
		/**
		 * httpservice URL.
		 */
		private var httpserviceUrl:String = "";
		
		
		/**
		 * 通过Get方法请求指定的Url及接口。
		 * @param url 调用的Url地址。
		 * @param functionName 调用HttpService中的方法名称。
		 * @param args 调用HttpService中的方法时传递的参数，为一个由键值对组成的Object。
		 * @param Complete 执行成功回调函数。
		 * @param Fault 执行失败回调函数。
		 * @return 无。
		 */
		public function requestGetURL(url:String,
								      funcName:String, 
								      args:Object, 
								      Complete:Function=null, 
								      Fault:Function=null):void
		{
			callService(url, funcName, args, GET_METHOD, OnComplete, OnFault);
			function OnComplete(jsonResult:Object):void
			{
				var result:Object = getResultData(jsonResult, TYPE_JSON);
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
		 * 通过Get方法请求指定的Url及接口。
		 * @param url 调用的Url地址。
		 * @param functionName 调用HttpService中的方法名称。
		 * @param args 调用HttpService中的方法时传递的参数，为一个由键值对组成的Object。
		 * @param Complete 执行成功回调函数。
		 * @param Fault 执行失败回调函数。
		 * @return 无。
		 */
		public function requestPostURL(url:String,
								       funcName:String, 
								       args:Object, 
								       Complete:Function=null, 
								       Fault:Function=null):void
		{
			var httpService:HTTPService= new HTTPService();
			//httpService.contentType = "application/json";
			httpService.url = url + "/" + funcName;
			httpService.method = HTTPRequestMessage.POST_METHOD;
			httpService.request = args;
			
			httpService.resultFormat = HTTPService.RESULT_FORMAT_OBJECT;
			httpService.addEventListener(ResultEvent.RESULT, OnRequestServiceComplete);
			httpService.addEventListener(FaultEvent.FAULT, OnRequestServiceFault);
			httpService.send();
			
			//成功回调
			function OnRequestServiceComplete(event:ResultEvent):void
			{
				var result:Object = getResultData(event.result, TYPE_JSON);
				var serviceEvent:ServiceEvent = new ServiceEvent(ServiceEvent.RESULT, result);
				Complete(serviceEvent);
			}
			
			//失败
			function OnRequestServiceFault(event:FaultEvent):void
			{
				if(Fault != null)
				{
					Fault(event);
				}
			}
		}
		
		
		/**
		 * 调用HttpService中指定的方法。
		 * @param functionName 调用HttpService中的方法名称。
		 * @param args 调用HttpService中的方法时传递的参数，为一个由键值对组成的Object。
		 * @param method 发送请求的 HTTP 方法，目前允许的值有 GET和POST。
		 * @param Complete 执行成功回调函数。
		 * @param Fault 执行失败回调函数。
		 * @return 无。
		 */
		public function execMethod(funcName:String, 
								   args:Object, 
								   method:String,
								   Complete:Function=null, 
								   Fault:Function=null):void
		{
			callService(httpserviceUrl, funcName, args, method, OnComplete, OnFault);
			function OnComplete(jsonResult:Object):void
			{
				var result:Object = getResultData(jsonResult, TYPE_JSON);
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
		 * @param sourceObject 远程返回的包含结果集的JSON格式字符串。
		 * @param returnType 远程返回的结果数据类型。
		 * @return 解析后的结果对象数据。
		 */
		private function getResultData(sourceObject:Object, returnType:String):Object
		{
			var result:Object;
			switch(returnType)
			{
				case TYPE_JSON:
					var jsonResult:Object;
					if(sourceObject && sourceObject.toString() && sourceObject.toString() != "")
					{
						try
						{
							//解析json为Object
							jsonResult = JSON.parse(sourceObject.toString());
						}
						catch(error:Error)
						{
							Alert.show("Json对象解析不正确，请检查后台服务返回值情况！", "操作提示...");
						}
						
					}
					result = jsonResult;
					break;
				//空类型
				case TYPE_NON:
					result = sourceObject;
					break;
				
				//default:
			}
			
			return result;
		}
		
		
		/**
		 * 远程调用HttpService中的方法。
		 * @param serviceUrl 调用的HttpService对应的URL。
		 * @param functionName 调用的HttpService中的函数名称。
		 * @param args 调用HttpService中的方法时传递的参数对象，由对象中的一个或多个键值对组成。
		 * @param method 发送请求的 HTTP 方法，目前允许的值有 GET和POST。
		 * @param Complete 执行成功回调函数。
		 * @param Fault 执行失败回调函数。
		 * @return 无。
		 */
		private function callService(serviceUrl:String, 
									 functionName:String, 
									 args:Object, 
									 method:String, 
									 Complete:Function, 
									 Fault:Function):void
		{
			if(!httpserviceUrl || httpserviceUrl == "")
			{
				Alert.show("远程调用(HttpService)URL不可用，请核查！", "操作提示...");
				return;
			}
			
			//设置鼠标忙碌状态
			CursorManager.setBusyCursor();
			
			//相参数列表中添加随机数属性，避免缓存影响
			if(args && (!args.hasOwnProperty("random")))
			{
				args.random = Math.random();
			}
			
			var httpService:HTTPService= new HTTPService();
			httpService.contentType = "application/json";
			httpService.url = serviceUrl + "/" + functionName;
			if(method == GET_METHOD)
			{
				httpService.method = HTTPRequestMessage.GET_METHOD;
				httpService.request = args;
			}
			else
			{
				httpService.method = HTTPRequestMessage.POST_METHOD;
				httpService.request = JSON.stringify(args);
			}
			httpService.resultFormat = HTTPService.RESULT_FORMAT_OBJECT;
			httpService.addEventListener(ResultEvent.RESULT, OnRequestServiceComplete);
			httpService.addEventListener(FaultEvent.FAULT, OnRequestServiceFault);
			httpService.send();
			
			//成功回调
			function OnRequestServiceComplete(event:ResultEvent):void
			{
				var resultString:String = event.result.toString();
				
				//剥离结果中的标题，仅剩下结果集
				var tmpResult:Object = JSON.parse(resultString);
				
				//如果WCF服务端对反馈结果进行了包装，则需要抽取出结果对应的JSON字符串，默认的处理方式是添加"方法名+Result"属性
				//var lastJsonResult:String = String(tmpResult[functionName + "Result"]);
				var lastJsonResult:String = String(tmpResult);
				
				CursorManager.removeBusyCursor();
				Complete(lastJsonResult);
			}
			
			//失败
			function OnRequestServiceFault(event:FaultEvent):void
			{
				CursorManager.removeBusyCursor();
				Alert.show("方法 [" + functionName + "] 请求不成功！" + event.fault);
				Fault(event);
			}
		}
		
	}
}





