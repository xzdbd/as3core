package com.xzdbd.as3core.components.buttons
{	
	import mx.controls.Button;
	import mx.controls.ButtonLabelPlacement;
	
	/**********************************************
	 * 纵向 Button 实现类.
	 * 
	 * @mxml
	 * <p> 
     * 下面代码演示如何使用 <code>VerticalButton</code> 类： 
	 * <p>首先，引用命名空间  <b><code>xmlns:as3core="http://www.xzdbd.net/2013/flex/as3core"</code></b>，调用如下：</p>
	 * <pre>
	 * &lt;as3core:VerticalButton 
	 * 	<b>Properties</b>
	 * 	label="工程信息"
	 * 
	 * 	<b>Styles</b>
	 * 	fontSize="14" /&gt;
	 * </pre>
     * </p>
	 * 
	 * @author xzdbd
	 * 创建于 2013-6-11,下午3:25:26.
	 **********************************************/
	public class VerticalButton extends Button
	{
		/**
		 * 构造函数。
		 */
		public function VerticalButton()
		{
			super();
		}
		
		/**
		 * 重写父类 initialize() 方法。
		 */
		override public function initialize():void
		{
			super.initialize();
			this.labelPlacement = ButtonLabelPlacement.TOP;
		}
		
		/**
		 * 重写父类 createChildrene() 方法。
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			textField.wordWrap = true;
			
			/*textField.autoSize = TextFieldAutoSize.CENTER;   
			textField.background = false;  
			textField.border = false;  
			textField.multiline = true; //多行  
			textField.wordWrap = true; //自动换行  
			var format:TextFormat = textField.getTextFormat();  
			format.kerning = true;  
			format.leading=0;//设置行距为5  
			//设置为默认格式  
			textField.defaultTextFormat = format; */
			
			invalidateSize();
		}
		
		/**
		 * 重写父类 updateDisplayList 方法。
		 */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			if (label != "")
			{
				var len:int = label.length, i:int=0;
				textField.text = "";
				for (i;i<len;i++)
				{
					if (i != len -1)
						textField.appendText(label.substr(i,1)+"\n");
					else
						textField.appendText(label.substr(i,1));
				}
				textField.width = textField.textWidth + 5;
				textField.height = textField.textHeight + 2;
				this.height = textField.height + 5;
				this.width = textField.width + 5;
			}
			textField.y=(height-textField.height)/2;
			textField.x=(width-textField.width)/2;
		}
	}
}