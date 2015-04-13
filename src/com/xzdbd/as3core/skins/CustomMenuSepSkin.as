package com.xzdbd.as3core.skins
{ 
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	
	import mx.skins.ProgrammaticSkin;
	
	/************************************** 
	 * 自定义菜单分割线样式类.
	 * 
	 * @author xzdbd
	 * 创建于 2013-5-9,下午6:35:42.
	 * 
	 **************************************/ 
	public class CustomMenuSepSkin extends ProgrammaticSkin
	{
		public function CustomMenuSepSkin()
		{
			super();  
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			var w:Number=this.width;
			var h:Number=1;
			var fillType:String = GradientType.LINEAR;
			var color:Array = [0xE2E2E2,0xC7C7C7];
			var alphas:Array = [100,100];
			var ratios:Array = [0xE2, 0xC7];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(20,20,0,0,0);
			var spreadMethod:String = SpreadMethod.PAD;
			graphics.beginGradientFill(fillType,color,alphas,ratios,matr,spreadMethod);
			graphics.drawRect(0,0,w,h);
			graphics.endFill(); 
		}
	}
} 