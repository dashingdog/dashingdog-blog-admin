import { get } from '@/lin/plugin/axios'

class Author {
  getAuthors() {
    return get('/cms/admin/users')
  }
}

export default new Author()
