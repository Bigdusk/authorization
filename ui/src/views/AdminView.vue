<script setup lang="ts">
import LeftNavComponent from '@/components/admin/nav/LeftNavComponent.vue';


</script>

<template>
      <n-layout style="height: 100vh">
    <n-layout-header style="height: 64px; padding: 24px" bordered>
      QQ_HLEP_ADMIN
    </n-layout-header>
    <n-layout position="absolute" style="top: 64px; bottom: 64px" has-sider>
      <n-layout-sider
        content-style="padding: 24px;"
        :native-scrollbar="false"
        bordered
      >
        
      <LeftNavComponent/>

      </n-layout-sider>
      <n-layout content-style="padding: 24px;" :native-scrollbar="false">
        
        <RouterView/>

      </n-layout>
    </n-layout>
    <n-layout-footer
      position="absolute"
      style="height: 64px; padding: 24px"
      bordered
    >
      当前版本 0.0.1
    </n-layout-footer>
  </n-layout>
</template>

<style scoped>
</style>