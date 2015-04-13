package com.xzdbd.as3core.skins
{ 
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	
	import mx.skins.halo.HaloBorder;
	
	/************************************** 
	 * 自定义菜单边框样式类.
	 * 
	 * @author xzdbd
	 * 创建于 2013-5-9,下午6:34:35.
	 * 
	 **************************************/ 
	public class MenuBorderSkin extends HaloBorder
	{
		public function MenuBorderSkin()
		{
			super();
		}  
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			var dropShadow:DropShadowFilter = new DropShadowFilter();
			dropShadow.color=0x000000; //设置投影
			dropShadow.alpha=0.25; //阴影颜色的 Alpha 透明度值。
			dropShadow.blurX=0; //水平模糊量。
			dropShadow.blurY=10; //重置模糊量
			dropShadow.angle=90; //阴影的角度。
			dropShadow.distance=4; //阴影的偏移距离，以像素为单位。
			filters=[dropShadow]; 
			
			var w:Number = this.width;
			var h:Number = this.height;
			var fillType:String = GradientType.LINEAR; //渐变类型--直线
			var color:Array = [0xE2E2E2,0xFFFFFF]; //渐变颜色
			var alphas:Array = [50,100]; //colors 数组中对应颜色的 alpha 值数组
			var ratios:Array = [0xE2, 0xFF];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(22,22,0,0,0);
			var spreadMethod:String = SpreadMethod.PAD;
			graphics.beginGradientFill(fillType,color,alphas,ratios,matr,spreadMethod);
			graphics.drawRect(0,0,w,h);
			graphics.endFill();
		} 
	}
} 