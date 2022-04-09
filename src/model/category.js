/* eslint-disable class-methods-use-this */
import _axios, { get, put, _delete } from '@/lin/plugin/axios'

// 我们通过 class 这样的语法糖使模型这个概念更加具象化，其优点：耦合性低、可维护性。
class Category {
  // constructor() {}

  // 类中的方法可以代表一个用户行为
  async createCategory(data) {
    return _axios({
      method: 'post',
      url: 'v1/category',
      data,
    })
  }

  async getCategory(id) {
    const res = await get(`v1/category/${id}`)
    return res
  }

  async editCategory(id, info) {
    const res = await put(`v1/category/${id}`, info)
    return res
  }

  async deleteCategory(id) {
    const res = await _delete(`v1/category/${id}`)
    return res
  }

  async getCategories() {
    return get('v1/category/categories')
  }
}

export default new Category()
