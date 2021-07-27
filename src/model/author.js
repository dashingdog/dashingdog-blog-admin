import { get } from '@/lin/plugin/axios'

class Author {
  getAuthors() {
    return get('/v1/blog/author/authors')
  }
}

export default new Author()
