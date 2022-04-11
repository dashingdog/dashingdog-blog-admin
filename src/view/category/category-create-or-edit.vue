<template>
  <el-dialog :title="`${form.id ? '编辑' : '新建'}分类`" v-model="dialogFormVisible">
    <el-form :model="form" ref="form" label-width="120px" :rules="rules">
      <el-form-item label="分类名称" prop="name">
        <el-input placeholder="请输入分类名称" v-model="form.name"></el-input>
      </el-form-item>
      <el-form-item label="分类封面地址" prop="cover">
        <el-input placeholder="请输入分类封面地址" v-model="form.cover"></el-input>
        <el-upload action="" :show-file-list="false" :multiple="false" :auto-upload="false" :on-change="uploadImage">
          <el-button size="small" type="primary">点击上传</el-button>
        </el-upload>
      </el-form-item>
      <el-form-item label="分类描述" prop="description">
        <el-input placeholder="请输入分类描述" v-model="form.description"></el-input>
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button @click="hidden">取 消</el-button>
      <el-button type="primary" @click="confirm">确 定</el-button>
    </div>
  </el-dialog>
</template>

<script>
export default {
  data() {
    return {
      form: {
        id: null,
        name: '',
        cover: '',
        description: '',
      },
      rules: {
        name: [{ required: true, message: '请填写分类名称', trigger: 'blur' }],
        description: [{ required: true, message: '请填写分类描述', trigger: 'blur' }],
      },
      dialogFormVisible: false,
    }
  },
  watch: {
    async dialogFormVisible(newValue) {
      if (!newValue) {
        await this.$nextTick()
        this.form = {
          id: null,
          name: '',
          cover: '',
          description: '',
        }
      }
    },
  },
  methods: {
    async uploadImage(file) {
      try {
        const res = await this.$axios({
          method: 'post',
          url: '/cms/file/tencentUpload',
          data: {
            file: file.raw,
          },
        })
        this.form.cover = res[0].path
      } catch (error) {
        console.log(error)
      }
    },
    edit(form) {
      this.form = { ...form }
      this.dialogFormVisible = true
    },
    create() {
      this.dialogFormVisible = true
    },
    async confirm() {
      try {
        await this.$refs.form.validate()
        this.$emit('confirm', this.form)
      } catch (error) {
        console.log(error)
      }
    },
    hidden() {
      this.dialogFormVisible = false
    },
  },
}
</script>

<style></style>
