<script setup lang="ts">
import { h, onMounted, ref } from 'vue'
import { NButton } from 'naive-ui'
import type { DataTableColumns } from 'naive-ui'
import { message } from '@/utils/discrete_api';
import type { Notice } from '@/entity';
import { get } from '@/utils/request';

function createColumns({
    play
}: {
    play: (row: Notice) => void
}): DataTableColumns<Notice> {
    return [
        {
            title: '文章名称',
            key: 'title'
        },
        {
            title: '发布时间',
            key: 'publish_date'
        },
        {
            title: '作者',
            key: 'user_id'
        },
        {
            title: '操作',
            key: 'actions',
            render(row) {
                return h(
                    NButton,
                    {
                        strong: true,
                        tertiary: true,
                        size: 'small',
                        onClick: () => play(row)
                    },
                    { default: () => '删除' }
                )
            }
        }
    ]
}

const data = ref<Notice[]>([])

const columns = createColumns({
    play(row: Notice) {
        delete_notice(row.announcement_id)
    }
})

const pagination = false as const

function notice_query_all() {
    get<Notice[]>('/notice/query/all').then(r => {
        data.value = r
    })
}

function delete_notice(id: number) {
    get('/notice/delete/' + id).then(r => {
        if(r) {
            message.success('删除成功')
            notice_query_all()
        }else{
            message.warning('删除失败')
        }
    })
}

onMounted(() => {
    notice_query_all()
})
</script>

<template>
    <h1>公告列表</h1>

    <n-card title="列表" hoverable>
        <n-data-table :columns="columns" :data="data" :pagination="pagination" :bordered="false" />

    </n-card>
</template>

<style scoped></style>