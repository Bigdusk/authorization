<script setup lang="ts">
import { RouterView } from 'vue-router'
import { darkTheme } from 'naive-ui'
</script>

<template>
  <n-config-provider :theme-overrides="{ common: { fontWeightStrong: '600' } }">
    <n-config-provider :theme="darkTheme">
      <RouterView />
    </n-config-provider>
  </n-config-provider>
</template>

<style scoped>

</style>
