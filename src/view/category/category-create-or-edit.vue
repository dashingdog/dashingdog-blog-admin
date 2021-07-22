<template>
  <el-dialog :title="`${form.id ? '编辑' : '新建'}分类`" :visible.sync="dialogFormVisible">
    <el-form :model="form" ref="form" label-width="120px">
      <el-form-item label="分类名称" prop="name">
        <el-input placeholder="请输入分类名称" v-model="form.name"></el-input>
      </el-form-item>
      <el-form-item label="分类封面地址" prop="cover">
        <el-input placeholder="请输入分类封面地址" v-model="form.cover"></el-input>
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
    edit(form) {
      this.form = Object.assign({}, form)
      this.dialogFormVisible = true
    },
    create() {
      this.dialogFormVisible = true
    },
    confirm() {
      this.$emit('confirm', this.form)
    },
    hidden() {
      this.dialogFormVisible = false
    },
  },
}
</script>

<style></style>
