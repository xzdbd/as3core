package com.xzdbd.as3core.components
{
	
	import flash.display.DisplayObject;
	import flash.events.FocusEvent;
	import com.xzdbd.as3core.components.supportClasses.RoundCornerTextInput;
	
	/*********************************************************
	 * 基于 mx:TextInput 的圆角单行文本输入框（带输入提示）.
	 * 
	 * @mxml
	 * <p> 
     * 下面代码演示如何使用 <code>TextInputProme</code> 类： 
	 * <p>首先，引用命名空间  <b><code>xmlns:as3core="http://www.xzdbd.net/2013/flex/as3core"</code></b>，调用如下：</p>
	 * <pre>
	 * &lt;as3core:TextInputProme 
	 * 	<b>Properties</b>
	 * 	prompt="输入查询关键字..."
	 * 
	 * 	<b>Styles</b>
	 * 	cornerRadius="5"
	 * 	backgroundColor="0xFFFFFF"
	 * 	fontSize="14" /&gt;
	 * 
	 * 	<b>Events</b>
	 * 	enter="doSearch()"
	 * 
	 * 其中，<code>enter="doSearch()"</code> 为回车键按下动作响应.
	 * </pre>
     * </p>
	 * 
	 * @see com.xzdbd.as3core.components.supportClasses.RoundCornerTextInput
	 * 
	 * @author xzdbd
	 * 创建于 2013-6-11,下午3:25:26.
	 * 
	 *********************************************************/
	public class TextInputProme extends RoundCornerTextInput
	{
		/**
		 * 构造函数。
		 */
		public function TextInputProme()
		{
			super();
		}
		
		/**
		 *  @private
		 */
		private var _prompt:String = "";
		private var tmp:Boolean = false;
		
		/**
		 *  prompt 作用是用于输入框提示。
		 *  <br>当输入框获得焦点时 清除 text的值和文本颜色，还原原来的文本颜色。
		 *  <br>当输入框失去焦点时，判断文本是否为空，如何为空继续显示提示，否则不做任何修改。
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get prompt():String
		{
			return _prompt;
		}
		/**
		 *  @private
		 */
		public function set prompt(value:String):void
		{
			if (_prompt == value)
				return;
			_prompt = value;
			super.text = _prompt;
			this.setStyle("color","#A9A8A8");
			tmp = true;
		}
		
		/**
		 *  @private 当输入框获得焦点时
		 */
		override protected function focusInHandler(event:FocusEvent):void
		{
			if (event.target == this)
			{
				// call setFocus on ourselves to pass focus to the
				// textDisplay.  This situation occurs when the
				// player occasionally takes over the first TAB
				// on a newly activated Window with nothing currently
				// in focus
				setFocus();
				return;
			}
			if(tmp){
				super.text = "";
				this.setStyle("color","#000000");
				tmp = false;
			}
			// Only editable text should have a focus ring.
			if (enabled && editable && focusManager)
				focusManager.showFocusIndicator = true;
			
			super.focusInHandler(event);
		}
		
		/**
		 *  @private 当输入框失去焦点时
		 */
		override protected function focusOutHandler(event:FocusEvent):void
		{
			if(super.text == ""){
				tmp = true;
				super.text = _prompt;
				this.setStyle("color","#A9A8A8");
			}
			// We don't need to remove our event listeners here because we
			// won't receive keyboard events.
			if (isOurFocus(DisplayObject(event.target)))
				drawFocus(false);
		}
	}
}



