const articeRouter = {
  route: null,
  name: null,
  title: '文章管理',
  type: 'folder', // 类型: folder, tab, view
  icon: 'iconfont icon-tushuguanli',
  filePath: 'view/book/', // 文件路径
  order: null,
  inNav: true,
  children: [
    {
      title: '添加文章',
      type: 'view',
      name: 'ArticleInfo',
      route: '/article/info',
      filePath: 'view/article/article-info.vue',
      inNav: true,
      icon: 'iconfont icon-tushuguanli',
    },
    {
      title: '文章列表',
      type: 'view',
      name: 'ArticleList',
      route: '/article/list',
      filePath: 'view/article/article-list.vue',
      inNav: true,
      icon: 'iconfont icon-tushuguanli',
    },
  ],
}

export default articeRouter
