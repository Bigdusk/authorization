<script setup lang="ts">
import { ref } from 'vue';
import { MdEditor } from 'md-editor-v3';
import 'md-editor-v3/lib/style.css';

const text = ref('Hello Editor!');
</script>

<template>
    <h1>公告发布</h1>

    <n-card title="编写" hoverable>

        <n-input-group>
            <n-button type="primary">
                标题
            </n-button>
            <n-input :style="{ width: '50%' }" placeholder="文章标题"/>
        </n-input-group>

        <MdEditor v-model="text" />
    </n-card>
</template>

<style scoped></style>