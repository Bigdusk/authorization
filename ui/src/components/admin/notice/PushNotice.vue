<script setup lang="ts">
import { ref } from 'vue';
import { MdEditor } from 'md-editor-v3';
import 'md-editor-v3/lib/style.css';
import type { Notice } from '@/entity';
import { post } from '@/utils/request';
import { message } from '@/utils/discrete_api';
import { to_list_notice } from '@/hoooks/router';

const notice = ref<Notice>({
    announcement_id: 0,
    title: '',
    content: 'Hello QQ_HELP',
    user_id: 0,
    publish_date: null,
    expiration_date: null,
    is_active: 0
})

//创建文章
function notice_save() {
    post('/notice/create', notice.value).then(r => {
        if(r) {
            message.success('发布成功')
            to_list_notice()
        }
    })
}
</script>

<template>
    <h1>公告发布</h1>
    <n-card title="编写" hoverable>

        <n-input-group>
            <n-button type="primary">
                标题
            </n-button>
            <n-input v-model:value="notice.title" :style="{ width: '50%' }" placeholder="文章标题"/>
        </n-input-group>

        <MdEditor v-model="notice.content" @onSave="notice_save"/>
    </n-card>
</template>

<style scoped></style>