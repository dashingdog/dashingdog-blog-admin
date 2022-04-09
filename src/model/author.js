/*
 * @Description: 
 * @Date: 2022-04-09 10:57:24
 */
import { get } from '@/lin/plugin/axios'

class Author {
  getAuthors() {
    return get('/v1/blog/author/authors')
  }
}

export default new Author()
