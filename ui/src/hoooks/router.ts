import router from "@/router";

//后台
export function to_admin() {
    router.push('/admin')
}

//设备管理
export function to_computer_all() {
    router.push('/admin/computer_all')
}

//公告发布
export function to_push_notice() {
    router.push('/admin/push_notice')
}

//所有发布
export function to_list_notice() {
    router.push('/admin/list_notice')
}

//创建cdk
export function to_create_cdk() {
    router.push('/admin/create_cdk')
}

//历史使用cdk记录
export function to_history_cdk() {
    router.push('/admin/history_cdk')
}

//所有cdk
export function to_show_cdk() {
    router.push('/admin/show_cdk')
}

//所有cdk
export function to_login() {
    router.push('/login')
}