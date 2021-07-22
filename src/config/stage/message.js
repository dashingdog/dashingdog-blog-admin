const messageRouter = {
  route: null,
  name: null,
  title: '留言管理',
  type: 'folder', // 类型: folder, tab, view
  icon: 'iconfont icon-tushuguanli',
  filePath: 'view/book/', // 文件路径
  order: null,
  inNav: true,
  children: [
    {
      title: '分类管理',
      type: 'view',
      name: 'BookCreate',
      route: '/book/add',
      filePath: 'view/book/book-create.vue',
      inNav: true,
      icon: 'iconfont icon-tushuguanli',
    },
    {
      title: '标签管理',
      type: 'view',
      name: 'BookCreate',
      route: '/book/list',
      filePath: 'view/book/book-list.vue',
      inNav: true,
      icon: 'iconfont icon-tushuguanli',
    },
  ],
}

export default messageRouter
