package com.xzdbd.as3core.components.supportClasses
{ 
	import flash.display.DisplayObject;
	import flash.filters.DropShadowFilter;
	
	import mx.controls.TextInput;
	import mx.core.IFlexDisplayObject;
	
	/**
	 * 文本框中左侧显示的图片，默认为空。
	 */
	[Style(name="icon", type="Class", inherit="no")]
	/**
	 * 文本框圆角的半径，默认为0，即无圆角效果。
	 */
	[Style(name="cornerRadius", type="Number", inherit="no")]
	/**
	 * 文本框背景颜色。
	 */
	[Style(name="backgroundColor", type="uint", inherit="no")]
	
	
	/*********************************************************
	 * 基于 mx:TextInput 的圆角单行文本输入框.
	 * 
	 * <p>该类不建议直接使用，因为已经继承该类的 <code>TextInputProme</code> 不仅可以实现该类的所有功能和效果，还拥有输入提示功能.</p>
	 * 
	 * @mxml
	 * <p> 
     * 下面代码演示如何使用 <code>RoundCornerTextInput</code> 类： 
	 * <p>首先，引用命名空间  <b><code>xmlns:as3core="http://www.xzdbd.net/2013/flex/as3core"</code></b>，调用如下：</p>
	 * <pre>
	 * &lt;as3core:RoundCornerTextInput 
	 * 	<b>Properties</b>
	 * 	text="输入查询关键字..."
	 * 	enter="doSearch()"
	 * 
	 * 	<b>Styles</b>
	 * 	icon="assets/images/example.png"
	 * 	cornerRadius="5"
	 * 	backgroundColor="0xFFFFFF"
	 * 	fontSize="14" /&gt;
	 * 
	 * 其中，<code>enter="doSearch()"</code> 为回车键按下动作响应.
	 * </pre>
     * </p>
	 * 
	 * @author xzdbd
	 * 创建于 2013-05-24,上午10:39:51.
	 * 
	 *********************************************************/
	public class RoundCornerTextInput extends TextInput
	{
		/**
		 * 构造函数。
		 */
		public function RoundCornerTextInput()
		{
			super();
			this.setStyle("paddingTop", 2);
			this.filters = [new DropShadowFilter(2, 90, 0x000000, 0.6, 2, 2, 1, 1, true)];
		}
		
		private var _icon:IFlexDisplayObject;
		
		/**
		 * 重写父类createBorder方法。
		 */
		override protected function createBorder():void
		{
		}
		
		/**
		 * 重写父类height属性set方法。
		 */
		override public function set height(value:Number):void
		{
			super.height = value;
			if(_icon){
				_icon.y = (this.height - _icon.height)/2;
			}
			if(textField){
				this.setStyle("paddingTop" , (this.height - textField.height)/2);
			}
		}
		
		/**
		 * 重写父类createChildren方法。
		 */
		override protected function createChildren() : void
		{
			super.createChildren();
			createIcon();
		}
		
		/**
		 * 创建Icon对象。
		 */
		protected function createIcon():void{
			if(!_icon){
				var iconClass:Class = this.getStyle("icon");
				if(iconClass!=null){
					_icon = new iconClass();
					addChild(DisplayObject(_icon));
					_icon.y = (this.height - _icon.height)/2;
					invalidateDisplayList();
				}
			}
		}
		
		/**
		 * 重写父类getStyle方法。
		 */
		override public function getStyle(styleProp:String):*{
			var result:* = super.getStyle(styleProp);
			if(styleProp=="paddingLeft"){
				if(!result){
					return _icon ? _icon.width : super.getStyle("cornerRadius");
				}
			}
			if(styleProp=="paddingRight"){
				if(!result){
					return super.getStyle("cornerRadius");
				}
			}
			return result;
		}
		
		/**
		 * 重写父类styleChanged方法。
		 */
		override public function styleChanged(styleProp:String):void{
			var allStyles:Boolean = (styleProp == null || styleProp == "styleName");
			super.styleChanged(styleProp);
			if(allStyles || styleProp == "icon"){
				if(_icon){
					removeChild(DisplayObject(_icon));
					_icon = null;
					createIcon();
				}
			}
		}
		
		/**
		 * 重写父类updateDisplayList方法。
		 */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			this.graphics.clear();
			
			var backgroundColor:uint = getStyle("backgroundColor");
			var backgroundAlpha:Number = getStyle("backgroundAlpha");
			var cornerRadius:Number = this.getStyle("cornerRadius");
			this.graphics.lineStyle(1, 0x666666, 1, true);
			this.graphics.beginFill(backgroundColor, backgroundAlpha);
			this.drawRoundRect(0, 0, unscaledWidth, unscaledHeight, cornerRadius);
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
	}
} 


