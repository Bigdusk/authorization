<script setup lang="ts">
import { onMounted, ref } from 'vue'
import type { DataTableColumns, DataTableInst } from 'naive-ui'
import type { RowData } from 'naive-ui/es/data-table/src/interface';
import type { CardKeys } from '@/entity';
import { get } from '@/utils/request';

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
    },
    {
        title: '状态',
        key: 'is_active',
        filterOptions: [
            {
                label: '已使用',
                value: 'true'
            },
            {
                label: '未使用',
                value: 'false'
            }
        ],
        filter: (value: string | number, row: object) => {
            return !!~((row as CardKeys).is_active as string).indexOf(value as string)
        }
    }
]

const data = ref<CardKeys[]>([])

const tableRef = ref<DataTableInst>()
const exportSorterAndFilterCsv = () =>
    tableRef.value?.downloadCsv({
        fileName: 'cdk',
        keepOriginalData: false
    })

function query_all_card_key() {
    spin_show.value = true
    get<CardKeys[]>('/card_key/query/all')
        .then(r => {
            r.forEach(element => {
                if (element.is_active === 0) {
                    element.is_active = 'false'
                }

                if (element.is_active === 1) {
                    element.is_active = 'true'
                }
            });
            data.value = r
            spin_show.value = false
        })
}

onMounted(() => {
    query_all_card_key()
})
const spin_show = ref(false)
</script>

<template>
    <h1>所有卡密</h1>
    <n-spin :show="spin_show">
        <n-card title="列表" hoverable>

            <n-space>
                <n-button @click="exportSorterAndFilterCsv">
                    导出
                </n-button>
            </n-space>
            <n-data-table ref="tableRef" :columns="columns" :data="data" :bordered="false" />

        </n-card>
    </n-spin>

</template>

<style scoped></style>