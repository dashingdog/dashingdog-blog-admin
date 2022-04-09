<template>
  <div>
    <!-- 列表页面 -->
    <div class="container" v-if="!showEdit">
      <div class="header">
        <div class="title">标签列表</div>
        <div>
          <el-button @click="showTagCreate">添加标签</el-button>
        </div>
      </div>
      <!-- 表格 -->
      <lin-table
        :tableColumn="tableColumn"
        :tableData="tableData"
        :operate="operate"
        @handleEdit="handleEdit"
        @handleDelete="handleDelete"
        @row-click="rowClick"
        v-loading="loading"
      ></lin-table>
    </div>
    <TagCreateOrEdit @confirm="confirmTag" ref="tagForm" />
  </div>
</template>

<script>
import tag from '@/model/tag'
import LinTable from '@/component/base/table/lin-table'
import TagCreateOrEdit from './tag-create-or-edit.vue'

export default {
  components: {
    LinTable,
    TagCreateOrEdit,
  },
  data() {
    return {
      tableColumn: [{ prop: 'name', label: '分类名称' }],
      tableData: [],
      operate: [],
      showEdit: false,
      editBookID: 1,
      tagForm: {},
      dialogFormVisible: false,
    }
  },
  async created() {
    this.loading = true
    await this.getTags()
    this.operate = [
      { name: '编辑', func: 'handleEdit', type: 'primary' },
      {
        name: '删除',
        func: 'handleDelete',
        type: 'danger',
        permission: '删除图书',
      },
    ]
    this.loading = false
  },
  methods: {
    showTagCreate() {
      this.$refs.tagForm.create()
    },
    async confirmTag(form) {
      let res = null
      try {
        if (form.id) {
          res = await tag.editTag(form.id, form)
        } else {
          res = await tag.createTag(form)
        }
        if (res.code === 0) {
          this.$message.success(res.message)
          this.getTags()
          this.$refs.tagForm.hidden()
        }
      } catch (err) {
        console.error(err)
      }
    },
    async getTags() {
      try {
        const tags = await tag.getTags()
        this.tableData = tags
      } catch (error) {
        if (error.code === 10020) {
          this.tableData = []
        }
      }
    },
    handleEdit(val) {
      this.$refs.tagForm.edit(val.row)
    },
    handleDelete(val) {
      this.$confirm('此操作将永久删除该标签, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
      }).then(async () => {
        const res = await tag.deleteTag(val.row.id)
        if (res.code < window.MAX_SUCCESS_CODE) {
          this.getTags()
          this.$message({
            type: 'success',
            message: `${res.message}`,
          })
        }
      })
    },
    rowClick() {},
  },
}
</script>

<style lang="scss" scoped>
.container {
  padding: 0 30px;

  .header {
    display: flex;
    justify-content: space-between;
    align-items: center;

    .title {
      height: 59px;
      line-height: 59px;
      color: $parent-title-color;
      font-size: 16px;
      font-weight: 500;
    }
  }

  .pagination {
    display: flex;
    justify-content: flex-end;
    margin: 20px;
  }
}
</style>
