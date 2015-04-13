package com.xzdbd.as3core.utils
{ 
	import com.xzdbd.as3core.utils.supportClasses.FilterItem;
	
	import mx.collections.ArrayCollection;
	import com.xzdbd.as3core.utils.supportClasses.FilterItem;

	/************************************** 
	 * ArrayCollection 要素集过滤类.
	 * 
	 * @author xzdbd 
	 * 创建于 2013-3-23,下午4:18:47.
	 * 
	 **************************************/ 
	public class ArrayCollectionFilter 
	{ 
		/**
		 * 单实例。
		 */
		private static var arraycollectionFilter:ArrayCollectionFilter;
		
		
		/**
		 * 获取单例对象引用。
		 */
		public static function getInstance():ArrayCollectionFilter
		{
			if(arraycollectionFilter == null)
			{
				arraycollectionFilter = new ArrayCollectionFilter();
			}
			
			return arraycollectionFilter;
		}
		
		
		/**
		 * 根据一个固定的 KEY 值对数据源中的多个字段进行过滤（只要其中一个字段满足过滤条件即判定为满足条件）。
		 * @param source 待过滤数据源。
		 * @param fields 过滤字段集合。
		 * @param key 过滤关键字。
		 */
		public static function filterResultByMultiFields(source:ArrayCollection, fields:Array, key:String):void
		{
			source.filterFunction = filterAC;
			source.refresh();
			
			function filterAC(item:Object):Boolean
			{
				var flag:Boolean = false;
				for each(var field:String in fields)
				{
					if(item.attributes[field] && String(item.attributes[field]).indexOf(key) != -1)
					{
						flag = true;
						break;
					}
				}
				
				return flag;
			}
		}
		
		
		/**
		 * 根据多个过滤条件(filter)对数据源进行统一过滤（条件叠加）。
		 * @param source 需要过滤的数据源。
		 * @param filters 过滤项集合，其中有多个独立的包含完整过滤信息的过滤项 FilterItem。
		 * 
		 * @see com.xzdbd.as3core.utils.filter.FilterItem.
		 */
		public static function executeMultiFilter(source:ArrayCollection, filters:Array):void
		{
			source.filterFunction = filterAC;
			source.refresh();
			
			function filterAC(item:Object):Boolean
			{
				if(item.hasOwnProperty("attributes"))
					return ArrayCollectionFilter.getInstance().executeFilter(item.attributes, filters);
				else
					return ArrayCollectionFilter.getInstance().executeFilter(item, filters);
			}
		}
		
		
		/**
		 * 构造函数。
		 */
		public function ArrayCollectionFilter()
		{
		} 
		
		
		/**
		 * 对过滤项集合进行遍历，并逐一执行过滤条件检查操作。
		 * @param item 当前数据项对象。
		 * @param filters 执行过滤操作的过滤项集合。
		 * @return 如果当前数据项同时满足所有的过滤条件，返回 true，否则返回 false;
		 */
		private function executeFilter(item:Object, filters:Array):Boolean
		{
			var result:Boolean = true;
			for each(var filter:FilterItem in filters)
			{
				var filterField:String = filter.field;
				
				//item中存在属性filterField
				if(item.hasOwnProperty(filterField))
				{
					if(!checkFilter(item, filter))
					{
						result = false;
						break;
					}
				}
				else
				{
					result = false;
					break;
				}
			}
			
			return result;
		}
		
		
		/**
		 * 根据当前过滤项属性，判断对象是否满足过滤条件。
		 * @param item 当前数据项对象。
		 * @param filter 执行过滤操作的过滤项对象。
		 * @return 返回 true 表示满足过滤条件；false 表示不满足条件，需要被排除。
		 */
		private function checkFilter(item:Object, filter:FilterItem):Boolean
		{
			var field:String = filter.field;
			var exact:Boolean = filter.exact;
			var flag:Boolean = false;
			for each(var value:String in filter.values)
			{
				if(item[field] != null)
				{
					//过滤
					if( (!exact && String(item[field]).indexOf(value) != -1) || 
						(exact && String(item[field]) == value) )
					{
						flag = true;
						break;
					}
				}
				else
				{
					flag = false;
					break;
				}
			}
			
			return flag;
		}
		
	} 
} 






