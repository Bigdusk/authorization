<script setup lang="ts">
import type { Users } from '@/entity';
import { to_admin } from '@/hoooks/router';
import { message } from '@/utils/discrete_api';
import { post } from '@/utils/request';
import { ref } from 'vue';

//登录表单属性
const user = ref<Users>({
  user_id: 0,
  username: '',
  password: '',
  permissions: 0
})

const login = () => {
  post('/login', user.value).then(r => {
    if(r) {
      message.success('登录成功')
      localStorage.setItem('token', r as string)
      to_admin()
    }else{
      message.warning('登录失败')
    }
  })
}
</script>

<template>
  <n-layout embedded>
    <n-flex justify="center">

      <n-card title="Login" hoverable>

        <n-form ref="formRef" :model="user">
          <n-form-item label="账号" path="user.username">
            <n-input v-model:value="user.username" placeholder="username" />
          </n-form-item>

          <n-form-item label="密码" path="user.password">
            <n-input v-model:value="user.password" placeholder="password" />
          </n-form-item>

          <n-button @click="login" type="primary" block secondary strong>
            登录
          </n-button>
        </n-form>

      </n-card>
    </n-flex>
  </n-layout>

</template>

<style scoped>
.n-card {
  max-width: 400px;
  max-height: 300px;
  margin-top: 300px;
}

.n-flex {
  width: 100%;
  height: 100vh;
}
</style>