<script setup lang="ts">
defineProps<{
    inputType: string;
    placeholder: string;
}>();
const model = defineModel<string | number | null>();
</script>

<template>
    <input
        class="focus:outline-1 outline-indigo-500 p-2 rounded-xl border border-slate-200"
        :type="inputType"
        :placeholder="placeholder"
        v-model="model"
    />
</template>
