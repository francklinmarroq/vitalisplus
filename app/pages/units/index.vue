<script setup lang="ts">
import type { TableColumn } from '@nuxt/ui'
import type { Unit } from '~/types/unit'

const { units, loadingFetch, loadingSave, fetchAll, saveUnit } = useUnits()
const isSaveModalOpen = ref(false)

const columns: TableColumn<Unit>[] = [
  { accessorKey: 'unit', header: 'Name' },
  { accessorKey: 'actions', header: 'Actions', cell: ({ row }) => {
    // Se renderiza via slot
  } },
]

const unitName = ref('')

async function handleSave() {
  await saveUnit(unitName.value)
  isSaveModalOpen.value = false
  unitName.value = ''
}

onMounted(async () => {
  await fetchAll()
})
</script>

<template>
  <div class="mb-3 flex justify-between">
    <h3 class="text-2xl font-bold">
      Units
    </h3>
    <div>
      <UModal v-model:open="isSaveModalOpen" title="Create new unit">
        <UButton label="Create new" @click="isSaveModalOpen = true" />

        <template #body>
          <UForm id="unitForm" @submit.prevent="handleSave">
            <div class="grid gap-4">
              <UFormField label="Unit">
                <UInput v-model="unitName" type="text" class="w-full" />
              </UFormField>
              <UButton type="submit" :loading="loadingSave" label="Save" form="unitForm" class="justify-center" />
            </div>
          </UForm>
        </template>
      </UModal>
    </div>
  </div>
  <UCard class="shadow-md shadow-slate-200 flex flex-col min-h-0 flex-1">
    <UTable
      :columns="columns"
      :data="units"
      class="overflow-y-auto"
      style="max-height: calc(100vh - 160px)"
      sticky
      :loading="loadingFetch"
      empty="No existing units. Click on Create New to create a new one."
    >
      <template #actions-cell="{ row }">
        <UButton
          icon="i-heroicons-pencil-square"
          size="xs"
          color="primary"
          variant="soft"
        />
        <UButton
          icon="i-heroicons-eye"
          size="xs"
          color="neutral"
          variant="soft"
          class="ml-2"
        />
        <UButton
          icon="i-heroicons-trash"
          size="xs"
          color="error"
          variant="soft"
          class="ml-2"
        />
      </template>
    </UTable>
  </UCard>
</template>
