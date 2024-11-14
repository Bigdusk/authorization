<script setup lang="ts">

</script>

<template>
    <h1>历史卡密</h1>

    <n-card title="Log" hoverable>
        <n-list hoverable clickable>
            <n-list-item>
                <n-thing title="设备" content-style="margin-top: 10px;">
                    <template #description>
                        <n-space size="small" style="margin-top: 4px">
                            <n-tag :bordered="false" type="info" size="small">
                                游览器指纹
                            </n-tag>
                            <n-tag :bordered="false" type="info" size="small">
                                ip地址
                            </n-tag>
                        </n-space>
                    </template>
                    XXXXXXX.XXXXXXXXX.XXXXXXX
                </n-thing>
            </n-list-item>
            <n-list-item>
                <n-thing title="他在时间门外" content-style="margin-top: 10px;">
                    <template #description>
                        <n-space size="small" style="margin-top: 4px">
                            <n-tag :bordered="false" type="info" size="small">
                                环形公路
                            </n-tag>
                            <n-tag :bordered="false" type="info" size="small">
                                潜水艇司机
                            </n-tag>
                        </n-space>
                    </template>
                    最新的打印机<br>
                    复制着彩色傀儡<br>
                    早上好我的罐头先生<br>
                    让他带你去被工厂敲击
                </n-thing>
            </n-list-item>
        </n-list>
    </n-card>
</template>

<style scoped></style>