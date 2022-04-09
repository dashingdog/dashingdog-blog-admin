<template>
  <el-dialog :title="`${form.id ? '编辑' : '添加'}标签`" :visible.sync="dialogFormVisible">
    <el-form :model="form" ref="form" label-width="120px">
      <el-form-item label="标签名称" prop="name">
        <el-input placeholder="请输入标签名称" v-model="form.name"></el-input>
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
        id: 0,
        name: '',
      },
      dialogFormVisible: false,
    }
  },
  watch: {
    async dialogFormVisible(newValue) {
      if (!newValue) {
        await this.$nextTick()
        this.form = {
          id: 0,
          name: '',
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
