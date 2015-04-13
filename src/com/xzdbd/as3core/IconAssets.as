package com.xzdbd.as3core
{ 
	/*******************************************
	 * 类库中使用的图片文件资源类.
	 * 
	 * @author xzdbd
	 * 创建于 2013-7-22,下午1:25:59.
	 * 
	 *******************************************/ 
	public final class IconAssets 
	{ 
		/**
		 * 添加文件到列表图标。
		 */
		[Embed(source="assets/images/addFile.png")]
		public var addFileIcon:Class;
		
		/**
		 * 上传文件图标。
		 */
		[Embed(source="assets/images/uploadFile.png")]
		public var uploadFileIcon:Class;
		
		/**
		 * 清空上传列表图标。
		 */
		[Embed(source="assets/images/removeFile.png")]
		public var removeFileIcon:Class;
		
		/**
		 * 移除指定上传文件图标（高亮）。
		 */
		[Embed(source="assets/images/cancelUpload.png")]
		public var cancelUploadIcon:Class;
		
		/**
		 * 移除指定上传文件图标（不可用）。
		 */
		[Embed(source="assets/images/cancelUpload_disable.png")]
		public var cancelUploadIcon_disable:Class;
		
		/**
		 * 从上传界面返回图标。
		 */
		[Embed(source="assets/images/back.png")]
		public var backIcon:Class;
		
		
		/**
		 * 根据名称返回该类中的资源对象。
		 * @param resName 资源名称。
		 * @return 资源名称对应的资源类对象。
		 */
		public static function iconClass(resName:String):Class  
		{  
			var iconAssets:IconAssets = new IconAssets();  
			var iconClass:Class = iconAssets[resName] as Class;
			
			return iconClass;
		}  
		
		
		/**
		 * 构造函数。
		 */
		public function IconAssets()
		{
		} 
	} 
} 





