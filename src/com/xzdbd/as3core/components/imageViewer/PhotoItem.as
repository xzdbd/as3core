package com.xzdbd.as3core.components.imageViewer
{ 

	/******************************************* 
	 * 单张照片记录实体类.
	 * 
	 * @author xzdbd
	 * 创建于 2013-4-23,下午12:56:47.
	 * 
	 *******************************************/ 
	[Bindable]
	public class PhotoItem
	{
		/**
		 * 构造函数。
		 */
		public function PhotoItem()
		{
		} 
		
		private var _siteId:Number;
		private var _targetType:String;
		private var _projectCode:String;
		private var _fileTitle:String;
		private var _fileType:String;
		private var _provideUnit:String;
		private var _collectDate:Date;
		private var _filePath:String;
		private var _angle:Number;
		private var _remark:String;

		/**
		 * 拍摄点Id。
		 */
		public function get siteId():Number
		{
			return _siteId;
		}

		/**
		 * @private
		 */
		public function set siteId(value:Number):void
		{
			_siteId = value;
		}

		/**
		 * 工程编码。
		 */
		public function get projectCode():String
		{
			return _projectCode;
		}

		/**
		 * @private
		 */
		public function set projectCode(value:String):void
		{
			_projectCode = value;
		}

		/**
		 * 文件标题
		 */
		public function get fileTitle():String
		{
			return _fileTitle;
		}

		/**
		 * @private
		 */
		public function set fileTitle(value:String):void
		{
			_fileTitle = value;
		}

		/**
		 * 文件类型。
		 */
		public function get fileType():String
		{
			return _fileType;
		}

		/**
		 * @private
		 */
		public function set fileType(value:String):void
		{
			_fileType = value;
		}

		/**
		 * 提供文件单位。
		 */
		public function get provideUnit():String
		{
			return _provideUnit;
		}

		/**
		 * @private
		 */
		public function set provideUnit(value:String):void
		{
			_provideUnit = value;
		}

		/**
		 * 采集时间。
		 */
		public function get collectDate():Date
		{
			return _collectDate;
		}

		/**
		 * @private
		 */
		public function set collectDate(value:Date):void
		{
			_collectDate = value;
		}

		/**
		 * 存储路径。
		 */
		public function get filePath():String
		{
			return _filePath;
		}

		/**
		 * @private
		 */
		public function set filePath(value:String):void
		{
			_filePath = value;
		}

		/**
		 * 拍摄角度。
		 */
		public function get angle():Number
		{
			return _angle;
		}

		/**
		 * @private
		 */
		public function set angle(value:Number):void
		{
			_angle = value;
		}

		/**
		 * 内容说明。
		 */
		public function get remark():String
		{
			return _remark;
		}

		/**
		 * @private
		 */
		public function set remark(value:String):void
		{
			_remark = value;
		}

		/**
		 * 照片对应的工程类型。
		 */
		public function get targetType():String
		{
			return _targetType;
		}

		/**
		 * @private
		 */
		public function set targetType(value:String):void
		{
			_targetType = value;
		}


	} 
} 




