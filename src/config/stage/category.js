const categoryRouter = {
  route: null,
  name: null,
  title: '分类/标签管理',
  type: 'folder', // 类型: folder, tab, view
  icon: 'iconfont icon-tushuguanli',
  filePath: 'view/book/', // 文件路径
  inNav: true,
  order: 3,
  children: [
    {
      title: '分类管理',
      type: 'view',
      name: 'CategoryList',
      route: '/category/list',
      filePath: 'view/category/category-list.vue',
      inNav: true,
      icon: 'iconfont icon-tushuguanli',
    },
    {
      title: '标签管理',
      type: 'view',
      name: 'TagList',
      route: '/tag/list',
      filePath: 'view/tag/tag-list.vue',
      inNav: true,
      icon: 'iconfont icon-tushuguanli',
    },
  ],
}

export default categoryRouter
