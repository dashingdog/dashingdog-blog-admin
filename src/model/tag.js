/* eslint-disable class-methods-use-this */
import _axios, { get, put, _delete } from '@/lin/plugin/axios'

// 我们通过 class 这样的语法糖使模型这个概念更加具象化，其优点：耦合性低、可维护性。
class Tag {
  // constructor() {}

  // 类中的方法可以代表一个用户行为
  async createTag(data) {
    return _axios({
      method: 'post',
      url: 'v1/tag',
      data,
    })
  }

  async getTag(id) {
    const res = await get(`v1/tag/${id}`)
    return res
  }

  async editTag(id, info) {
    const res = await put(`v1/tag/${id}`, info)
    return res
  }

  async deleteTag(id) {
    const res = await _delete(`v1/tag/${id}`)
    return res
  }

  async getTags() {
    return _axios({
      method: 'get',
      url: 'v1/tag/tags',
      handleError: true,
    })
  }
}

export default new Tag()
