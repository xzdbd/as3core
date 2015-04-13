package com.xzdbd.as3core.utils
{ 
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	
	/*****************************************
	 * 通用工具类.
	 * 
	 * @author xzdbd
	 * 创建于 2013-3-20,上午9:45:39.
	 * 
	 *****************************************/ 
	public class Common 
	{ 
		
		/**
		 * 将 XML 类型的数据转化成 Object 对象。
		 * @param source 源XML数据。
		 * @return 转换后目标对象。
		 */
		public static function convertXMLIntoObject(source:XML):Object
		{
			var target:Object = {};
			if (source) 
			{
				var localName:String;
				for each (var attribute:XML in source.*)
				{
					localName = attribute.localName();
					try
					{ 
						target[localName] = attribute.toString(); 
					}
					catch(e:Error)
					{
					}
				}
			}
			
			return target;
		}
		
		
		/**
		 * 对集合进行简单排序。
		 * @param source 待排序数据源。
		 * @param field 排序字段。
		 * @param descending 指示比较运算符是否按降序排列项目。
		 * @param numeric 指示比较运算符是否按编号而不按字母顺序比较排序项目。
		 * @return 对排序后的新集合的引用。
		 */
		public static function sortCollection(source:ICollectionView, 
											  field:String=null, 
											  descending:Boolean=false, 
											  numeric:Object=null):ICollectionView
		{
			//排序对象
			var sort:Sort = new Sort();
			
			//构建排序字段
			var dataSortField:SortField = new SortField(field, false, descending, numeric);
			
			sort.fields = [dataSortField];
			source.sort = sort;
			source.refresh();
			
			return source;
		}
		
		
		/**
		 * 对数据集合按其中指定字段值的首字符拼音进行排序。
		 * @param source 要排序的数据集对象。
		 * @param field 要排序的字段。
		 * @return 排序之后的数据集对象。
		 */
		public static function sortByChinese(source:ArrayCollection, field:String):Object
		{
			//增加中文排序辅助字段
			for each(var item:Object in source)
			{
				addCHSortFields(item, field);
			}
			
			//设置排序字段
			var dataSortField_1:SortField = new SortField("BYTE_1");
			var dataSortField_2:SortField = new SortField("BYTE_2");
			dataSortField_1.descending = false;
			dataSortField_2.descending = false;
			dataSortField_1.numeric = true;
			dataSortField_2.numeric = true;
			
			//新建排序
			var sort:Sort = new Sort();
			sort.fields = [dataSortField_1, dataSortField_2];
			
			//开始排序
			source.sort = sort;
			source.refresh();
			
			return source;
		}
		
		/**
		 * 对数据源增加中文排序字段。
		 * @param node 要排序的对象。
		 * @param field 要排序的字段。
		 */
		private static function addCHSortFields(item:Object, field:String):void
		{
			if(item[field] && String(item[field]).length > 0)
			{
				var bytes:ByteArray = new ByteArray();
				bytes.writeMultiByte(item[field].charAt(0), "gb2312");
				item.BYTE_1 = bytes[0];
				if(item[field].charCodeAt(0) > 122)
					item.BYTE_2 = bytes[1];
				else
					item.BYTE_2 = 0;
			}
		}
		
		
		/**
		 * 构造函数。
		 */
		public function Common()
		{
		} 
		
	} 
} 







