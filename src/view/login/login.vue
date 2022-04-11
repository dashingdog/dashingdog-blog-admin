<template>
  <div class="login">
    <div class="form-box" v-loading="loading" element-loading-background="rgba(0, 0, 0, 0)">
      <div class="title"><h1 title="Lin">Blog Admin</h1></div>
      <form class="login-form" autocomplete="off" @submit.prevent="throttleLogin()">
        <div class="form-item nickname">
          <span class="icon account-icon"></span>
          <label for="username">
            <input type="text" v-model="account.username" autocomplete="off" placeholder="请填写用户名" />
          </label>
        </div>
        <div class="form-item password">
          <span class="icon secret-icon"></span>
          <label for="password">
            <input type="password" v-model="account.password" autocomplete="off" placeholder="请填写用户登录密码" />
          </label>
        </div>
        <div class="form-item password" v-if="captchaImage">
          <img class="captcha" alt="" :src="captchaImage" />
          <label for="captcha">
            <input type="password" v-model="account.captcha" autocomplete="off" placeholder="请填写验证码" />
          </label>
        </div>
        <div class="submit-wrap">
          <button class="submit-btn" type="submit">登录</button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { reactive, ref, onMounted, getCurrentInstance } from 'vue'
import { useStore } from 'vuex'
import { useRouter } from 'vue-router'
import axios from 'lin/plugin/axios'
import UserModel from '@/lin/model/user'
import Utils from '@/lin/util/util'
import Config from '@/config'

export default {
  setup() {
    let tag = ''
    const wait = 2000 // 2000ms之内不能重复发起请求
    const loading = ref(false)
    const captchaImage = ref('')
    const store = useStore()
    const router = useRouter()
    const throttleLogin = ref(null)
    const { ctx } = getCurrentInstance()

    const account = reactive({
      username: '',
      password: '',
      captcha: '',
    })

    /**
     * 根据账号密码登录，拿到 token 并储存
     */
    const login = async () => {
      const { username, password, captcha } = account
      try {
        loading.value = true
        await UserModel.getToken(username, password, captcha, tag)
        await getInformation()
        loading.value = false
        router.push(Config.defaultRoute)
        ctx.$message({
          message: '登录成功',
          type: 'success',
        })
      } catch (e) {
        loading.value = false
      }
    }

    const getCaptcha = async () => {
      axios({
        method: 'POST',
        url: 'cms/user/captcha',
      }).then(result => {
        ;({ tag } = result)
        captchaImage.value = result.image
      })
    }

    /**
     * 获取并更新当前管理员信息
     */
    const getInformation = async () => {
      try {
        // 尝试获取当前用户信息
        const user = await UserModel.getPermissions()
        store.dispatch('setUserAndState', user)
        store.commit('SET_USER_PERMISSIONS', user.permissions)
      } catch (e) {
        console.error(e)
      }
    }

    /**
     * 节流登录
     */
    onMounted(() => {
      getCaptcha()
      throttleLogin.value = Utils.throttle(login, wait)
    })

    return {
      account,
      loading,
      captchaImage,
      throttleLogin,
    }
  },
}
</script>

<style lang="scss">
.login {
  width: 100%;
  height: 100%;
  background-size: auto;
  background: #1b2c5f url('../../assets/image/login/login-ba.jpg') no-repeat center center;

  .form-box {
    position: fixed;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    width: 445px;
    border-radius: 12px;
    padding-bottom: 30px;
    background: rgba(0, 0, 0, 0.5);
    .title {
      height: 80px;
      font-size: 30px;
      line-height: 80px;
      margin-bottom: 6%;
      h1 {
        box-sizing: border-box;
        text-align: center;
        color: #ffffff;
      }
    }

    .login-form {
      width: 100%;

      .form-item {
        position: relative;
        height: 40px;
        box-sizing: border-box;
        padding-bottom: 13px;
        margin-bottom: 34px;
        margin: 0 40px 20px;
        input {
          width: 100%;
          height: 32px;
          line-height: 32px;
          background: transparent;
          color: #c4c9d2;
          font-size: 14px;
          padding: 20px;
          box-sizing: border-box;
          border: 1px solid #d6d6d6;
          border-radius: 6px;
        }

        .captcha {
          position: absolute;
          width: 80px;
          right: 30px;
          top: -22px;
        }
      }
      .submit-wrap {
        width: 100%;
        padding: 0 40px;
        box-sizing: border-box;
        .submit-btn {
          height: 50px;
          line-height: 50px;
          color: #ffffff;
          font-size: 16px;
          text-align: center;
          border: none;
          cursor: pointer;
          border-radius: 8px;
          width: 100%;
          background: #1e88a8;
        }
      }
    }
  }
}
</style>
