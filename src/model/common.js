import { post } from '@/lin/plugin/axios'

class Common {
  tencentUpload(data) {
    return post('/cms/file/tencentUpload', data)
  }

  localUpload(data) {
    return post('/cms/file', data)
  }
}

export default new Common()
