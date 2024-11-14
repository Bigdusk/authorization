<script setup lang="ts">
import { message } from '@/utils/discrete_api';
import { NButton } from 'naive-ui';
import { h } from 'vue'

const columns = [
  {
    title: 'Name',
    key: 'name',
    defaultSortOrder: 'ascend',
    sorter: 'default'
  },
  {
    title: 'Age',
    key: 'age',
    sorter: (row1: { age: number; }, row2: { age: number; }) => row1.age - row2.age
  },
  {
    title: 'Address',
    key: 'address',
    defaultFilterOptionValues: ['London', 'New York'],
    filterOptions: [
      {
        label: 'London',
        value: 'London'
      },
      {
        label: 'New York',
        value: 'New York'
      }
    ],
    filter(value: any, row: { address: string | any[]; }) {
      return ~row.address.indexOf(value)
    }
  },
  {
      title: 'Action',
      key: 'actions',
      render(row: any) {
        return h(
          NButton,
          {
            strong: true,
            tertiary: true,
            size: 'small',
            onClick: () => play(row)
          },
          { default: () => 'Play' }
        )
      }
    }
]

function play(row: any) {
          message.info(`Play ${row.name}`)
        }

const data = [
  {
    key: 0,
    name: 'John Brown',
    age: 32,
    address: 'New York No. 1 Lake Park'
  },
  {
    key: 1,
    name: 'Jim Green',
    age: 42,
    address: 'London No. 1 Lake Park'
  },
  {
    key: 2,
    name: 'Joe Black',
    age: 32,
    address: 'Sidney No. 1 Lake Park'
  },
  {
    key: 3,
    name: 'Jim Red',
    age: 32,
    address: 'London No. 2 Lake Park'
  }
]
const pagination = { pageSize: 5 }
</script>

<template>
    <h1>所有管理设备</h1>

    <n-card hoverable>
        <n-data-table
      ref="table"
      :columns="columns"
      :data="data"
      :pagination="pagination"
    />
    </n-card>
    
</template>

<style scoped>

</style>