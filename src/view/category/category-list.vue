<template>
  <div>
    <!-- 列表页面 -->
    <div class="container" v-if="!showEdit">
      <div class="header">
        <div class="title">分类列表</div>
        <div>
          <el-button @click="showCategoryCreate">添加分类</el-button>
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
    <CategoryCreateOrEdit @confirm="confirmCategory" ref="categoryForm" />
  </div>
</template>

<script>
import category from '@/model/category'
import LinTable from '@/component/base/table/lin-table'
import CategoryCreateOrEdit from './category-create-or-edit.vue'

export default {
  components: {
    LinTable,
    CategoryCreateOrEdit,
  },
  data() {
    return {
      tableColumn: [
        { prop: 'name', label: '分类名称' },
        { prop: 'cover', label: '封面地址' },
        { prop: 'description', label: '分类描述' },
      ],
      tableData: [],
      operate: [],
      showEdit: false,
      editBookID: 1,
      categoryForm: {},
      dialogFormVisible: false,
    }
  },
  async created() {
    this.loading = true
    await this.getCategories()
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
    showCategoryCreate() {
      this.$refs.categoryForm.create()
    },
    async confirmCategory(form) {
      let res = null
      try {
        if (form.id) {
          res = await category.editCategory(form.id, form)
        } else {
          res = await category.createCategory(form)
        }
        if (res.code === 0) {
          this.$message.success(res.message)
          this.getCategories()
          this.$refs.categoryForm.hidden()
        }
      } catch (err) {
        console.error(err)
      }
    },
    async getCategories() {
      try {
        const categories = await category.getCategories()
        this.tableData = categories
      } catch (error) {
        if (error.code === 10020) {
          this.tableData = []
        }
      }
    },
    handleEdit(val) {
      this.$refs.categoryForm.edit(val.row)
    },
    handleDelete(val) {
      this.$confirm('此操作将永久删除该标签, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
      }).then(async () => {
        const res = await category.deleteCategory(val.row.id)
        if (res.code < window.MAX_SUCCESS_CODE) {
          this.getCategories()
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
