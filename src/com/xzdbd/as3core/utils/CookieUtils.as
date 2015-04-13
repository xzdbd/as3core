package com.xzdbd.as3core.utils
{ 
	import flash.external.ExternalInterface;
	import flash.net.SharedObject;
	
	import mx.core.FlexGlobals;


	/***************************************************
	 * Flash 中的 Cookie 功能管理类.
	 * 
	 * @author xzdbd
	 * 创建于 2013-4-3,上午8:36:15.
	 * 
	 ***************************************************/ 
	public class CookieUtils 
	{ 
		/**
		 * 单例实例。
		 */
		private static var _cookieManager:CookieUtils;
		
		/**
		 * 获取单例。
		 */
		public static function getInstance():CookieUtils
		{
			if(_cookieManager == null)
				_cookieManager = new CookieUtils();
			
			return _cookieManager;
		}
		
		
		/**
		 * 获取本地 Flash 中指定数据共享对象（如果没有，则会新建一个空数据对象）。
		 * @param shareName 共享数据对象名称。
		 * @return 指定的共享数据对象。
		 */
		public static function getShareObject(shareName:String):SharedObject
		{
			var shareObject:SharedObject = SharedObject.getLocal(shareName, "/");
			
			return shareObject;
		}
		
		
		/**
		 * 清除指定名称的共享数据对象。
		 * @param shareName 共享数据对象名称。
		 */
		public static function clearShareObject(shareName:String):void
		{
			var shareObject:SharedObject = SharedObject.getLocal(shareName, "/");
			shareObject.clear();
		}
		
		
		/**
		 * 设置指定名称的共享对象为无效对象。
		 */
		public static function setShareObjectInvalid(shareName:String):void
		{
			var shareObject:SharedObject = SharedObject.getLocal(shareName, "/");
			shareObject.data.isValid = false;
		}
		
		
		/**
		 * 检验共享数据是否过期。
		 * @param shareObject 操作的共享对象。
		 * @param timeLimit 过期时间限制（单位：分钟）。
		 * @return 如果数据已过期，返回true，否则返回false。
		 */
		public static function isOverdueData(shareObject:SharedObject, timeLimit:Number):Boolean
		{
			var nowTime:Date = new Date();
			var updateTime:Date = shareObject.data.updateTime as Date;
			if(updateTime && (nowTime.getTime() - updateTime.getTime()) / (1000 * 60) <= timeLimit)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
		
		
		/**
		 * 构造函数。
		 */
		public function CookieUtils()
		{
		} 
		
		
		//===================================================================================================
		// 用户登陆管理（测试阶段）
		//===================================================================================================
		
		/**
		 * 注册浏览器窗口刷新和关闭事件监听，在离开当前页面时调用。
		 */
		public function regWindowCloseHandler():void
		{    
			if(flash.external.ExternalInterface.available)
			{
				var jsStr:String = 
					'eval(\'window.onbeforeunload = onbeforeunloadHandler;' +
					'function onbeforeunloadHandler(){' +
					'window.opener = null;' +
					'var n = window.event.screenX - window.screenLeft;' +
					'var b = n > document.documentElement.scrollWidth-20;' +  
					'var swfRef = document.'+FlexGlobals.topLevelApplication.className+' || window.'+FlexGlobals.topLevelApplication.className+';'+
					'if(b && window.event.clientY < 0 || window.event.altKey) { ' +
					'swfRef.windowCloseHandler();' +
					'window.open("","_self");' + 
					'return "页面关闭提示 ...";}' +
					'else { swfRef.windowRefreshHandler(); }' +
					'}\')';
				
				flash.external.ExternalInterface.call(jsStr);
				flash.external.ExternalInterface.addCallback('windowRefreshHandler', externalWindowRefreshHandler);
				flash.external.ExternalInterface.addCallback('windowCloseHandler', externalWindowCloseHandler);
			}
		}
		
		
		/**
		 * 当页面刷新时调用该函数。
		 */
		private function externalWindowRefreshHandler():void
		{
			var shareObject:SharedObject = getShareObject("userInfo");
			//if(Common.isOverdueData(shareObject, 5))
			//	shareObject.data.updateTime = new Date();
		}
		
		
		/**
		 * 当页面关闭时调用该函数。
		 */
		private function externalWindowCloseHandler():void
		{
			getShareObject("userInfo").data.updateTime = new Date();
			//Common.clearShareObject("userInfo");
		}
	} 
} 








