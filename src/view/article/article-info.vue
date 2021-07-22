<template>
  <div class="container">
    <div class="view-title">
      {{ infoType === 'add' ? '添加文章' : '编辑文章' }}
      <span v-if="infoType === 'edit'" class="back" @click="$emit('handleBack', false)">
        <i class="el-icon-back"></i>
        返回
      </span>
    </div>
    <div class="form-wrapper">
      <el-row>
        <el-col :lg="23" :md="23" :sm="24" :xs="24">
          <el-form
            :model="form"
            ref="form"
            label-position="top"
            label-width="100px"
            @submit.native.prevent
            status-icon
            v-loading="loading"
            :rules="rules"
          >
            <el-form-item label="标题" prop="title">
              <el-input v-model="form.title" size="medium" placeholder="请输入标题"></el-input>
            </el-form-item>
            <el-form-item label="封面" prop="cover">
              <el-input v-model="form.cover" size="medium" placeholder="请输入封面地址"></el-input>
              <el-upload :action="uploadUrl">
                <el-button size="small" type="primary">点击上传</el-button>
              </el-upload>
            </el-form-item>
            <el-form-item label="描述" prop="description">
              <el-input
                type="textarea"
                v-model="form.description"
                :autosize="{ minRows: 5, maxRows: 10 }"
                placeholder="请输入描述"
                maxlength="140"
                show-word-limit
              ></el-input>
            </el-form-item>
            <el-form-item label="作者" prop="authors">
              <el-select v-model="form.authors" multiple filterable allow-create size="medium" placeholder="请选择作者">
                <el-option
                  v-for="author in authors"
                  :key="author.id"
                  :label="author.username"
                  :value="author.id"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="分类" prop="categoryId">
              <el-select v-model="form.categoryId" filterable size="medium" placeholder="请选择分类">
                <el-option
                  v-for="category in categories"
                  :key="category.id"
                  :value="category.id"
                  :label="category.name"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="标签" prop="tags">
              <el-select v-model="form.tags" multiple filterable allow-create size="medium" placeholder="请选择标签">
                <el-option v-for="tag in tags" :key="tag.id" :label="tag.name" :value="tag.id"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="时间" prop="createdDate">
              <el-date-picker
                v-model="form.createdDate"
                size="medium"
                type="datetime"
                :editable="false"
              ></el-date-picker>
            </el-form-item>
            <el-form-item label="公开" prop="public">
              <el-radio-group v-model="form.public">
                <el-radio :label="1">公开</el-radio>
                <el-radio :label="2">私密</el-radio>
              </el-radio-group>
            </el-form-item>
            <el-form-item label="发布" prop="status">
              <el-radio-group v-model="form.status">
                <el-radio :label="1">发布</el-radio>
                <el-radio :label="2">草稿</el-radio>
              </el-radio-group>
            </el-form-item>
            <el-form-item label="精选" prop="star">
              <el-radio-group v-model="form.star">
                <el-radio :label="1">非精选</el-radio>
                <el-radio :label="2">精选</el-radio>
              </el-radio-group>
            </el-form-item>
            <!-- <el-form-item
              label="内容"
              prop="content"
            >
              <el-input
                type="textarea"
                v-model="form.content"
                :autosize="{ minRows: 10, maxRows: 14 }"
                placeholder="请输入文章内容"
              ></el-input>
            </el-form-item> -->
            <el-form-item label="文章内容" prop="content">
              <mavon-editor @imgAdd="$imgAdd" :autofocus="false" ref="md" v-model="form.content" />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click.stop="submitForm('form')">保 存</el-button>
              <el-button type="primary" @click="preview">预 览</el-button>
            </el-form-item>
          </el-form>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script>
import category from '@/model/category'
import tag from '@/model/tag'
import author from '@/model/author'
import article from '@/model/article'
import Config from '@/config/index'
// import common from '@/model/common'

export default {
  props: {
    infoType: {
      type: String,
      default: 'add',
    },

    info: {
      type: Object,
      default: () => {},
    },

    infoAuthors: {
      type: Array,
      default: () => [],
    },

    infoCategories: {
      type: Array,
      default: () => [],
    },

    infoTags: {
      type: Array,
      default: () => [],
    },
  },

  data() {
    return {
      loading: false,
      uploadUrl: `${Config.baseUrl}/v1/file`,
      form: {
        title: '',
        authors: [],
        description: '',
        createdDate: new Date(),
        cover: '',
        content: '',
        categoryId: '',
        tags: [],
        public: 1,
        status: 1,
        star: 1,
      },
      authors: [],
      categories: [],
      tags: [],
      rules: {
        title: [{ trigger: 'blur', message: '请输入标题', required: true }],
        authors: [{ trigger: 'change', message: '请选择作者', required: true }],
        description: [{ trigger: 'blur', message: '请输入描述', required: true }],
        createdDate: [{ trigger: 'blur', message: '请选择创建时间', required: true }],
        cover: [{ type: 'url', trigger: 'blur', message: '请输入正确的封面地址' }],
        content: [{ trigger: 'blur', message: '请输入文章内容', required: true }],
        categoryId: [{ trigger: 'change', message: '请选择分类', required: true }],
        tags: [{ type: 'array', message: '请选择标签', required: true }],
        public: [{ type: 'number', message: '请选择公开或私密', required: true }],
        status: [{ type: 'number', message: '请选择发布或草稿', required: true }],
        star: [{ type: 'number', message: '请选择是否为精选', required: true }],
      },
    }
  },

  methods: {
    async submitForm(formName) {
      this.$refs[formName].validate(async valid => {
        if (valid) {
          if (this.infoType === 'add') {
            // 新增文章
            try {
              this.loadingn = true
              const res = await article.createArticle(this.form)
              if (res.code === 0) {
                this.loading = false
                this.$message.success(`${res.message}`)
                this.resetForm(formName)
              } else {
                this.loading = false
                this.$message.error(`${res.message}`)
              }
            } catch (e) {
              this.loading = false
              // eslint-disable-next-line no-console
              console.log(e)
            }
          } else {
            // 编辑文章
            if (this.isEquel(this.info, this.form)) {
              this.$emit('handleBack', false)
              return
            }
            try {
              // eslint-disable-next-line no-console
              const res = await article.updateArticle(this.form)
              if (res.code === 0) {
                this.$message.success(`${res.message}`)
                this.$emit('handleBack', true)
              } else {
                this.$message.error(`${res.message}`)
              }
            } catch (e) {
              // eslint-disable-next-line no-console
              console.log(e)
            }
          }
        }
      })
    },

    // 判断是否有更改字段
    isEquel(source, target) {
      let isEquel = true
      for (const key in source) {
        if (Array.isArray(source[key])) {
          if (source[key].join('') !== target[key].join('')) {
            isEquel = false
          }
        } else if (source[key] !== target[key]) {
          isEquel = false
        }
      }
      return isEquel
    },

    // 图片上传
    async $imgAdd(pos, $file) {
      console.log(pos)
      console.log($file)
      // const file = new File([$file],`dashingdog-avatar.jpg`,{
      //   type: 'image/jpeg',
      // })
      // console.log(file)
      // const file = new File([$file], `aaa-avatar.jpg`, {
      //   type: 'image/jpeg',
      // })
      // const file = new File([$file], `avatar.jpg`, {
      //   type: 'image/jpeg',
      // })
      const result = await this.$axios({
        method: 'post',
        url: '/v1/file/cors',
        data: {
          file: $file,
        },
        headers: { 'Content-Type': 'multipart/form-data' },
      })
      console.log(result)
      // const url = "http://cdn.dashingdog.cn/blog/dashingdog-avatar.jpg"
      // $vm.$img2Url(pos, url);
      //
      // this.$refs.md.$imglst2Url([[pos, url]])
    },

    resetForm(formName) {
      this.$refs[formName].resetFields()
    },

    preview() {},

    async getCategories() {
      try {
        this.categories = await category.getCategories()
      } catch (e) {
        // eslint-disable-next-line no-console
        console.log(e)
      }
    },

    async getTags() {
      try {
        this.tags = await tag.getTags()
      } catch (e) {
        // eslint-disable-next-line no-console
        console.log(e)
      }
    },

    async getAuthors() {
      try {
        const { items } = await author.getAuthors()
        this.authors = items
      } catch (e) {
        // eslint-disable-next-line no-console
        console.log(e)
      }
    },

    // 过滤全部
    fitlerAll(arr) {
      const result = [].concat(arr)
      result.shift()
      return result
    },
  },

  created() {
    if (this.infoType === 'add') {
      // 添加文章
      this.getCategories()
      this.getTags()
      this.getAuthors()
    } else {
      // 编辑文章
      this.categories = this.fitlerAll(this.infoCategories)
      this.tags = this.fitlerAll(this.infoTags)
      this.authors = this.fitlerAll(this.infoAuthors)
      this.form = JSON.parse(JSON.stringify(this.info))
    }
  },
}
</script>

<style lang="scss" scoped>
.container {
  padding: 0 30px;
  .view-title {
    height: 59px;
    line-height: 59px;
    color: #3963bc;
    font-size: 16px;
    font-weight: 500;
  }
}
</style>
