package com.xzdbd.as3core.utils
{ 
	import flash.display.DisplayObject;
	
	import mx.core.IFlexDisplayObject;
	import mx.effects.Blur;
	import mx.events.TweenEvent;
	import mx.managers.PopUpManager;
	
	
	/************************************************** 
	 * 一个实现对话框弹出和隐藏时效果的类.
	 * 
	 * @author xzdbd
	 * 创建于 2012-12-13,下午07:08:24.
	 * 
	 **************************************************/ 
	public class PopupEffect
	{
		/**
		 * 弹出指定对话框，并加以弹出效果。
		 * @param target 弹出对象，必须是一个实现了 IFlexDisplayObject 接口的 DisplayObject 类型对象。
		 * @param parent 弹出时的父组件。
		 * @param modal 是否以模态窗口的形式弹出，默认为 true。
		 * @param popupX 弹出窗左上角在屏幕中的x坐标，默认为NaN，即居中弹出。
		 * @param popupY 弹出窗左上角在屏幕中的y坐标，默认为NaN，即居中弹出。
		 * 
		 */
		public static function show(target:IFlexDisplayObject, parent:DisplayObject, modal:Boolean=true, popupX:Number=NaN, popupY:Number=NaN):void
		{
			var mShowEffect:Blur = new Blur();
			mShowEffect.blurXFrom = 255;
			mShowEffect.blurYFrom = 255;
			mShowEffect.blurXTo = 0;
			mShowEffect.blurYTo = 0;
			mShowEffect.target = target;
			mShowEffect.duration = 300;
			PopUpManager.addPopUp(target, parent, modal);
			if(isNaN(popupX) || isNaN(popupY))
			{
				//target.move(0, parent.y);
				//target.x = popupX;
				//target.y = popupY;
				target.move(popupX, popupY);
			}
			else
			{
				PopUpManager.centerPopUp(target);
			}
			
			//播放效果
			mShowEffect.play();
		}
		
		/**
		 * 隐藏（关闭弹出）指定对话框，并加以隐藏效果。
		 * @param target 隐藏的对象，必须是一个实现了 IFlexDisplayObject 接口的 DisplayObject 类型对象。
		 */
		public static function hide(target:IFlexDisplayObject):void
		{
			var mHideEffect:Blur=new Blur();
			mHideEffect.blurXFrom=0;
			mHideEffect.blurYFrom=0;
			mHideEffect.blurXTo=255;
			mHideEffect.blurYTo=255;
			mHideEffect.addEventListener(TweenEvent.TWEEN_END, tweenEndHandler);
			mHideEffect.duration=300;
			mHideEffect.target=target;
			mHideEffect.play();
			
			function tweenEndHandler(event:TweenEvent):void
			{
				PopUpManager.removePopUp(target);
			}
		}
		
		/**
		 * 构造函数。
		 */
		public function PopupEffect()
		{
		}
	}
} 





