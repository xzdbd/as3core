package com.xzdbd.as3core.utils 
{ 
	import mx.collections.ArrayCollection;
	import mx.controls.Tree;
	
	/*******************************************
	 * Tree 组件相关工具类.
	 * 
	 * @author xzdbd
	 * 创建于 2013-7-16,下午6:13:32.
	 * 
	 *******************************************/ 
	public class TreeUtils 
	{ 
		
		/**
		 * 遍历树状数据集合，根据关键字查找对应节点（模糊匹配）。
		 * @param sourceAC 集合数据源。
		 * @param key 查找关键字。
		 * @param fieldName 数据源中关键字匹配字段名称。
		 * @param results 查找结果集。
		 */
		public static function searchNodesByKey(sourceAC:ArrayCollection, key:String, fieldName:String, results:ArrayCollection):void
		{
			searchNodes(key, fieldName, sourceAC, results);
			for (var i:int=0; i<sourceAC.length; i++)
			{
				var node:Object = sourceAC.getItemAt(i);
				if(node.hasOwnProperty("children") && node.children)
				{
					searchNodesByKey(node.children as ArrayCollection, key, fieldName, results);
				}
			}
			
			//查找子函数
			function searchNodes(key:String, fieldName:String, nodes:ArrayCollection, results:ArrayCollection):void
			{
				for(var i:int=0; i<nodes.length; i++) 
				{
					var node:Object = nodes.getItemAt(i);
					if(node.hasOwnProperty(fieldName) && String(node[fieldName]).indexOf(key) != -1)
					{
						results.addItem(node);
					}
				}
			} 
		}
		
		
		/**
		 * 展开指定树节点的所有上级节点，直至指定节点。
		 * @param node 指定节点数据对象。
		 * @param tree 树对象引用。
		 */
		public static function expandAllParentsOfTreeNode(node:Object, tree:Tree):void
		{
			//获取父级节点
			var parents:ArrayCollection = new ArrayCollection();
			parents = getParentNodes(node, tree.dataProvider as ArrayCollection);
			for each(var parent:Object in parents)
			{
				tree.expandItem(parent, true);
			}
		}
		
		/**
		 * 获取指定节点的所有上级父节点（一直到顶级节点）。
		 * @param node 指定节点数据对象。
		 * @param sourceAC 源树状数据集。
		 * @param 查找到的所有父节点数据对象集合。
		 */
		private static function getParentNodes(node:Object, sourceAC:ArrayCollection):ArrayCollection
		{
			//父节点集合
			var parents:ArrayCollection = new ArrayCollection();
			
			for (var i:int=0; i<sourceAC.length; i++)
			{
				var curNode:Object = sourceAC.getItemAt(i);
				checkParent(curNode, node, parents);
			}
			
			return parents;
			
			//递归子函数
			function checkParent(pNode:Object, node:Object, parents:ArrayCollection):void
			{
				if(pNode.hasOwnProperty("children") && pNode.children)
				{
					for each(var childItem:Object in pNode.children)
					{
						if(childItem.hasOwnProperty("children") && childItem.children)
						{
							checkParent(childItem, node, parents);
						}
						if(ArrayCollection(pNode.children).getItemIndex(node) != -1 || parents.getItemIndex(childItem) != -1)
						{
							parents.addItem(pNode);
							break;
						}
					}
				}
			}
		}
		
		/**
		 * 展开所有树节点。
		 * @param tree 树对象引用。
		 */
		public static function expandAllChildren(tree:Tree):void
		{
			tree.validateNow();
			for each(var item:Object in tree.dataProvider)
			{
				tree.expandChildrenOf(item, true);
			}
		}
		
		
		/**
		 * 构造函数。
		 */
		public function TreeUtils()
		{
		} 
	} 
} 






