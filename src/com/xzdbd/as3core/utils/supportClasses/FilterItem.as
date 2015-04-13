package com.xzdbd.as3core.utils.supportClasses 
{ 
	/*******************************************
	 * 数据集合过滤中的过滤元素项类.
	 * 
	 * @author xzdbd
	 * 创建于 2013-7-16,下午4:19:46.
	 * 
	 *******************************************/ 
	public class FilterItem 
	{ 
		/**
		 * 构造函数。
		 * @param field 源数据集合中的待过滤字段名。
		 * @param values 过滤使用的过滤数据集。
		 * @param exact 指定当前匹配是否为精确匹配，true 为精确匹配，false 为模糊匹配。
		 * 
		 */
		public function FilterItem(field:String="", values:Array=null, exact:Boolean=false)
		{
			_field = field;
			_values = values ? values : [];
			_exact = exact;
		} 
		
		//=============== 属性 ====================
		
		private var _field:String;
		
		private var _values:Array;
		
		private var _exact:Boolean;

		
		/**
		 * 源数据集合中的待过滤字段名。
		 */
		public function get field():String
		{
			return _field;
		}

		/**
		 * @private
		 */
		public function set field(value:String):void
		{
			_field = value;
		}

		/**
		 * 过滤使用的过滤数据集。
		 */
		public function get values():Array
		{
			return _values;
		}

		/**
		 * @private
		 */
		public function set values(value:Array):void
		{
			_values = value;
		}

		/**
		 * 指定当前匹配是否为精确匹配，true 为精确匹配，false 为模糊匹配。
		 */
		public function get exact():Boolean
		{
			return _exact;
		}

		/**
		 * @private
		 */
		public function set exact(value:Boolean):void
		{
			_exact = value;
		}


	} 
} 













