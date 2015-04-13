package com.xzdbd.as3core.components
{ 
	import mx.containers.GridItem;
	
	import spark.components.Label;
	
	
	/*******************************************
	 * 继承自 GridItem 的包装组件（内含 Label 控件）.
	 * 
	 * @mxml
	 * <p> 
     * 下面代码演示如何使用 <code>SingleLine</code> 类： 
	 * <p>首先，引用命名空间  <b><code>xmlns:as3core="http://www.xzdbd.net/2013/flex/as3core"</code></b>，调用如下：</p>
	 * <pre>
	 * &lt;as3core:SingleLine 
	 * 	<b>Properties</b>
	 * 	itemLabel="50年一遇"
	 * 	isTitle="false"
	 * 
	 * 	<b>Styles</b>
	 * 	color="0x0000FF" 
	 * 	fontWeight="true"
	 * 	width="100%" /&gt;
	 * </pre>
     * </p>
	 * 
	 * @author xzdbd
	 * 创建于 2013-7-30,下午2:15:58.
	 * 
	 *******************************************/ 
	public class GridItemContent extends GridItem 
	{ 
		/**
		 * 构造函数.
		 */
		public function GridItemContent()
		{
			super();
			
			this.setStyle("backgroundColor", 0xFFFFFF);
			this.setStyle("borderColor", 0xc9cbd5);
			this.setStyle("horizontalAlign", "left");
			this.setStyle("paddingLeft", 2);
			this.percentWidth = 100;
			this.percentHeight = 100;
			
			textLabel = new Label();
			textLabel.text = itemLabel;
			textLabel.setStyle("fontSize", fontSize);
			textLabel.setStyle("fontWeight", fontWeight ? "bold" : "normal");
			textLabel.setStyle("fontFamily", fontFamily);
			textLabel.setStyle("color", color);
			
			this.addChild(textLabel);
		} 
		
		//内含文本组件对象
		private var textLabel:Label;
		
		private var _isTitle:Boolean;
		
		private var _fontSize:Number = 12;
		
		private var _color:uint = 0x000000;
		
		private var _fontWeight:Boolean = false;
		
		private var _fontFamily:String = "宋体";
		
		private var _itemLabel:String;
		
		[Bindable]
		/**
		 * 内容文本字体大小。
		 */
		public function get fontSize():Number
		{
			return _fontSize;
		}
		/**
		 * @private
		 */
		public function set fontSize(value:Number):void
		{
			_fontSize = value;
			textLabel.setStyle("fontSize", _fontSize);
		}

		[Bindable]
		/**
		 * 内容文本字体颜色。
		 */
		public function get color():uint
		{
			return _color;
		}
		/**
		 * @private
		 */
		public function set color(value:uint):void
		{
			_color = value;
			textLabel.setStyle("color", _color);
		}

		[Bindable]
		/**
		 * 内容文本字体是否为粗体，true 为粗体。
		 */
		public function get fontWeight():Boolean
		{
			return _fontWeight;
		}
		/**
		 * @private
		 */
		public function set fontWeight(value:Boolean):void
		{
			_fontWeight = value;
			textLabel.setStyle("fontWeight", _fontWeight ? "bold" : "normal");
		}

		[Bindable]
		/**
		 * 内容文本字体名称.
		 */
		public function get fontFamily():String
		{
			return _fontFamily;
		}
		/**
		 * @private
		 */
		public function set fontFamily(value:String):void
		{
			_fontFamily = value;
			textLabel.setStyle("fontFamily", _fontFamily);
		}

		[Bindable]
		/**
		 * 内容文本.
		 */
		public function get itemLabel():String
		{
			return _itemLabel;
		}
		/**
		 * @private
		 */
		public function set itemLabel(value:String):void
		{
			_itemLabel = value;
			textLabel.text = _itemLabel;
		}

		/**
		 * 该网格内容是否为标题部分。
		 */
		public function get isTitle():Boolean
		{
			return _isTitle;
		}
		/**
		 * @private
		 */
		public function set isTitle(value:Boolean):void
		{
			_isTitle = value;
			if(_isTitle)
			{
				textLabel.setStyle("fontSize", 13);
				textLabel.setStyle("fontWeight", "bold");
				textLabel.setStyle("fontFamily", "微软雅黑");
				this.setStyle("horizontalAlign", "center");
				this.setStyle("backgroundColor", 0xF3F3EF);
				this.setStyle("paddingLeft", 0);
			}
			else
			{
				textLabel.setStyle("fontSize", fontSize);
				textLabel.setStyle("fontWeight", fontWeight ? "bold" : "normal");
				textLabel.setStyle("fontFamily", fontFamily);
				this.setStyle("backgroundColor", 0xFFFFFF);
				this.setStyle("borderColor", 0xc9cbd5);
				this.setStyle("horizontalAlign", "left");
				this.setStyle("paddingLeft", 2);
			}
		}

		
	} 
} 






