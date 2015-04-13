package com.xzdbd.as3core.components.buttons 
{ 
	import com.xzdbd.as3core.skins.IconButtonSkin;
	
	import spark.components.Button;
	
	
	/**************************************************************************************************************
	 * 以图片样式填充的 Button 按钮（通过皮肤实现样式）.
	 * 
	 * @mxml
	 * <p> 
     * 下面代码演示如何使用 <code>IconButton</code> 类： 
	 * <p>首先，引用命名空间  <b><code>xmlns:as3core="http://www.xzdbd.net/2013/flex/as3core"</code></b>，调用如下：</p>
	 * <pre>
	 * &lt;as3core:IconButton 
	 * 	<b>Properties</b>
	 * 	label="执行操作"
	 * 
	 * 	<b>Styles</b>
	 * 	upIcon="{upIconClass}"
	 * 	overIcon="{overIconClass}"
	 * 	downIcon="{downIconClass}"
	 * 	disableIcon="{disableIconClass}" /&gt;
	 * 
	 * 说明：该组件 <code>label</code> 属性为基类 <code>Button</code> 的属性，该处设置后，文字会叠加显示在图片上面.
	 * 
	 * 其中，upIconClass, overIconClass, downIconClass, disableIconClass 均为图片绑定类，如：
	 * <code>
	 * 	[Embed(source="./images/upIcon.png")]
	 * 	public var upIconClass:Class;
	 * </code>
	 * </pre>
     * </p>
	 * 
	 * @author xzdbd
	 * 创建于 2013-4-16,上午11:05:37.
	 * 
	 ***************************************************************************************************************/ 
	public class IconButton extends Button 
	{ 
		/**
		 * 构造函数。
		 */
		public function IconButton()
		{
			super();
			this.setStyle("skinClass", com.xzdbd.as3core.skins.IconButtonSkin);
		} 
		
		//按钮弹起
		private var _upIcon:Object; 
		//按钮悬浮
		private var _overIcon:Object;  
		//按钮按下
		private var _downIcon:Object;  
		//按钮不可用
		private var _disabledIcon:Object;  
		
		
		[Bindable]
		/**
		 * 按钮弹起时显示的图片。
		 */
		public function get upIcon():Object
		{
			return _upIcon;
		}
		
		/**
		 * @private
		 */
		public function set upIcon(value:Object):void
		{
			_upIcon = value;
		}
		
		[Bindable]
		/**
		 * 鼠标悬浮在按钮上时显示的图片。
		 */
		public function get overIcon():Object
		{
			return _overIcon;
		}
		
		/**
		 * @private
		 */
		public function set overIcon(value:Object):void
		{
			_overIcon = value;
		}
		
		[Bindable]
		/**
		 * 按钮按下时显示的图片。
		 */
		public function get downIcon():Object
		{
			return _downIcon;
		}
		
		/**
		 * @private
		 */
		public function set downIcon(value:Object):void
		{
			_downIcon = value;
		}
		
		[Bindable]
		/**
		 * 按钮不可用时显示的图片。
		 */
		public function get disabledIcon():Object
		{
			return _disabledIcon;
		}
		
		/**
		 * @private
		 */
		public function set disabledIcon(value:Object):void
		{
			_disabledIcon = value;
		}
		
	} 
} 












