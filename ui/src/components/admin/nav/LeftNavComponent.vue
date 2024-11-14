<script setup lang="ts">
import { to_admin, to_computer_all, to_create_cdk, to_history_cdk, to_list_notice, to_push_notice, to_show_cdk } from '@/hoooks/router';
import { message } from '@/utils/discrete_api';
import {
  BagOutline as BagOutlineIcon,
  FishOutline as FishIcon,
  PawOutline as PawIcon
} from '@vicons/ionicons5'
import { NIcon, type MenuOption } from 'naive-ui';
import { h, type Component } from 'vue';

function renderIcon(icon: Component) {
  return () => h(NIcon, null, { default: () => h(icon) })
}
function handleUpdateValue(key: string, item: MenuOption) {
  if(key === 'computer_all') {
    to_computer_all()
  }
  if(key === 'push_notice') {
    to_push_notice()
  }
  if(key === 'create_cdk') {
    to_create_cdk()
  }
  if(key === 'show_cdk') {
    to_show_cdk()
  }
  if(key === 'history_cdk') {
    to_history_cdk()
  }
  if(key === 'list_notice') {
    to_list_notice()
  }
}
const defaultExpandedKeys = ['fish', 'braise']
const menuOptions: MenuOption[] = [
  {
    label: '设备',
    key: 'computer',
    icon: renderIcon(FishIcon),
    children: [
      {
        label: '所有设备',
        key: 'computer_all'
      }
    ]
  },
  {
    label: '公告',
    key: 'notice',
    icon: renderIcon(PawIcon),
    children: [
      {
        label: '发布公告',
        key: 'push_notice'
      },
      {
        label: '所有公告',
        key: 'list_notice'
      }
    ]
  },
  {
    label: '卡密/CDK',
    key: 'cdk',
    icon: renderIcon(BagOutlineIcon),
    children: [
      {
        label: '生成',
        key: 'create_cdk'
      },
      {
        label: '卡密管理',
        key: 'show_cdk'
      },
      {
        label: '使用记录',
        key: 'history_cdk'
      }
    ]
  }
]


</script>

<template>
    <n-flex vertical>

        <n-button @click="to_admin" type="primary">
            首頁
        </n-button>

        <n-menu
            :options="menuOptions"
            @update:value="handleUpdateValue"
            :default-expanded-keys="defaultExpandedKeys"
            accordion
        />

    </n-flex>
</template>

<style scoped></style>