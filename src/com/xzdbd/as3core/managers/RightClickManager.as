package com.xzdbd.as3core.managers
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import mx.core.FlexGlobals;
	
	
	/*************************************************************************************************** 
	 * 一个在Flash中实现鼠标右键菜单的类（同时隐藏Flash自带系统菜单）.
	 * 
	 * @example
	 * 下面代码演示如何使用 <code>RightClickManager</code> 类：
	 * <p>第一步，在系统初始化入口添加如下代码：</p>
	 * <listing version="3.0">
	 * //注册类
	 * RightClickManager.regist();
	 * 
	 * //注册函数到外部可调用，其中onMouseRightButtonClicked函数为按下右键弹出菜单时的回调函数
	 * ExternalInterface.addCallback(RightClickManager.RIGHT_CLICK, onMouseRightButtonClicked);
	 * </listing>
	 * 
	 * <p>第二步，在"index.template.html"中添加参数：<code>params.wmode = "opaque"; //屏蔽系统右键菜单的关键 </code></p>
     *  
	 * @author xzdbd
	 * 创建于 2013-5-13,下午07:08:24.
	 ****************************************************************************************************/ 
	public class RightClickManager
	{
		/**
		 * 鼠标右击事件常量。
		 */
		public static const RIGHT_CLICK:String = "rightClick";
		
		/**
		 * JS处理脚本（第三方提供）。
		 */
		private static const javascript:XML = 
			<script>
				<![CDATA[
					/**
					 * 
					 * Copyright 2007
					 * 
					 * Paulius Uza
					 * http://www.uza.lt
					 * 
					 * Dan Florio
					 * http://www.polygeek.com
					 * 
					 * Project website:
					 * http://code.google.com/p/custom-context-menu/
					 * 
					 * --
					 * RightClick for Flash Player. 
					 * Version 0.6.2
					 * 
					 */
					function(flashObjectId)
					{				
						var RightClick = {
							/**
							 *  Constructor
							 */ 
							init: function (flashObjectId) {
								this.FlashObjectID = flashObjectId;
								this.Cache = this.FlashObjectID;
								if(window.addEventListener){
									 window.addEventListener("mousedown", this.onGeckoMouse(), true);
								} else {
									document.getElementById(this.FlashObjectID).parentNode.onmouseup = function() { document.getElementById(RightClick.FlashObjectID).parentNode.releaseCapture(); }
									document.oncontextmenu = function(){ if(window.event.srcElement.id == RightClick.FlashObjectID) { return false; } else { RightClick.Cache = "nan"; }}
									document.getElementById(this.FlashObjectID).parentNode.onmousedown = RightClick.onIEMouse;
								}
							},
							/**
							 * GECKO / WEBKIT event overkill
							 * @param {Object} eventObject
							 */
							killEvents: function(eventObject) {
								if(eventObject) {
									if (eventObject.stopPropagation) eventObject.stopPropagation();
									if (eventObject.preventDefault) eventObject.preventDefault();
									if (eventObject.preventCapture) eventObject.preventCapture();
									if (eventObject.preventBubble) eventObject.preventBubble();
								}
							},
							/**
							 * GECKO / WEBKIT call right click
							 * @param {Object} ev
							 */
							onGeckoMouse: function(ev) {
								return function(ev) {
								if (ev.button == 2) {
									RightClick.killEvents(ev);
									if(ev.target.id == RightClick.FlashObjectID && RightClick.Cache == RightClick.FlashObjectID) {
										RightClick.call();
									}
									RightClick.Cache = ev.target.id;
								}
							  }
							},
							/**
							 * IE call right click
							 * @param {Object} ev
							 */
							onIEMouse: function() {
								if (event.button == 2) {
									if(window.event.srcElement.id == RightClick.FlashObjectID && RightClick.Cache == RightClick.FlashObjectID) {
										RightClick.call(); 
									}
									document.getElementById(RightClick.FlashObjectID).parentNode.setCapture();
									if(window.event.srcElement.id)
									RightClick.Cache = window.event.srcElement.id;
								}
							},
							/**
							 * Main call to Flash External Interface
							 */
							call: function() {
								document.getElementById(this.FlashObjectID).rightClick();
							}
						}
						
						RightClick.init(flashObjectId);
					}
				]]>
			</script>;
		
		/**
		 * 鼠标右击的组件对象。
		 */
		private static var rightClickTarget:DisplayObject;
		
		/**
		 * 注册右键管理类，阻止Flash自带右键菜单弹出。
		 */
		public static function regist():Boolean
		{
			if (ExternalInterface.available)
			{
				ExternalInterface.call(javascript, ExternalInterface.objectID);
				ExternalInterface.addCallback("rightClick", dispatchRightClickEvent);
				FlexGlobals.topLevelApplication.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			}
			
			return true;
		}
		
		/**
		 * 鼠标悬浮事件监听处理函数。
		 */
		private static function mouseOverHandler(event:MouseEvent):void
		{
			rightClickTarget = DisplayObject(event.target);
			return;
		}
		
		/**
		 * 向外派发右键点击事件。
		 */
		private static function dispatchRightClickEvent():void
		{
			var event:MouseEvent;
			if (rightClickTarget != null)
			{
				event = new MouseEvent(RIGHT_CLICK, true, false, rightClickTarget.mouseX, rightClickTarget.mouseY);
				rightClickTarget.dispatchEvent(event);
			}
			
			return;
		}
		
		/**
		 * 构造函数。
		 */
		public function RightClickManager()
		{
			return;
		}
		
	}
}






