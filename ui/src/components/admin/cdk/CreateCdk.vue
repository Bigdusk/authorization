<script setup lang="ts">
import { ref } from 'vue'
import type { DataTableColumns, DataTableInst } from 'naive-ui'
import type { RowData } from 'naive-ui/es/data-table/src/interface';
import type { CardKeyInfo, CardKeys } from '@/entity';
import { post } from '@/utils/request';

const columns: DataTableColumns<RowData> = [
  {
    title: '名称',
    key: 'type',
    sorter: 'default'
  },
  {
    title: '天数',
    key: 'value'
  },
  {
    title: '卡密',
    key: 'card_key'
  }
]

const data = ref<CardKeys[]>([])
const tableRef = ref<DataTableInst>()
const exportSorterAndFilterCsv = () =>
  tableRef.value?.downloadCsv({
    fileName: 'cdk',
    keepOriginalData: false
  })

const card_key_info = ref<CardKeyInfo>({
  name: '',
  day: '',
  num: 0
})

async function create_card() {
  spin_show.value = true
  post<string[]>('/card_keys_insert', card_key_info.value).then(r => {
    data.value.length = 0
    r.forEach(element => {
      data.value.push({
        type: card_key_info.value.name,
        value: card_key_info.value.day,
        card_key: element
      })
    });
    spin_show.value = false
  })
}

const spin_show = ref(false)
</script>

<template>
  <h1>创建卡密</h1>
  <n-flex>

    <n-spin :show="spin_show">




      <n-card title="生成" hoverable>

        <n-form ref="formRef" model="user">
          {{ card_key_info }}
          <n-form-item label="卡密名称" path="user.username">
            <n-input v-model:value="card_key_info.name" type="text" placeholder="名称" />
          </n-form-item>

          <n-form-item label="有效时间" path="user.username">
            <n-input v-model:value="card_key_info.day" type="text" placeholder="按天数算" />
          </n-form-item>

          <n-form-item label="生成数量" path="user.username">
            <n-input-number v-model:value="card_key_info.num" clearable :precision="0" placeholder="数量" />
          </n-form-item>

          <n-form-item>
            <n-button @click="create_card" type="primary">
              生成
            </n-button>
          </n-form-item>
        </n-form>

      </n-card>
      <template #description>
        等待后端数据返回
      </template>
    </n-spin>
    <n-card title="展示" hoverable>

      <n-space vertical :size="12">
        <n-space>
          <n-button @click="exportSorterAndFilterCsv">
            导出 CSV（展示的数据）
          </n-button>
        </n-space>
        <n-scrollbar style="max-height: 620px">
          <n-data-table ref="tableRef" :columns="columns" :data="data" :bordered="false" />
        </n-scrollbar>
      </n-space>

    </n-card>
  </n-flex>


</template>

<style scoped>
.n-card {
  width: 700px;
}
</style>